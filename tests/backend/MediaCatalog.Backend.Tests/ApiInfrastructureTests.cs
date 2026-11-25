using System;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;
using MediaCatalog.Backend.Api.Filters;
using MediaCatalog.Backend.Api.Handlers;
using MediaCatalog.Backend.Infrastructure.Caching;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MediaCatalog.Backend.Tests
{
    [TestClass]
    public sealed class ApiInfrastructureTests
    {
        [TestMethod]
        public async Task RateLimitHandler_returns_429_with_retry_after_and_correlation_id()
        {
            var now = new DateTime(2026, 1, 1, 12, 0, 0, DateTimeKind.Utc);
            var handler = new RateLimitHandler(1, _ => "client-1", () => now)
            {
                InnerHandler = new SuccessHandler()
            };
            using (var invoker = new HttpMessageInvoker(handler))
            using (var firstRequest = CreateRequest("correlation-1"))
            using (var secondRequest = CreateRequest("correlation-2"))
            using (var firstResponse = await invoker.SendAsync(firstRequest, CancellationToken.None))
            using (var secondResponse = await invoker.SendAsync(secondRequest, CancellationToken.None))
            {
                Assert.AreEqual(HttpStatusCode.OK, firstResponse.StatusCode);
                Assert.AreEqual((HttpStatusCode)429, secondResponse.StatusCode);
                Assert.IsNotNull(secondResponse.Headers.RetryAfter);
                StringAssert.Contains(await secondResponse.Content.ReadAsStringAsync(), "correlation-2");
            }
        }

        [TestMethod]
        public async Task GlobalExceptionFilter_returns_consistent_safe_error_contract()
        {
            using (var request = CreateRequest("failure-correlation"))
            {
                var actionContext = new HttpActionContext
                {
                    ControllerContext = new HttpControllerContext { Request = request }
                };
                var executedContext = new HttpActionExecutedContext(actionContext, new InvalidOperationException("Sensitive detail"));

                new GlobalApiExceptionFilter().OnException(executedContext);

                Assert.AreEqual(HttpStatusCode.InternalServerError, executedContext.Response.StatusCode);
                var body = await executedContext.Response.Content.ReadAsStringAsync();
                StringAssert.Contains(body, "unexpected_error");
                StringAssert.Contains(body, "failure-correlation");
                Assert.IsFalse(body.Contains("Sensitive detail"));
            }
        }

        [TestMethod]
        public async Task MemoryResponseCache_reuses_value_within_its_lifetime()
        {
            var calls = 0;
            var key = "media-catalog-test-" + Guid.NewGuid();
            Func<Task<object>> factory = () =>
            {
                calls++;
                return Task.FromResult(new object());
            };

            var first = await MemoryResponseCache.GetOrCreateAsync(key, TimeSpan.FromMinutes(1), factory);
            var second = await MemoryResponseCache.GetOrCreateAsync(key, TimeSpan.FromMinutes(1), factory);

            Assert.AreSame(first, second);
            Assert.AreEqual(1, calls);
        }

        private static HttpRequestMessage CreateRequest(string correlationId)
        {
            var request = new HttpRequestMessage(HttpMethod.Get, "http://localhost/api/v1/test");
            request.SetConfiguration(new HttpConfiguration());
            request.Properties[RequestLoggingHandler.CorrelationIdProperty] = correlationId;
            return request;
        }

        private sealed class SuccessHandler : HttpMessageHandler
        {
            protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
            {
                return Task.FromResult(new HttpResponseMessage(HttpStatusCode.OK));
            }
        }
    }
}

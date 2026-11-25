using System;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using MediaCatalog.Backend.Infrastructure.Observability;

namespace MediaCatalog.Backend.Api.Handlers
{
    public sealed class RequestLoggingHandler : DelegatingHandler
    {
        public const string CorrelationIdProperty = "CorrelationId";
        public const string CorrelationHeader = "X-Correlation-ID";

        protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            var correlationId = request.Headers.TryGetValues(CorrelationHeader, out var values) ? values.FirstOrDefault() : null;
            if (string.IsNullOrWhiteSpace(correlationId)) correlationId = Guid.NewGuid().ToString("N");
            request.Properties[CorrelationIdProperty] = correlationId;
            var stopwatch = Stopwatch.StartNew();
            try
            {
                var response = await base.SendAsync(request, cancellationToken);
                stopwatch.Stop();
                response.Headers.Remove(CorrelationHeader);
                response.Headers.Add(CorrelationHeader, correlationId);
                StructuredLogger.Information("http_request_completed", new
                {
                    correlationId,
                    method = request.Method.Method,
                    path = request.RequestUri.AbsolutePath,
                    statusCode = (int)response.StatusCode,
                    elapsedMilliseconds = stopwatch.ElapsedMilliseconds
                });
                return response;
            }
            catch (Exception exception)
            {
                stopwatch.Stop();
                StructuredLogger.Error("http_request_failed", exception, new
                {
                    correlationId,
                    method = request.Method.Method,
                    path = request.RequestUri.AbsolutePath,
                    elapsedMilliseconds = stopwatch.ElapsedMilliseconds
                });
                throw;
            }
        }
    }
}

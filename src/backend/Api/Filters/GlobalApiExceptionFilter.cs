using System.Net;
using System.Net.Http;
using System.Web.Http.Filters;
using MediaCatalog.Backend.Api.Handlers;
using MediaCatalog.Backend.Api.Models;
using MediaCatalog.Backend.Infrastructure.Observability;

namespace MediaCatalog.Backend.Api.Filters
{
    public sealed class GlobalApiExceptionFilter : ExceptionFilterAttribute
    {
        public override void OnException(HttpActionExecutedContext context)
        {
            var correlationId = context.Request.Properties.TryGetValue(RequestLoggingHandler.CorrelationIdProperty, out var value) ? value as string : null;
            StructuredLogger.Error("unhandled_api_exception", context.Exception, new
            {
                correlationId,
                method = context.Request.Method.Method,
                path = context.Request.RequestUri.AbsolutePath
            });
            context.Response = context.Request.CreateResponse(HttpStatusCode.InternalServerError, new ApiError("unexpected_error", "An unexpected error occurred.", correlationId));
        }
    }
}

using System.Web.Http;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using MediaCatalog.Backend.Api.Filters;
using MediaCatalog.Backend.Api.Handlers;

namespace MediaCatalog.Backend.App_Start
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration configuration)
        {
            configuration.MessageHandlers.Add(new RequestLoggingHandler());
            configuration.MessageHandlers.Add(new RateLimitHandler());
            configuration.Filters.Add(new GlobalApiExceptionFilter());
            configuration.MapHttpAttributeRoutes();
            configuration.Formatters.Remove(configuration.Formatters.XmlFormatter);
            configuration.Formatters.JsonFormatter.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();
            configuration.Formatters.JsonFormatter.SerializerSettings.NullValueHandling = NullValueHandling.Ignore;
        }
    }
}

using System.Web.Http;
using MediaCatalog.Backend.Infrastructure.Composition;

namespace MediaCatalog.Backend.App_Start
{
    public static class DependencyConfig
    {
        public static void Register(HttpConfiguration configuration)
        {
            configuration.DependencyResolver = new ApiDependencyResolver();
        }
    }
}

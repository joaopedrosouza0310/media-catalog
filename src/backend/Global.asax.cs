using System.Data.Entity;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;
using MediaCatalog.Backend.App_Start;
using MediaCatalog.Backend.Infrastructure.Persistence;

namespace MediaCatalog.Backend
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            Database.SetInitializer(new MediaCatalogDatabaseInitializer());
            GlobalConfiguration.Configure(configuration =>
            {
                DependencyConfig.Register(configuration);
                WebApiConfig.Register(configuration);
            });
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }
    }
}

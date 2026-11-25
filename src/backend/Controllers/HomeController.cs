using System.Web.Mvc;

namespace MediaCatalog.Backend.Controllers
{
    public sealed class HomeController : Controller
    {
        public ActionResult Index() => View();
    }
}

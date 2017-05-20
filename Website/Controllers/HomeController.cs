using Microsoft.AspNetCore.Mvc;

namespace Commandlinefu.Website.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}

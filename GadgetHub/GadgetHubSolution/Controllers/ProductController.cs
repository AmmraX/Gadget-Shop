using System.Linq;
using System.Web.Http;
using GadgetHubSolution.Models;

namespace GadgetHubSolution.Controllers
{
    [RoutePrefix("api/products")]
    public class ProductController : ApiController
    {
        private readonly GadgetHubContext db = new GadgetHubContext();

        [HttpGet]
        [Route("all")]
        public IHttpActionResult GetAllProducts()
        {
            var products = db.Products.ToList();
            return Ok(products);
        }
    }
}


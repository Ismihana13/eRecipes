using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KatalogController : BaseCURDController<Katalog,KatalogSearchObject,KatalogUpsertRequest, KatalogUpsertRequest>
    {
        public KatalogController(IKatalogService service) : base(service) { }
    }
}

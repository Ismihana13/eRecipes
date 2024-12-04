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
    [AllowAnonymous]
    public class KategorijaController : BaseController<Kategorija,KategorijaSearchObject>
    {
        public KategorijaController(IKategorijaService service) : base(service) { }
      

    }
}

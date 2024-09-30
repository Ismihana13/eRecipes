using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class VrstaJelaController : BaseCURDController<VrstaJela,VrstaJelaSearchObject,VrsteJelaUpsertRequest,VrsteJelaUpsertRequest>
    {

        public VrstaJelaController(IVrstaJelaService service) : base(service) { }
        
        
    }
}

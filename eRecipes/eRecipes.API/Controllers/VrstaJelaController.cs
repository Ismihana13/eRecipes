using eRecipes.Model;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class VrstaJelaController : BaseController<VrstaJela,VrstaJelaSearchObject>
    {

        public VrstaJelaController(IVrstaJelaService service) : base(service) { }
        
        
    }
}

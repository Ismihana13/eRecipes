using eRecipes.Model;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class VrstaJelaController : ControllerBase
    {
        protected IVrstaJelaService _service;
        public VrstaJelaController(IVrstaJelaService service)
        {
            _service = service;
        }
        [HttpGet]
        public List<VrstaJela> GetList([FromQuery] VrstaJelaSearchObject searchObject)
        {
            return _service.GetList(searchObject);
        }
    }
}

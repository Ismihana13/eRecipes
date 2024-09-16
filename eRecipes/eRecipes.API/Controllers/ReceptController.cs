using eRecipes.Model;
using eRecipes.Service;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ReceptController : ControllerBase
    {
        protected IReceptService _service;
        public ReceptController(IReceptService service)
        {
            _service = service;
        }
        [HttpGet]
        public List<Recept> GetList()
        {
            return _service.GetList();
        }
    }
}

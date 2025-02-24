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
    [Authorize]
    public class ObavijestController 
    {
        private readonly IObavijestService _service;
        public ObavijestController(IObavijestService service)  
        {
            _service = service;
        }

        [HttpPost]
        public Model.Obavijest Insert([FromQuery] ObavijestInsertRequest request)
        {
                return _service.Insert(request);
        }

        [HttpGet]
        public ActionResult<List<Model.Obavijest>> Get([FromQuery] ObavijestSearchObject searchObject)
        {
            return _service.Get(searchObject);
        }

        [HttpPut("{id}/procitano")]
        public ActionResult<Model.Obavijest> UpdateProcitano(int id, [FromQuery] bool procitano)
        {
           return _service.UpdateProcitano(id, procitano);
        }

        [HttpDelete("{id}")]
        public Model.Obavijest Delete(int id)
        {
            return _service.Delete(id);
        }
    }
}

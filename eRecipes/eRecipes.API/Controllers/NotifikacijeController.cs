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
    public class NotifikacijeController 
    {
        private readonly INotifikacijeService _service;
        public NotifikacijeController(INotifikacijeService service)  
        {
            _service = service;
        }

        [HttpPost]
        public Model.Notifikacije Insert([FromQuery] NotifikacijeInsertRequest request)
        {
                return _service.Insert(request);
        }

        [Authorize(Roles = "Admin")]
        [HttpGet]
        public ActionResult<List<Model.Notifikacije>> Get([FromQuery] NotifikacijeSearchObject searchObject)
        {
            return _service.Get(searchObject);
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("{id}/procitano")]
        public ActionResult<Model.Notifikacije> UpdateProcitano(int id, [FromQuery] bool procitano)
        {
           return _service.UpdateProcitano(id, procitano);
        }

        [Authorize(Roles = "Admin")]
        [HttpDelete("{id}")]
        public Model.Notifikacije Delete(int id)
        {
            return _service.Delete(id);
        }
    }
}

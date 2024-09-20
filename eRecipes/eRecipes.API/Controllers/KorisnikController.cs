using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisnikController : ControllerBase
    {
        protected IKorisnikService _service;
        public KorisnikController(IKorisnikService service)
        {
            _service = service;
        }
        [HttpGet]
        public PagedResult<Korisnik> GetList([FromQuery] KorisnikSearchObject searchObject)
        {
            return _service.GetList(searchObject);
        }
        [HttpPost]
        public Korisnik Insert(KorisnikInsertRequest request)
        {

            return _service.Insert(request);
        }
        [HttpPut("{id}")]
        public Korisnik Update(int id, KorisnikUpdateRequest request)
        {
            return _service.Update(id, request);
        }
    }
}

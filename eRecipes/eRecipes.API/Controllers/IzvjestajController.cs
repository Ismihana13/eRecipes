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
    public class IzvjestajController
    {
        IIzvjestajService _service;
        public IzvjestajController(IIzvjestajService service)
        {
            _service = service;
        }

        [HttpPost]
        public async Task<Model.Izvjestaj> Insert([FromBody] IzvjestajInsert insert)
        {
            return await _service.Insert(insert);
        }

        [HttpGet]
        public async Task<List<Model.Izvjestaj>> GetIzvjestaji([FromQuery] IzvjestajSearchObject search)
        {
            return await _service.GetIzvjestajList(search);
        }
    }
}

using EasyNetQ.Events;
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
    public class RezervacijaProstoraController : BaseCURDController<RezervacijaProstora20022025, RezervacijaProstora20022025SearchObject, RezervacijaProstoraUpsertRequest, RezervacijaProstoraUpsertRequest>
    {
        public RezervacijaProstoraController(IRezervacijaProstoraService service) : base(service) { }
        [HttpGet("BrojRezervacija")]
        public async Task<IActionResult> GetBrojRezervacija()
        {
            var stats = await ((IRezervacijaProstoraService)_service).BrojRezervacije();
            return Ok(stats);
        }
    }
}

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
    public class Transakcije25062025Controller : BaseCURDController<Transakcija25062025, Transakcije25062025SearchObject, Transakcija25062025UpsertRequest, Transakcija25062025UpsertRequest>
    {
        public Transakcije25062025Controller(ITransakcije25062025Service service) : base(service) { }
        [HttpGet("ukupan-iznos")]
        public async Task<ActionResult> Iznos([FromQuery] Transakcije25062025SearchObject search)
        {
            var result=await ((ITransakcije25062025Service)_service).IznosPoKategoriji(search);
            return Ok(result);
        }


    }
}

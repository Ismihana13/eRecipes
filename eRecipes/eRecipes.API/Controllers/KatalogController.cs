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
    public class KatalogController : BaseCURDController<Katalog,KatalogSearchObject,KatalogUpsertRequest, KatalogUpsertRequest>
    {
        public KatalogController(IKatalogService service) : base(service) { }

        [HttpPost("{katalogId}/recepti")]
        public async Task<ActionResult> AddReceptToKatalog(int katalogId, [FromBody] List<int> receptIds)
        {
            var result = await ((IKatalogService)_service).AddReceptToKatalog(katalogId, receptIds);

            if (result == "Katalog nije pronađen." || result == "Neki od recepata nisu pronađeni.")
            {
                return BadRequest(result);
            }

            return Ok(result);
        }
    }
}

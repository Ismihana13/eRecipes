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

    public class OmiljeniReceptController : BaseCURDController<OmiljeniRecept,OmiljeniReceptSearchObject,OmiljeniReceptUpsertRequest, OmiljeniReceptUpsertRequest>
    {
        public OmiljeniReceptController(IOmiljeniReceptService service) : base(service) { }

        [HttpGet("getOmiljeniRecepti")]
        public async Task<ActionResult<List<Model.OmiljeniRecept>>> GetOmiljeniRecepti([FromQuery] OmiljeniReceptSearchObject search)
        {
            try
            {
                var omiljeniRecepti = await ((IOmiljeniReceptService)_service).GetFavoritesForCurrentUser( search);
                return Ok(omiljeniRecepti);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("removeFavorite/{receptId}")]
        public async Task<ActionResult> RemoveFavorite(int receptId)
        {
            try
            {
                await ((IOmiljeniReceptService)_service).RemoveFavorite(receptId);
                return Ok(new { message = "Recept je uspešno uklonjen iz omiljenih." });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}

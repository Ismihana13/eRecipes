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
    public class LajkoviController : BaseCURDController<Lajkovi,LajkoviSearchObject,LajkoviUpsertRequest, LajkoviUpsertRequest>
    {
        public LajkoviController(ILajkoviService service) : base(service) { }

        [HttpGet("{receptId}/likesCount")]
        public async Task<ActionResult<int>> GetLikesCountForRecipe(int receptId)
        {
             var likesCount = await ((ILajkoviService)_service).GetLikesCountForRecipe(receptId);
             return Ok(likesCount); 
        }

        [HttpDelete("{receptId}/removeLike")]
        public async Task<ActionResult> RemoveLikeFromRecipe(int receptId)
        {
             await ((ILajkoviService)_service).RemoveLiked(receptId);
                return Ok(new { message = "Recept je uspešno uklonjen iz lajkanih." });
        }

        [HttpGet("isLiked/{receptId}")]
        public async Task<ActionResult<bool>> IsLiked(int receptId)
        {
                bool isLiked = await ((ILajkoviService)_service).IsLiked(receptId);
                return Ok(isLiked);
        }
    }
}

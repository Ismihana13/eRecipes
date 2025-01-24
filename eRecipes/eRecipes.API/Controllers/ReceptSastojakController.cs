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
    //[AllowAnonymous]
    public class ReceptSastojakController : ControllerBase
    { 
        private readonly IReceptSastojakService _receptSastojakService;
        public ReceptSastojakController(IReceptSastojakService receptSastojakService)
        {
            _receptSastojakService = receptSastojakService;
        }
        [HttpPost]
        public async Task<IActionResult> AddReceptSastojak([FromBody] ReceptSastojakRequest request)
        {
            await _receptSastojakService.AddReceptSastojakAsync(request.ReceptId, request.SastojakId);
            return Ok();
        }
    }
}

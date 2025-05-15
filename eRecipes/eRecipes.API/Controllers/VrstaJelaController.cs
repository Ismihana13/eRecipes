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
    public class VrstaJelaController : BaseCURDController<VrstaJela, VrstaJelaSearchObject, VrsteJelaUpsertRequest, VrsteJelaUpsertRequest>
    {
        public VrstaJelaController(IVrstaJelaService service) : base(service) { }

        [Authorize(Roles = "Admin")]
        public override VrstaJela Insert(VrsteJelaUpsertRequest request)
        {
            return base.Insert(request);
        }

        public override PagedResult<VrstaJela> GetList([FromQuery] VrstaJelaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [HttpGet("{id}/broj-recepata")]
        public IActionResult GetBrojRecepataZaVrstuJela(int id)
        {
            var brojRecepata = ((IVrstaJelaService)_service).GetBrojRecepataZaVrstuJela(id);
            return Ok(brojRecepata);
        }

        [HttpPut("{id}/DeleteVrstaJela")]
        public VrstaJela DeleteVrstaJela(int id)
        {
            return ((IVrstaJelaService)_service).DeleteVrstaJela(id);
        }
    }
}

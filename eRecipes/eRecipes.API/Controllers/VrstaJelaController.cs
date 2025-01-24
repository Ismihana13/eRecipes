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
    public class VrstaJelaController : BaseCURDController<VrstaJela,VrstaJelaSearchObject,VrsteJelaUpsertRequest,VrsteJelaUpsertRequest>
    {
        public VrstaJelaController(IVrstaJelaService service) : base(service) { }

        [Authorize(Roles ="Admin")]
        public override VrstaJela Insert(VrsteJelaUpsertRequest request)
        {
            return base.Insert(request);
        }
        
       
        public override PagedResult<VrstaJela> GetList([FromQuery] VrstaJelaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }
    }
}

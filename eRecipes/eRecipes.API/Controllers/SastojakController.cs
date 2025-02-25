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
    public class SastojakController : BaseCURDController<Sastojak,SastojakSearchObject,SastojakUpsertRequest, SastojakUpsertRequest>
    {
        public SastojakController(ISastojakService service) : base(service) { }

        [Authorize(Roles ="Admin")]
        public override Sastojak Insert(SastojakUpsertRequest request)
        {
            return base.Insert(request);
        }
        public override PagedResult<Sastojak> GetList([FromQuery] SastojakSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }
    }
}

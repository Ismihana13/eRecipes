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
    public class UlogaController : BaseCURDController<Uloga, UlogaSearchObject, UlogaUpsertRequest, UlogaUpsertRequest>
    {
        public UlogaController(IUlogaService service) : base(service) { }

        public override PagedResult<Uloga> GetList([FromQuery] UlogaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }
    }
}

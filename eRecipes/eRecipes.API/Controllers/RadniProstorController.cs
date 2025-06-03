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
    public class RadniProstorController : BaseCURDController<RadniProstor, RadniProstorSearchObject, RadniProstorUpsertRequest, RadniProstorUpsertRequest>
    {
        public RadniProstorController(IRadniProstorService service) : base(service) { }

        
    }
}

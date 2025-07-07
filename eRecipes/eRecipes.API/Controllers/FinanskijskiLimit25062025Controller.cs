using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using eRecipes.Service.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class FinanskijskiLimit25062025Controller : BaseCURDController<Model.FinansijskiLimit25062025, FinansijskiLimit25062025SearchObject, FinansijskiLimit25062025UpsertRequest, FinansijskiLimit25062025UpsertRequest>
    {
        public FinanskijskiLimit25062025Controller(IFinansijskiLimit25062025Service service) : base(service) { }

        
    }
}

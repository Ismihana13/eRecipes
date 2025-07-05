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
    public class FinansijskiLimit25062025Controller : BaseCURDController<FinansijskiLimit25062026, FinansijskiLimit25062025SearchObject, FinansijskiLimit25062026UpsertRequest, FinansijskiLimit25062026UpsertRequest>
    {
        public FinansijskiLimit25062025Controller(IFinansijskiLimit25062025Service service) : base(service) { }

    
    }
}

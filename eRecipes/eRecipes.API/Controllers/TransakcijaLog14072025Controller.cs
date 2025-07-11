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
    public class TransakcijaLog14072025Controller : BaseCURDController<TransakcijaLog14072025, BaseSearchObject, TransakcijaLog14072025UpsertRequest, TransakcijaLog14072025UpsertRequest>
    {
        public TransakcijaLog14072025Controller(ITransakcijaLog14072025Service service) : base(service) { }
    }
}

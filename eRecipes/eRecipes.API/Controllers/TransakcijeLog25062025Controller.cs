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
    public class TransakcijeLog25062025Controller : BaseCURDController<TransakcijaLog25062025, TransakcijeLog25062025SearchObject, TransakcijaLog25062025UpsertRequest, TransakcijaLog25062025UpsertRequest>
    {
        public TransakcijeLog25062025Controller(ITransakcijaLog25062025Service service) : base(service) { }

    
    }
}

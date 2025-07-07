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
    public class TransakcijaLog25062025Controller : BaseCURDController<Model.TransakcijaLog25062025, TransakcijaLog25062025SearchObject, TransakcijaLog25062025UpsertRequest, TransakcijaLog25062025UpsertRequest>
    {
        public TransakcijaLog25062025Controller(ITransakcijaLog25062025Service service) : base(service) { }

        
    }
}

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
    public class KategorijaTransakcije25062025Controller : BaseCURDController<KategorijaTransakcije25062025, KategorijaTransakcije25062025SearchObject, KategorijaTransakcije25062025UpsertRequest, KategorijaTransakcije25062025UpsertRequest>
    {
        public KategorijaTransakcije25062025Controller(IKategorijaTransakcije25062025Service service) : base(service) { }

    
    }
}

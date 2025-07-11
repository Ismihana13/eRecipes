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
    public class KategorijaTransakcije14072025Controller : BaseCURDController<KategorijaTransakcije14072025, BaseSearchObject, KategorijaTransakcije14072025UpsertRequest, KategorijaTransakcije14072025UpsertRequest>
    {
        public KategorijaTransakcije14072025Controller(IKategorijaTransakcije14072025Service service) : base(service) { }
    }
}

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
    public class Transakcija14072025Controller : BaseCURDController<Transakcija14072025, Transakcija14072025SearchObject, Transakcija14072025UpsertRequest, Transakcija14072025UpsertRequest>
    {
        public Transakcija14072025Controller(ITransakcija14072025Service service) : base(service) { }
        [HttpGet("iznos")]
        public async Task<List<Statistika>> GetIznos(int? KategorijaTransakcije14072025Id)
        {
            var brojRecepata =await ((ITransakcija14072025Service)_service).GetIznos(KategorijaTransakcije14072025Id);
            return brojRecepata;
        }
    }
}

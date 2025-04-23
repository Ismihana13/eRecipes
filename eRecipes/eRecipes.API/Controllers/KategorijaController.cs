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
    public class KategorijaController : BaseCURDController<Kategorija,KategorijaSearchObject, KategorijaUpsertRequest, KategorijaUpsertRequest>
    {
        public KategorijaController(IKategorijaService service) : base(service) { }

        [HttpGet("{id}/broj-recepata")]
        public IActionResult GetBrojRecepataZaKategoriju(int id)
        {
            var brojRecepata = ((IKategorijaService)_service).GetBrojRecepataZaKategoriju(id);
            return Ok(brojRecepata);
        }

        [HttpPut("{id}/DeleteKategorija")]
        public Kategorija DeleteKategorija(int id)
        {
            return ((IKategorijaService)_service).DeleteKategorija(id);
        }
    }
}

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
    public class ReceptController : BaseCURDController<Recept,ReceptSearchObject,ReceptInsertRequest,ReceptUpdateRequest>
    {
        public ReceptController(IReceptService service):base(service)
        {
        }

        [HttpPost]
        public override Recept Insert(ReceptInsertRequest request)
        {
            return _service.Insert(request);
        }

        [HttpPut("{id}/DeleteRecept")]
        public Recept DeleteRecept(int id)
        {
            return ((IReceptService)_service).DeleteRecept(id);
        }

        [HttpGet("{receptId}/sastojci")]
        public ActionResult<List<ReceptSastojak>> GetSastojciForRecept(int receptId)
        {
            return ((IReceptService)_service).GetSastojciForRecept(receptId);
        }

        [HttpPost("{receptId}/sastojci")]
        public async Task<ActionResult> AddSastojkeToRecept(int receptId, [FromBody] List<ReceptSastojakInsertRequest> sastojciRequest)
        {
            var result = await ((IReceptService)_service).AddSastojkeToReceptAsync(receptId, sastojciRequest);

            if (result == "Recept nije pronađen." || result == "Neki od sastojaka nisu pronađeni.")
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpGet("{korisnikId}/recepti")]
        public ActionResult<List<Recept>> GetReceptiByKorisnikId(int korisnikId)
        {
            var recepti = ((IReceptService)_service).GetReceptiByKorisnikId(korisnikId);

            if (recepti == null || !recepti.Any())
            {
                return NotFound("No recipes found for this user.");
            }

            return Ok(recepti);
        }

        [HttpDelete("{id}/BrisanjeRecepta")]
        public Recept BrisanjeRecepta(int id)
        {
            return ((IReceptService)_service).BrisanjeRecepta(id);
        }

        [HttpPut("{receptId}/updateSastojci")]
        public async Task<ActionResult> UpdateSastojkeForRecept(int receptId, [FromBody] List<SastojakUpdateModel> sastojciRequest)
        {
            var result = await ((IReceptService)_service).UpdateSastojkeForReceptAsync(receptId, sastojciRequest);

            if (result == "Recept nije pronađen." || result == "Neki od sastojaka nisu pronađeni.")
            {
                return BadRequest(result);
            }
            return Ok(result);
        }


        [HttpGet("recommend/{korisnikId}")]
        public  IActionResult GetRecommendations(int korisnikId)
        {
            var preporuke = ((IReceptService)_service).Recommend(korisnikId);
            return Ok(preporuke);
        }

        [HttpGet("kolicina-i-mjerna-jedinica")]
        public async Task<IActionResult> GetKolicinaIMjernaJedinica(int receptId, int sastojakId)
        {
            var result = await ((IReceptService)_service).GetKolicinaIMjernaJedinicaAsync(receptId, sastojakId);

            if (result.Kolicina == null || result.MjernaJedinica == null)
            {
                return NotFound("Podaci o količini i mjernoj jedinici nisu pronađeni.");
            }

            return Ok(new { Kolicina = result.Kolicina, MjernaJedinica = result.MjernaJedinica });
        }
    }
}

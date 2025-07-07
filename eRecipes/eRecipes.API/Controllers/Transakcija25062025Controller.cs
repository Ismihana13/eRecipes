using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using eRecipes.Service.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
  
    public class Transakcija25062025Controller : BaseCURDController<Model.Transakcija25062025, Transakcija25062025SearchObject, Transakcija25062025UpsertRequest, Transakcija25062025UpsertRequest>
    {
        public Transakcija25062025Controller(ITransakcija25062025Service service) : base(service) { }

        public override Model.Transakcija25062025 Insert(Transakcija25062025UpsertRequest request)
        {
            try
            {
                return base.Insert(request);
            }
            catch (Exception ex)
            {
                // Možeš logirati grešku ako želiš: npr. _logger.LogError(ex, "Greška pri insertu transakcije");

                // Ako želiš drugačiju poruku:
                throw new Exception("Greška pri dodavanju transakcije: " + ex.Message);
            }
        }



        [HttpGet("broj")]
        public async Task<ActionResult> GetStat(int? KategorijaTransakcije25062025Id)
        {
           
               var broj= await ((ITransakcija25062025Service)_service).GetStat(KategorijaTransakcije25062025Id);
                return Ok(broj);
          
        }

    }
}

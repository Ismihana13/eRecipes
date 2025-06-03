using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.IdentityModel.Tokens;
using Microsoft.ML;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class RezervacijaProstoraService : BaseCRUDService<Model.RezervacijaProstora20022025, RezervacijaProstora20022025SearchObject, Database.RezervacijaProstora20022025, RezervacijaProstoraUpsertRequest, RezervacijaProstoraUpsertRequest>, IRezervacijaProstoraService
    {
        public RezervacijaProstoraService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<RezervacijaProstora20022025> AddFilter(RezervacijaProstora20022025SearchObject search, IQueryable<RezervacijaProstora20022025> query)
        {
            var filteredQuery = base.AddFilter(search, query);

           
            if (search?.KorisnikId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId == search.KorisnikId);
            }
            if (search?.RadniProstorId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.RadniProstorId == search.RadniProstorId);
            }
            if (search?.PretragaStatusRezervacije!=null)
            {
                filteredQuery = filteredQuery.Where(x => x.StatusRezervacije.Equals(search.PretragaStatusRezervacije.ToString()));
            }
            filteredQuery = filteredQuery.Include(r => r.Korisnik)
                                        .Include(r => r.RadniProstor);


            return filteredQuery;
        }
    

        public async Task<List<RezervacijaProstoraStatus>> BrojRezervacije()
        {
            var result = await Context.RezervacijaProstora20022025s
      .GroupBy(r => r.StatusRezervacije)
      .Select(g => new RezervacijaProstoraStatus
      {
          StatusRezervacije = g.Key,
          BrojPojavljivanja = g.Count()
      })
      .ToListAsync();

            return result;
        }
    }
}

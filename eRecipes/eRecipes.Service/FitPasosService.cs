using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class FitPasosService : BaseCRUDService<Model.FitPasos, FitPasosSearchObject, Database.FitPasos, FitPasosUpsertRequest, FitPasosUpsertRequest>, IFitPasosService
    {
        public FitPasosService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<FitPasos> AddFilter(FitPasosSearchObject search, IQueryable<FitPasos> query)
        {
            var filteredQuery= base.AddFilter(search, query);
            if (search?.KorisnikId != null)
            {
                filteredQuery=filteredQuery.Where(x=>x.KorisnikId==search.KorisnikId);
            }
            if(search?.DatumVazenja != null)
            {
                filteredQuery=filteredQuery.Where(x=>x.DatumIzdavanja.Date==search.DatumVazenja.Value.Date);
            }
            filteredQuery=filteredQuery.Include(x=>x.Korisnik);
            return filteredQuery;
        }
    }
}

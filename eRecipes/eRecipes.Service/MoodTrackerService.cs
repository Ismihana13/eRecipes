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
    public class MoodTrackerService : BaseCRUDService<Model.MoodTracker30012025, MoodTrackerSearchObject, Database.MoodTracker30012025, MoodTrackerUpsertRequest, MoodTrackerUpsertRequest>, IMoodTrackerService
    {
        public MoodTrackerService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<MoodTracker30012025> AddFilter(MoodTrackerSearchObject search, IQueryable<MoodTracker30012025> query)
        {
            var filteredQuery= base.AddFilter(search, query);
            if (search?.KorisnikId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId == search.KorisnikId);
            }
            if (search?.VrijednostRaspolozenja != null)
            {
                filteredQuery = filteredQuery.Where(x => x.VrijednostRaspolozenja.Equals(search.VrijednostRaspolozenja.ToString()));
            }
            if (search?.DatumEvidencije != null)
            {
                filteredQuery = filteredQuery.Where(x => x.DatumEvidencije == search.DatumEvidencije.Value.Date);
            }
            filteredQuery = filteredQuery.Include(x => x.Korisnik);
            return filteredQuery;
        }
        public override  void BeforeInsert(MoodTrackerUpsertRequest request, MoodTracker30012025 entity)
        {
            var brojPostojecih=  Context.MoodTracker30012025s.Where(x=>x.KorisnikId==request.KorisnikId
            && x.DatumEvidencije.Date==request.DatumEvidencije.Date).Count();

            if (brojPostojecih >=2)
            {
                throw new Exception("Korisnik ima vec unijetih raspolozenja za taj dan");
            }
            base.BeforeInsert(request, entity);
        }
   
    }
}

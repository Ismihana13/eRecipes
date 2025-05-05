using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class VrstaJelaService : BaseCRUDService<Model.VrstaJela, VrstaJelaSearchObject, Database.VrstaJela, VrsteJelaUpsertRequest, VrsteJelaUpsertRequest>, IVrstaJelaService
    {
        public VrstaJelaService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<VrstaJela> AddFilter(VrstaJelaSearchObject search, IQueryable<VrstaJela> query)
        {
            var filteredQuery = base.AddFilter(search, query);
            if (!string.IsNullOrWhiteSpace(search?.NazivGTE))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.NazivGTE.ToLower()));
            }
            if (search.Status.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.Status == search.Status);
            }
            if (search.StatusRecepta.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.Recepts.Any(r => r.Status == search.StatusRecepta));
            }
            return filteredQuery;
        }

        public int GetBrojRecepataZaVrstuJela(int vrstaJelaId)
        {
            var brojRecepata = Context.Recepts.Count(r => r.VrstaJelaId == vrstaJelaId && r.Status == true);
            return brojRecepata;
        }

        public Model.VrstaJela DeleteVrstaJela(int id)
        {
            var set = Context.Set<Database.VrstaJela>();

            var entity = set.Find(id);

            entity.Status = false;

            Context.SaveChanges();

            return Mapper.Map<Model.VrstaJela>(entity);
        }
    }
}

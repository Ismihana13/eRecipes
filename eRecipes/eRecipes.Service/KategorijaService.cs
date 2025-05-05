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
    public class KategorijaService : BaseCRUDService<Model.Kategorija, KategorijaSearchObject, Database.Kategorija, KategorijaUpsertRequest, KategorijaUpsertRequest>, IKategorijaService
    {
        public KategorijaService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public int GetBrojRecepataZaKategoriju(int kategorijaId)
        {
            var brojRecepata = Context.Recepts.Count(r => r.KategorijaId == kategorijaId && r.Status == true);
            return brojRecepata;
        }

        public override IQueryable<Kategorija> AddFilter(KategorijaSearchObject search, IQueryable<Kategorija> query)
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

        public Model.Kategorija DeleteKategorija(int id)
        {
            var set = Context.Set<Database.Kategorija>();

            var entity = set.Find(id);

            entity.Status = false;

            Context.SaveChanges();

            return Mapper.Map<Model.Kategorija>(entity);
        }
    }
}

using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class Transakcija14072025Service : BaseCRUDService<Model.Transakcija14072025, Transakcija14072025SearchObject, Database.Transakcija14072025, Transakcija14072025UpsertRequest, Transakcija14072025UpsertRequest>, ITransakcija14072025Service
    {
        public Transakcija14072025Service(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Database.Transakcija14072025> AddFilter(Transakcija14072025SearchObject search, IQueryable<Database.Transakcija14072025> query)
        {
            var upit= base.AddFilter(search, query);
            if (search?.KategorijaTransakcije14072025Id != null)
            {
                upit=upit.Where(x=>x.KategorijaTransakcije14072025Id==search.KategorijaTransakcije14072025Id);
            }
            if (search?.DatumDo != null)
            {
                upit = upit.Where(x => x.DatumTransakcije.Date <=search.DatumDo.Value.Date);
            }
            if (search?.DatumOd != null)
            {
                upit = upit.Where(x => x.DatumTransakcije.Date >= search.DatumOd.Value.Date);
            }
            upit = upit.Include(x => x.KategorijaTransakcije14072025);

            return upit;
        }
        public override void BeforeInsert(Transakcija14072025UpsertRequest request, Database.Transakcija14072025 entity)
        {
            var limit = Context.FinansijskiLimit14072025s.FirstOrDefault(x => x.KorisnikId == request.KorisnikId &&
            x.KategorijaTransakcije14072025Id == request.KategorijaTransakcije14072025Id);

            if (limit != null)
            {
                var start = new DateTime(request.DatumTransakcije.Year, request.DatumTransakcije.Month, 1);
                var end = start.AddMonths(1).AddDays(-1);

                var potroseno = Context.Transakcija14072025s.Where(y => y.KorisnikId == request.KorisnikId &&
                y.KategorijaTransakcije14072025Id == request.KategorijaTransakcije14072025Id &&
                y.DatumTransakcije >= start && y.DatumTransakcije <= end
                ).Sum(t => t.Iznos);

                var total = potroseno + request.Iznos;
                if (total > limit.Limit)
                {
                    throw new Exception("Premšili ste limit");
                }
            }
            base.BeforeInsert(request, entity);
        }

        public async Task<List<Statistika>> GetIznos(int? KategorijaTransakcije14072025Id)
        {
            if (KategorijaTransakcije14072025Id == null)
            {
                var iznos = await Context.Transakcija14072025s.GroupBy(x => x.KategorijaTransakcije14072025.Naziv)
              .Select(x => new Statistika
              {
                  Naziv = x.Key,
                  Iznos = x.Sum(t => t.Iznos),
              }
                  ).ToListAsync();
                return iznos;
            }
            else
            {
                var iznos = await Context.Transakcija14072025s.Where(x=>x.KategorijaTransakcije14072025Id==KategorijaTransakcije14072025Id).GroupBy(x => x.KategorijaTransakcije14072025.Naziv)
              .Select(x => new Statistika
              {
                  Naziv = x.Key,
                  Iznos = x.Sum(t => t.Iznos),
              }
                  ).ToListAsync();
                return iznos;
            }
          
        }
    }
}

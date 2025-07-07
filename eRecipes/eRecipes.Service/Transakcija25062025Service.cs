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
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class Transakcija25062025Service : BaseCRUDService<Model.Transakcija25062025,Transakcija25062025SearchObject, Database.Transakcija25062025, Transakcija25062025UpsertRequest, Transakcija25062025UpsertRequest>, ITransakcija25062025Service
    {
        public Transakcija25062025Service(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Database.Transakcija25062025> AddFilter(Transakcija25062025SearchObject search, IQueryable<Database.Transakcija25062025> query)
        {
            var filteredQuery= base.AddFilter(search, query);

            if (search?.KategorijaTransakcije25062025Id != null)
            {
                filteredQuery=filteredQuery.Where(x=>x.KategorijaTransakcije25062025Id == search.KategorijaTransakcije25062025Id);
            }
            if (search?.DatumDo != null)
            {
                filteredQuery=filteredQuery.Where(x=>x.DatumTransakcije.Date<= search.DatumDo.Value.Date);
            }
            if (search?.DatumOd != null)
            {
                filteredQuery = filteredQuery.Where(x=>x.DatumTransakcije.Date>= search.DatumOd.Value.Date);
            }
            filteredQuery = filteredQuery.Include(x => x.KategorijaTransakcije25062025);

            return filteredQuery;
        }
        public override void BeforeInsert(Transakcija25062025UpsertRequest request, Database.Transakcija25062025 entity)
        {
            var limit = Context.FinansijskiLimit25062025s.FirstOrDefault(x => x.KorisnikId == request.KorisnikId &&
            x.KategorijaTransakcije25062025Id == request.KategorijaTransakcije25062025Id);

            if (limit!=null)
            {
                var start = new DateTime(request.DatumTransakcije.Year, request.DatumTransakcije.Month, 1);
                var end = start.AddMonths(1).AddDays(-1);

                var potroseno = Context.Transakcija25062025s.Where(x => x.KorisnikId == request.KorisnikId &&
                x.KategorijaTransakcije25062025Id == request.KategorijaTransakcije25062025Id &&
                x.DatumTransakcije >= start && x.DatumTransakcije <= end).Sum(y => y.Iznos);

                var noviTotal = potroseno + request.Iznos;
                if (noviTotal > limit.Limit)
                {
                    throw new Exception("Premasili ste limit");
                }
                if (noviTotal >= limit.Limit * 0.9m)
                {
                    throw new Exception("Upozorenje");
                }
            }
            base.BeforeInsert(request, entity);
        }
        public async Task<List<StatKategorija>> GetStat(int? KategorijaTransakcije25062025Id)
        {
            if (KategorijaTransakcije25062025Id == null)
            {
                var broj = await Context.Transakcija25062025s
                    .GroupBy(x => x.KategorijaTransakcije25062025.Naziv)
                    .Select(y => new StatKategorija
                    {
                        Naziv = y.Key,
                        Iznos = y.Sum(z => z.Iznos)
                    })
                    .ToListAsync();

                return broj;
            }
            else
            {
                var broj = await Context.Transakcija25062025s
                    .Where(x => x.KategorijaTransakcije25062025Id == KategorijaTransakcije25062025Id)
                    .GroupBy(x => x.KategorijaTransakcije25062025.Naziv)
                    .Select(y => new StatKategorija
                    {
                        Naziv = y.Key,
                        Iznos = y.Sum(z => z.Iznos)
                    })
                    .ToListAsync();

                return broj;
            }
        }

    }
}

using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;
using Microsoft.ML;
using Microsoft.ML.Data;
using System.CodeDom;

namespace eRecipes.Service
{
    public class ReceptService : BaseCRUDService<Model.Recept, ReceptSearchObject, Database.Recept, ReceptInsertRequest, ReceptUpdateRequest>, IReceptService
    {
        
        ILogger<ReceptService> _logger;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IKorisnikService _korisnikService;
        private readonly ReceptRecommender _recommender;
        public ReceptService(ERecipesContext context, IMapper mapper, ILogger<ReceptService> logger, IHttpContextAccessor httpContextAccessor, IKorisnikService korisnikService) : base(context, mapper) {
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
            _korisnikService = korisnikService;
            _recommender = new ReceptRecommender(Context);
        }

        public override IQueryable<Database.Recept> AddFilter(ReceptSearchObject search, IQueryable<Database.Recept> query)
        {
            var filteredQuery = base.AddFilter(search, query);
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().StartsWith(search.FTS.ToLower()));
            }
            if (search.Status.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.Status == search.Status);
            }
            if (search.KategorijaId.HasValue)
            {
                filteredQuery = filteredQuery.Where(r => r.KategorijaId == search.KategorijaId.Value);
            }
            if (search.VrstaJelaId.HasValue)
            {
                filteredQuery = filteredQuery.Where(r => r.VrstaJelaId == search.VrstaJelaId.Value);
            }
            filteredQuery = filteredQuery.Include(r => r.VrstaJela)
                                 .Include(r => r.Kategorija)
                                 .Include(r => r.Kategorija).Include(r=>r.Korisnik);
            return filteredQuery;
        }

        public override void BeforeInsert(ReceptInsertRequest request, Recept entity)
        {
            entity.DatumObjave = DateTime.Now;
            entity.Status = true;

            var userIdClaim = _httpContextAccessor.HttpContext.User?.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim != null)
            {
                string username = userIdClaim.Value;
                var user = _korisnikService.GetByUsername(username);
                if (user != null)
                {
                    entity.KorisnikId = user.KorisnikId;
                }
            }
            base.BeforeInsert(request, entity);
        }
        public override void BeforeUpdate(ReceptUpdateRequest request, Recept entity)
        {
            entity.DatumObjave = DateTime.Now;
            base.BeforeUpdate(request, entity);
        }

        public Model.Recept DeleteRecept(int id)
        {
            var set = Context.Set<Database.Recept>();

            var entity = set.Find(id);

            entity.Status = false;

            Context.SaveChanges();

            return Mapper.Map<Model.Recept>(entity);
        }

        public List<Model.ReceptSastojak> GetSastojciForRecept(int receptId)
        {
            var receptSastojci = Context.ReceptSastojaks
                                         .Where(rs => rs.ReceptId == receptId)
                                         .Include(rs => rs.Sastojak)  
                                         .ToList();
            return Mapper.Map<List<Model.ReceptSastojak>>(receptSastojci);
        }
        public async Task<string> AddSastojkeToReceptAsync(int receptId, List<int> sastojakIds)
        {
            var recept = await Context.Recepts.Include(r => r.ReceptSastojaks)
                                                .FirstOrDefaultAsync(r => r.ReceptId == receptId);

            if (recept == null)
            {
                return "Recept nije pronađen.";
            }

            var sastojci = await Context.Sastojaks.Where(s => sastojakIds.Contains(s.SastojakId)).ToListAsync();

            if (sastojci.Count != sastojakIds.Count)
            {
                return "Neki od sastojaka nisu pronađeni.";
            }
            var existingSastojaks = await Context.ReceptSastojaks
                                        .Where(rs => rs.ReceptId == receptId)
                                        .Select(rs => rs.SastojakId)
                                        .ToListAsync();
            foreach (var sastojak in sastojci)
            {
                if (!existingSastojaks.Contains(sastojak.SastojakId))
                {
                    var receptSastojak = new ReceptSastojak
                    {
                        ReceptId = receptId,
                        SastojakId = sastojak.SastojakId
                    };
                    Context.ReceptSastojaks.Add(receptSastojak);
                }
            }

            await Context.SaveChangesAsync();

            return "Sastojci su uspješno dodani.";
        }
        public List<Model.Recept> GetReceptiByKorisnikId(int korisnikId)
        {
            var recepti = Context.Recepts
                                 .Where(r => r.KorisnikId == korisnikId && r.Status == true) 
                                 .Include(r => r.VrstaJela)  
                                 .Include(r => r.Kategorija)
                                 .ToList();

            return Mapper.Map<List<Model.Recept>>(recepti);
        }
        public Model.Recept BrisanjeRecepta(int id)
        {
            var recept = Context.Recepts.Find(id);
            if (recept == null)
            {
                throw new Exception("Recept nije pronađen.");
            }

            Context.Recepts.Remove(recept);
          Context.SaveChanges(); 
            return Mapper.Map<Model.Recept>(recept);
        }
        public async Task<string> UpdateSastojkeForReceptAsync(int receptId, List<int> sastojakIds)
        {
            var recept = await Context.Recepts.Include(r => r.ReceptSastojaks)
                                               .FirstOrDefaultAsync(r => r.ReceptId == receptId);

            if (recept == null)
            {
                return "Recept nije pronađen.";
            }

            var existingSastojaks = await Context.ReceptSastojaks
                                                 .Where(rs => rs.ReceptId == receptId)
                                                 .ToListAsync();
            var sastojci = await Context.Sastojaks
                                        .Where(s => sastojakIds.Contains(s.SastojakId))
                                        .ToListAsync();
            if (sastojci.Count != sastojakIds.Count)
            {
                return "Neki od sastojaka nisu pronađeni.";
            }
            var sastojakIdsToRemove = existingSastojaks
                                        .Where(rs => !sastojakIds.Contains(rs.SastojakId))
                                        .Select(rs => rs.SastojakId)
                                        .ToList();

            if (sastojakIdsToRemove.Any())
            {
                var receptSastojaksToRemove = existingSastojaks
                                                .Where(rs => sastojakIdsToRemove.Contains(rs.SastojakId))
                                                .ToList();
                Context.ReceptSastojaks.RemoveRange(receptSastojaksToRemove);
            }
            var sastojakIdsToAdd = sastojci
                                   .Where(s => !existingSastojaks.Any(rs => rs.SastojakId == s.SastojakId))
                                   .ToList();

            foreach (var sastojak in sastojakIdsToAdd)
            {
                var receptSastojak = new ReceptSastojak
                {
                    ReceptId = receptId,
                    SastojakId = sastojak.SastojakId
                };
                Context.ReceptSastojaks.Add(receptSastojak);
            }
            await Context.SaveChangesAsync();

            return "Sastojci su uspješno ažurirani.";
        }
        public List<Recept> Recommend(int korisnikId)
        {
            return _recommender.Recommend(korisnikId);
        }

        List<Model.Recept> IReceptService.Recommend(int korisnikId)
        {
            var preporuceniRecepti = _recommender.Recommend(korisnikId); // Ovo vraća List<Database.Recept>
            return Mapper.Map<List<Model.Recept>>(preporuceniRecepti);
        }

        //static MLContext mlContext = null;
        //static object isLocked=new object();
        //public List<Model.Recept> Recommend(int id)
        //{
        //    if (mlContext == null) 
        //    {
        //        //train
        //        lock (isLocked)
        //        {
        //            mlContext = new MLContext();
        //            var tmpData=Context.Kategorijas.Include("Recepts").ToList();
        //            var data=new List<ProductEntry>();
        //            foreach (var item in tmpData)
        //            {
        //                if(item.Katego)
        //            }

        //        }

        //    }

        //}
        //public class Copurchase_prediction
        //{
        //    public float Score { get; set; }
        //}
        //public class ProductEntry
        //{
        //    [KeyType(count:262111)]
        //    public uint ProductID { get; set; }
        //    [KeyType(count: 262111)]
        //    public uint CoPurchaseProductID { get; set; }
        //}
    }
}

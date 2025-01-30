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

namespace eRecipes.Service
{
    public class ReceptService : BaseCRUDService<Model.Recept, ReceptSearchObject, Database.Recept, ReceptInsertRequest, ReceptUpdateRequest>, IReceptService
    {
        
        ILogger<ReceptService> _logger;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IKorisnikService _korisnikService;
        public ReceptService(ERecipesContext context, IMapper mapper, ILogger<ReceptService> logger, IHttpContextAccessor httpContextAccessor, IKorisnikService korisnikService) : base(context, mapper) {
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
            _korisnikService = korisnikService;
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

            // Dohvati postojeće sastojke povezane s receptom
            var existingSastojaks = await Context.ReceptSastojaks
                                                 .Where(rs => rs.ReceptId == receptId)
                                                 .ToListAsync();

            // Dohvati sve sastojke koji su poslani u listi
            var sastojci = await Context.Sastojaks
                                        .Where(s => sastojakIds.Contains(s.SastojakId))
                                        .ToListAsync();

            // Provjera da li su svi sastojci prisutni u bazi
            if (sastojci.Count != sastojakIds.Count)
            {
                return "Neki od sastojaka nisu pronađeni.";
            }

            // 1. Brisanje sastojaka koji nisu u novoj listi
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

            // 2. Dodavanje novih sastojaka koji nisu u bazi
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

            // Spremanje promjena u bazu
            await Context.SaveChangesAsync();

            return "Sastojci su uspješno ažurirani.";
        }
    }
}

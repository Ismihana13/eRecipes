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
        private readonly INotifikacijeService _obavjestService;
        public ReceptService(ERecipesContext context, IMapper mapper, ILogger<ReceptService> logger, IHttpContextAccessor httpContextAccessor, IKorisnikService korisnikService, INotifikacijeService obavjestService) : base(context, mapper)
        {
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
            _korisnikService = korisnikService;
            _recommender = new ReceptRecommender(Context);
            _obavjestService = obavjestService;
        }

        public override IQueryable<Database.Recept> AddFilter(ReceptSearchObject search, IQueryable<Database.Recept> query)
        {
            var filteredQuery = base.AddFilter(search, query);
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                var ftsLower = search.FTS.ToLower();
                filteredQuery = filteredQuery.Where(x =>
                    x.Naziv.ToLower().Contains(ftsLower) ||
                    x.OpisRecepta.ToLower().Contains(ftsLower)
                );
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
                    var obavijestRequest = new NotifikacijeInsertRequest
                    {
                        Naslov = "Novi recept dodat!",
                        Sadrzaj = $"{user.KorisnickoIme} je dodao novi recept: {request.Naziv}",
                        DatumSlanja = DateTime.Now,
                        KorisnikId = user.KorisnikId
                    };
                    _obavjestService.Insert(obavijestRequest);
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
                                         .Include(rs => rs.MjernaJedinica)
                                         .ToList();
            return Mapper.Map<List<Model.ReceptSastojak>>(receptSastojci);
        }

        public async Task<string> AddSastojkeToReceptAsync(int receptId, List<ReceptSastojakInsertRequest> sastojciRequest)
        {
            var recept = await Context.Recepts.Include(r => r.ReceptSastojaks)
                                                .FirstOrDefaultAsync(r => r.ReceptId == receptId);

            if (recept == null)
            {
                return "Recept nije pronađen.";
            }

            var sastojakIds = sastojciRequest.Select(x => x.SastojakId).ToList();
            var sastojci = await Context.Sastojaks
                .Where(s => sastojakIds.Contains(s.SastojakId))
                .ToListAsync();

            if (sastojci.Count != sastojakIds.Count)
            {
                return "Neki od sastojaka nisu pronađeni.";
            }
            var existingSastojaks = await Context.ReceptSastojaks
                                        .Where(rs => rs.ReceptId == receptId)
                                        .Select(rs => rs.SastojakId)
                                        .ToListAsync();
            foreach (var req in sastojciRequest)
            {
                if (!existingSastojaks.Contains(req.SastojakId))
                {
                    var receptSastojak = new ReceptSastojak
                    {
                        ReceptId = receptId,
                        SastojakId = req.SastojakId,
                        MjernaJedinicaId = req.MjernaJedinicaId,
                        Kolicina = req.Kolicina
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

        public async Task<string> UpdateSastojkeForReceptAsync(int receptId, List<SastojakUpdateModel> sastojciZaUpdate)
        {
            // Dohvaćanje recepta s pripadajućim sastojcima
            var recept = await Context.Recepts.Include(r => r.ReceptSastojaks)
                                               .FirstOrDefaultAsync(r => r.ReceptId == receptId);

            if (recept == null)
            {
                return "Recept nije pronađen.";
            }

            // Dohvaćanje postojećih sastojaka za taj recept
            var existingSastojaks = await Context.ReceptSastojaks
                                                 .Where(rs => rs.ReceptId == receptId)
                                                 .ToListAsync();

            // Provjera ako su svi sastojci iz primljenih podataka prisutni u bazi
            var sastojci = await Context.Sastojaks
                                        .Where(s => sastojciZaUpdate.Select(x => x.SastojakId).Contains(s.SastojakId))
                                        .ToListAsync();

            if (sastojci.Count != sastojciZaUpdate.Count)
            {
                return "Neki od sastojaka nisu pronađeni.";
            }

            // Brisanje sastojaka koji više nisu povezani s receptom
            var sastojakIdsToRemove = existingSastojaks
                                        .Where(rs => !sastojciZaUpdate.Select(x => x.SastojakId).Contains(rs.SastojakId))
                                        .Select(rs => rs.SastojakId)
                                        .ToList();

            if (sastojakIdsToRemove.Any())
            {
                var receptSastojaksToRemove = existingSastojaks
                                                .Where(rs => sastojakIdsToRemove.Contains(rs.SastojakId))
                                                .ToList();
                Context.ReceptSastojaks.RemoveRange(receptSastojaksToRemove);
            }

            // Ažuriranje postojećih sastojaka
            foreach (var sastojakUpdate in sastojciZaUpdate)
            {
                var receptSastojak = existingSastojaks
                                        .FirstOrDefault(rs => rs.SastojakId == sastojakUpdate.SastojakId);

                if (receptSastojak != null)
                {
                    // Ažuriranje količine i mjerne jedinice
                    receptSastojak.Kolicina = sastojakUpdate.Kolicina;
                    receptSastojak.MjernaJedinicaId = sastojakUpdate.MjernaJedinicaId;
                    Context.ReceptSastojaks.Update(receptSastojak);
                }
                else
                {
                    // Ako sastojak nije u postojećim, dodajemo ga
                    var newReceptSastojak = new ReceptSastojak
                    {
                        ReceptId = receptId,
                        SastojakId = sastojakUpdate.SastojakId,
                        Kolicina = sastojakUpdate.Kolicina,
                        MjernaJedinicaId = sastojakUpdate.MjernaJedinicaId
                    };
                    Context.ReceptSastojaks.Add(newReceptSastojak);
                }
            }

            // Spremanje promjena
            await Context.SaveChangesAsync();

            return "Sastojci su uspješno ažurirani.";
        }


        public List<Recept> Recommend(int korisnikId)
        {
            return _recommender.Recommend(korisnikId);
        }

        List<Model.Recept> IReceptService.Recommend(int korisnikId)
        {
            var preporuceniRecepti = _recommender.Recommend(korisnikId); 
            return Mapper.Map<List<Model.Recept>>(preporuceniRecepti);
        }

        public async Task<(double? Kolicina, int MjernaJedinica)> GetKolicinaIMjernaJedinicaAsync(int receptId, int sastojakId)
        {
            var receptSastojak = await Context.ReceptSastojaks
                .Where(rs => rs.ReceptId == receptId && rs.SastojakId == sastojakId)
                .FirstOrDefaultAsync();

            if (receptSastojak == null)
            {
                return (null, 0);
            }

            return (receptSastojak.Kolicina, receptSastojak.MjernaJedinicaId); 
        }

    }
}

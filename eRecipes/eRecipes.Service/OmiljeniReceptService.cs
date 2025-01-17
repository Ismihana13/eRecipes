using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class OmiljeniReceptService : BaseCRUDService<Model.OmiljeniRecept, OmiljeniReceptSearchObject, Database.OmiljeniRecept, OmiljeniReceptUpsertRequest, OmiljeniReceptUpsertRequest>, IOmiljeniReceptService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IKorisnikService _korisnikService;
        public OmiljeniReceptService(ERecipesContext context, IMapper mapper, IHttpContextAccessor httpContextAccessor, IKorisnikService korisnikService) : base(context, mapper)
        {
            _httpContextAccessor = httpContextAccessor;
            _korisnikService = korisnikService;
        }
        public override IQueryable<Database.OmiljeniRecept> AddFilter(OmiljeniReceptSearchObject search, IQueryable<Database.OmiljeniRecept> query)
        {
            var filteredQuery = base.AddFilter(search, query);
            filteredQuery = filteredQuery.Include(x => x.Recept);
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.Recept.Naziv.ToLower().StartsWith(search.FTS.ToLower()));
            }
            
            return filteredQuery;
        }
        public override void BeforeInsert(OmiljeniReceptUpsertRequest request, OmiljeniRecept entity)
        {
            // Postavljanje trenutnog datuma
            entity.DatumDodavanja = DateTime.Now;

            // Proveravamo da li HttpContext i HttpContext.User nisu null
            var userIdClaim = _httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.NameIdentifier);

            // Ako korisnik nije logovan, userIdClaim će biti null
            if (userIdClaim != null)
            {
                string username = userIdClaim.Value;

                // Proveravamo da li je korisnik pronađen
                var user = _korisnikService.GetByUsername(username);
                if (user != null)
                {
                    // Ako je korisnik pronađen, postavljamo korisnički ID u entitet
                    entity.KorisnikId = user.KorisnikId;

                    // Proveravamo da li je ovaj recept već u omiljenima tog korisnika
                  //  bool exists = Context.OmiljeniRecepts
                     //   .Any(omiljeni => omiljeni.KorisnikId == user.KorisnikId && omiljeni.ReceptId == entity.ReceptId);

                    //if (exists)
                   // {
                        // Ako recept već postoji u omiljenima, bacite izuzetak
                     //   throw new Exception("Recept je već u vašim omiljenim.");
                   // }
                }
                else
                {
                    // Ako korisnik nije pronađen, možete baciti izuzetak
                    throw new Exception("Korisnik nije pronađen.");
                }
            }
            else
            {
                // Ako korisnik nije logovan, bacite izuzetak ili obavestite korisnika
                throw new Exception("Korisnik nije logovan.");
            }

            // Pozivanje osnovne implementacije za unos
            base.BeforeInsert(request, entity);
        }

        public async Task<List<Model.OmiljeniRecept>> GetFavoritesForCurrentUser(OmiljeniReceptSearchObject searchObject)
        {
            // Dohvat korisničkog ID-a iz tokena ili sesije
            var userIdClaim = _httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.NameIdentifier);

            if (userIdClaim == null)
            {
                throw new Exception("Korisnik nije logovan.");
            }

            string username = userIdClaim.Value;

            // Dohvat korisnika prema username-u
            var user = _korisnikService.GetByUsername(username);

            if (user == null)
            {
                throw new Exception("Korisnik nije pronađen.");
            }

            // Filtriranje omiljenih recepata za ovog korisnika
            var omiljeniReceptiQuery = Context.OmiljeniRecepts
       .Include(omiljeni => omiljeni.Recept)  // Uključivanje Recepta pre filtriranja
       .Where(omiljeni => omiljeni.KorisnikId == user.KorisnikId);

            // Apply filter for FTS if provided
            if (!string.IsNullOrWhiteSpace(searchObject?.FTS))
            {
                omiljeniReceptiQuery = omiljeniReceptiQuery
                    .Where(omiljeni => omiljeni.Recept.Naziv.ToLower().Contains(searchObject.FTS.ToLower()));  // Filtriranje po nazivu recepta
            }
            var omiljeniRecepti = await omiljeniReceptiQuery.ToListAsync();

            // Mapiranje omiljenih recepata u model koji će se vratiti
            return Mapper.Map<List<Model.OmiljeniRecept>>(omiljeniRecepti);
        }

        public async Task RemoveFavorite(int receptId)
        {
            var userIdClaim = _httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.NameIdentifier);

            if (userIdClaim == null)
            {
                throw new Exception("Korisnik nije logovan.");
            }

            string username = userIdClaim.Value;

            var user = _korisnikService.GetByUsername(username);

            if (user == null)
            {
                throw new Exception("Korisnik nije pronađen.");
            }

            var favoriteToRemove = await Context.OmiljeniRecepts
                .FirstOrDefaultAsync(omiljeni => omiljeni.KorisnikId == user.KorisnikId && omiljeni.ReceptId == receptId);

            if (favoriteToRemove == null)
            {
                throw new Exception("Ovaj recept nije u vašim omiljenim.");
            }

            Context.OmiljeniRecepts.Remove(favoriteToRemove);
            await Context.SaveChangesAsync();
        }

    }
}

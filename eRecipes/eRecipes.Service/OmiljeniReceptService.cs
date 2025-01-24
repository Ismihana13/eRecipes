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
            entity.DatumDodavanja = DateTime.Now;
            var userIdClaim = _httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim != null)
            {
                string username = userIdClaim.Value;
                var user = _korisnikService.GetByUsername(username);
                if (user != null)
                {
                    entity.KorisnikId = user.KorisnikId;
                }
                else
                {
                    throw new Exception("Korisnik nije pronađen.");
                }
            }
            else
            {
                throw new Exception("Korisnik nije logovan.");
            }
            base.BeforeInsert(request, entity);
        }

        public async Task<List<Model.OmiljeniRecept>> GetFavoritesForCurrentUser(OmiljeniReceptSearchObject searchObject)
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

            var omiljeniReceptiQuery = Context.OmiljeniRecepts
                                .Include(omiljeni => omiljeni.Recept)
                                .Include(omiljeni=>omiljeni.Recept.Kategorija)
                                .Include(omiljeni=> omiljeni.Recept.VrstaJela)
                                .Where(omiljeni => omiljeni.KorisnikId == user.KorisnikId);

            if (!string.IsNullOrWhiteSpace(searchObject?.FTS))
            {
                omiljeniReceptiQuery = omiljeniReceptiQuery
                    .Where(omiljeni => omiljeni.Recept.Naziv.ToLower().Contains(searchObject.FTS.ToLower()));  
            }
            if (searchObject.KategorijaId.HasValue)
            {
                omiljeniReceptiQuery=omiljeniReceptiQuery.Where(omiljeni=>omiljeni.Recept.KategorijaId==searchObject.KategorijaId.Value);
            }
            if (searchObject.VrstaJelaId.HasValue)
            {
                omiljeniReceptiQuery = omiljeniReceptiQuery.Where(omiljeni => omiljeni.Recept.VrstaJelaId == searchObject.VrstaJelaId.Value);
            }
            var omiljeniRecepti = await omiljeniReceptiQuery.ToListAsync();

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

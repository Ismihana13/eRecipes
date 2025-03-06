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
    public class LajkoviService : BaseCRUDService<Model.Lajkovi, LajkoviSearchObject, Database.Lajkovi, LajkoviUpsertRequest, LajkoviUpsertRequest>, ILajkoviService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IKorisnikService _korisnikService;
        public LajkoviService(ERecipesContext context, IMapper mapper, IHttpContextAccessor httpContextAccessor, IKorisnikService korisnikService) : base(context, mapper)
        {
            _httpContextAccessor = httpContextAccessor;
            _korisnikService = korisnikService;
        }
       
        public override void BeforeInsert(LajkoviUpsertRequest request, Lajkovi entity)
        {
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

        public async Task<int> GetLikesCountForRecipe(int receptId)
        {
            var recept = await Context.Recepts.FindAsync(receptId);
            if (recept == null)
            {
                throw new Exception("Recept nije pronađen.");
            }
            int likesCount = await Context.Lajkovis
                .Where(l => l.ReceptId == receptId)
                .CountAsync();

            return likesCount;
        }

        public async Task RemoveLiked(int receptId)
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

            var favoriteToRemove = await Context.Lajkovis
                .FirstOrDefaultAsync(like => like.KorisnikId == user.KorisnikId && like.ReceptId == receptId);

            if (favoriteToRemove == null)
            {
                throw new Exception("Ovaj recept nije u vašim lajkanim.");
            }

            Context.Lajkovis.Remove(favoriteToRemove);
            await Context.SaveChangesAsync();
        }

        public async Task<bool> IsLiked(int receptId)
        {
            var userIdClaim = _httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.NameIdentifier);

            if (userIdClaim == null)
            {
                throw new Exception("Korisnik nije logovan.");
            }

            string username = userIdClaim.Value; 
            var user =  _korisnikService.GetByUsername(username);

            if (user == null)
            {
                throw new Exception("Korisnik nije pronađen.");
            }

            var lajk = await Context.Lajkovis.FirstOrDefaultAsync(l => l.ReceptId == receptId && l.KorisnikId == user.KorisnikId); 
            return lajk != null;
        }
    }
}

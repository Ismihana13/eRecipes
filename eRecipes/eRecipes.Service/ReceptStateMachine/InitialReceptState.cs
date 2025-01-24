//using eRecipes.Model;
//using eRecipes.Model.Requests;
//using MapsterMapper;
//using Microsoft.AspNetCore.Http;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Security.Claims;
//using System.Text;
//using System.Threading.Tasks;

//namespace eRecipes.Service.ReceptStateMachine
//{
//    public class InitialReceptState : BaseReceptState
//    {
//        private readonly IHttpContextAccessor _httpContextAccessor;
//        private readonly IKorisnikService _korisnikService;
//        public InitialReceptState(Database.ERecipesContext context, IMapper mapper, IServiceProvider serviceProvider,IHttpContextAccessor httpContextAccessor,IKorisnikService korisnikService) : base(context, mapper, serviceProvider)
//        {
//            _httpContextAccessor = httpContextAccessor;
//            _korisnikService = korisnikService;
//        }

//        public override Recept Insert(ReceptInsertRequest request)
//        {
//            var set = Context.Set<Database.Recept>();
//            var entity = Mapper.Map<Database.Recept>(request);
//            entity.DatumObjave = DateTime.Now;
//            entity.Status = true;
            
//            var userIdClaim = _httpContextAccessor.HttpContext.User?.FindFirst(ClaimTypes.NameIdentifier);
//            if (userIdClaim != null)
//            {
//                string username = userIdClaim.Value;  
//                var user = _korisnikService.GetByUsername(username);
//                if (user != null)
//                {
//                    entity.KorisnikId = user.KorisnikId;  
//                }
//            }
//            entity.StateMachine = "draft";
//            set.Add(entity);
//            Context.SaveChanges();

//            return Mapper.Map<Recept>(entity);
//        }

//        public override List<string> AllowedActions(Database.Recept entity)
//        {
//            return new List<string>() { nameof(Insert) };
//        }
//    }
//}

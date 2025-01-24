//using eRecipes.Service.Database;
//using MapsterMapper;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;

//namespace eRecipes.Service.ReceptStateMachine
//{
//    public class ActiveReceptState : BaseReceptState
//    {
//        public ActiveReceptState(ERecipesContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
//        {
//        }
//        public override Model.Recept Hide(int id)
//        {
//            var set = Context.Set<Database.Recept>();

//            var entity = set.Find(id);

//            entity.StateMachine = "hidden";

//            Context.SaveChanges();
//            return Mapper.Map<Model.Recept>(entity);
//        }
//        public override List<string> AllowedActions(Database.Recept entity)
//        {
//            return new List<string>() { nameof(Hide) };
//        }
//    }
//}

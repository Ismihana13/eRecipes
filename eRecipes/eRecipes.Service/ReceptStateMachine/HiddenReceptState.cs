//using eRecipes.Service.Database;
//using MapsterMapper;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;

//namespace eRecipes.Service.ReceptStateMachine
//{
//    public class HiddenReceptState : BaseReceptState
//    {
//        public HiddenReceptState(ERecipesContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
//        {
//        }
//        public override Model.Recept Edit(int id)
//        {
//            var set = Context.Set<Database.Recept>();

//            var entity = set.Find(id);

//            entity.StateMachine = "draft";

//            Context.SaveChanges();
//            return Mapper.Map<Model.Recept>(entity);
//        }
//        public override List<string> AllowedActions(Database.Recept entity)
//        {
//            return new List<string>() { nameof(Edit) };
//        }

//    }
//}

using eRecipes.Model;
using eRecipes.Model.Requests;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.ReceptStateMachine
{
    public class InitialReceptState : BaseReceptState
    {
        public InitialReceptState(Database.ERecipesContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override Recept Insert(ReceptInsertRequest request)
        {
            var set = Context.Set<Database.Recept>();
            var entity = Mapper.Map<Database.Recept>(request);
            entity.StateMachine = "draft";
            set.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<Recept>(entity);
        }
        
    }
}

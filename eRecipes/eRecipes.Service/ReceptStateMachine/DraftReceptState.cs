using Azure.Core;
using eRecipes.Model.Requests;
using eRecipes.Service.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.ReceptStateMachine
{
    public class DraftReceptState : BaseReceptState
    {
        public DraftReceptState(ERecipesContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }
        public override Model.Recept Update(int id, ReceptUpdateRequest request)
        {
            var set= Context.Set<Database.Recept>();

            var entity= set.Find(id);

            Mapper.Map(request, entity);
            Context.SaveChanges();
            return Mapper.Map<Model.Recept>(entity);
        }
        public override Model.Recept Activate(int id)
        {
            var set = Context.Set<Database.Recept>();

            var entity = set.Find(id);

            entity.StateMachine = "active";

            Context.SaveChanges();
            return Mapper.Map<Model.Recept>(entity);
        }
    }
}

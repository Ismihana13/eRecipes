using Azure.Core;
using EasyNetQ;
using eRecipes.Model.Messages;
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
            var bus = RabbitHutch.CreateBus("host=localhost:5672");
            var mappedEntity=Mapper.Map<Model.Recept>(entity);
            ReceptActivated message= new ReceptActivated {Recept=mappedEntity};
            bus.PubSub.Publish(message);

            return mappedEntity;
          
        }
        public override Model.Recept Hide(int id)
        {
            var set = Context.Set<Database.Recept>();

            var entity = set.Find(id);

            entity.StateMachine = "hidden";

            Context.SaveChanges();
            return Mapper.Map<Model.Recept>(entity);
        }
        public override List<string> AllowedActions(Database.Recept entity)
        {
            return new List<string>() { nameof(Activate), nameof(Update), nameof(Hide) };
        }

    }
}

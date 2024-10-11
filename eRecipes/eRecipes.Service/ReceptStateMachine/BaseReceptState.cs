using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.Extensions.DependencyInjection;

namespace eRecipes.Service.ReceptStateMachine
{
    public class BaseReceptState
    {
        public ERecipesContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public IServiceProvider ServiceProvider { get; set; }
        public BaseReceptState(ERecipesContext context, IMapper mapper, IServiceProvider serviceProvider)
        {
            Context = context;
            Mapper = mapper;
            ServiceProvider = serviceProvider;
        }

        public virtual Model.Recept Insert(ReceptInsertRequest request)
        {
            throw new UserException("Metoda nije dozvoljena.");
        }
        public virtual Model.Recept Update(int id, ReceptUpdateRequest request)
        {
            throw new UserException("Metoda nije dozvoljena.");
        }
        public virtual Model.Recept Activate(int id)
        {
            throw new UserException("Metoda nije dozvoljena.");
        }
        public virtual Model.Recept Hide(int id)
        {
            throw new UserException("Metoda nije dozvoljena.");
        }
        public virtual Model.Recept Edit(int id)
        {
            throw new UserException("Metoda nije dozvoljena.");
        }
        public virtual  List<string> AllowedActions(Database.Recept entity)
        {
            throw new UserException("Metoda nije dozvoljena.");
        }
        public BaseReceptState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "initial":
                    return ServiceProvider.GetService<InitialReceptState>();
                case "draft":
                    return ServiceProvider.GetService<DraftReceptState>();
                case "active":
                    return ServiceProvider.GetService<ActiveReceptState>();
                case "hidden":
                    return ServiceProvider.GetService<HiddenReceptState>();
                default: throw new Exception("State not recognized");
            }
        }
    }
}
//initial, draft, active, hidden, active
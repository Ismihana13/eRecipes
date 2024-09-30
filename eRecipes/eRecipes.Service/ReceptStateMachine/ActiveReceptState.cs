using eRecipes.Service.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.ReceptStateMachine
{
    public class ActiveReceptState : BaseReceptState
    {
        public ActiveReceptState(ERecipesContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

    }
}

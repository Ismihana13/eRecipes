using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class UlogaService : BaseCRUDService<Model.Uloga, UlogaSearchObject, Database.Uloga, UlogaUpsertRequest, UlogaUpsertRequest>, IUlogaService
    {

        public UlogaService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }

    }
}

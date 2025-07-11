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
    public class FinansijskiLimit14072025Service : BaseCRUDService<Model.FinansijskiLimit14072025, BaseSearchObject, Database.FinansijskiLimit14072025, FinansijskiLimit14072025UpsertRequest, FinansijskiLimit14072025UpsertRequest>, IFinansijskiLimit14072025Service
    {
        public FinansijskiLimit14072025Service(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}

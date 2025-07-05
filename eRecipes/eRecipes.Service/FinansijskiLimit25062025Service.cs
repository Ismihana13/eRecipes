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
    public class FinansijskiLimit25062025Service : BaseCRUDService<Model.FinansijskiLimit25062026, FinansijskiLimit25062025SearchObject, Database.FinansijskiLimit25062026, FinansijskiLimit25062026UpsertRequest, FinansijskiLimit25062026UpsertRequest>, IFinansijskiLimit25062025Service
    {
        public FinansijskiLimit25062025Service(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
      
    }
}

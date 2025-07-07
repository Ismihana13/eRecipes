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
    public class TransakcijaLog25062025Service : BaseCRUDService<Model.TransakcijaLog25062025,TransakcijaLog25062025SearchObject, Database.TransakcijaLog25062025, TransakcijaLog25062025UpsertRequest, TransakcijaLog25062025UpsertRequest>, ITransakcijaLog25062025Service
    {
        public TransakcijaLog25062025Service(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
      
    }
}

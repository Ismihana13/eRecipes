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
    public class TransakcijaLog14072025Service : BaseCRUDService<Model.TransakcijaLog14072025, BaseSearchObject, Database.TransakcijaLog14072025, TransakcijaLog14072025UpsertRequest, TransakcijaLog14072025UpsertRequest>, ITransakcijaLog14072025Service
    {
        public TransakcijaLog14072025Service(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}

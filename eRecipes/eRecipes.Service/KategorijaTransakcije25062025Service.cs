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
    public class KategorijaTransakcije25062025Service : BaseCRUDService<Model.KategorijaTransakcije25062025, KategorijaTransakcije25062025SearchObject, Database.KategorijaTransakcije25062025, KategorijaTransakcije25062025UpsertRequest, KategorijaTransakcije25062025UpsertRequest>, IKategorijaTransakcije25062025Service
    {
        public KategorijaTransakcije25062025Service(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
      
    }
}

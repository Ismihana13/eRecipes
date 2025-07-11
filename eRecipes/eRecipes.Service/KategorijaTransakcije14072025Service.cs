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
    public class KategorijaTransakcije14072025Service : BaseCRUDService<Model.KategorijaTransakcije14072025, BaseSearchObject, Database.KategorijaTransakcije14072025, KategorijaTransakcije14072025UpsertRequest, KategorijaTransakcije14072025UpsertRequest>, IKategorijaTransakcije14072025Service
    {
        public KategorijaTransakcije14072025Service(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}

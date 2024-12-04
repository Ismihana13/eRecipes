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
    public class KategorijaService : BaseService<Model.Kategorija, KategorijaSearchObject, Database.Kategorija>, IKategorijaService
    {

        public KategorijaService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }



    }
}

using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public interface IKatalogService : ICRUDService<Katalog,KatalogSearchObject,KatalogUpsertRequest, KatalogUpsertRequest>
    {
        Task<string> AddReceptToKatalog(int katalogId, List<int> receptIds);
        Task<Model.Katalog> GetByIdIncludeRecipes(int id);
    }
}

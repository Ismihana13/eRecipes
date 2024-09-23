using eRecipes.Model.SearchObjects;
using eRecipes.Model;
using eRecipes.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace eRecipes.Service
{
    public interface IService<TModel,TSearch> where TSearch:BaseSearchObject
    {
        public PagedResult<TModel> GetPaged(TSearch search);
        public TModel GetById(int id);
    }
}

using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
    public class BaseCURDController<TModel, TSearch, TInsert, TUpdate> : BaseController<TModel, TSearch> where TSearch : BaseSearchObject where TModel : class
    {
        protected new ICRUDService<TModel, TSearch, TInsert, TUpdate> _service;
        public BaseCURDController(ICRUDService<TModel, TSearch, TInsert, TUpdate> service) : base(service)
        {
             _service = service;
        }

        [HttpPost]
        public TModel Insert(TInsert request)
        {

            return _service.Insert(request);
        }
        [HttpPut("{id}")]
        public TModel Update(int id, TUpdate request)
        {
            return _service.Update(id, request);
        }
    }
}

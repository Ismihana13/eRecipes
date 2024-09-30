using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ReceptController : BaseCURDController<Recept,ReceptSearchObject,ReceptInsertRequest,ReceptUpdateRequest>
    {
       
        public ReceptController(IReceptService service):base(service)
        {
           
        }
        [HttpPut("{id}/activate")]
        public Recept Activate(int id)
        {
            return (_service as IReceptService).Acivate(id);
        }
        
    }
}

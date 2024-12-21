using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Authorization;
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
        [HttpPut("{id}/edit")]
        public Recept Edit(int id)
        {
            return (_service as IReceptService).Edit(id);
        }
        [HttpPut("{id}/hide")]
        public Recept Hide(int id)
        {
            return (_service as IReceptService).Hide(id);
        }
        [HttpGet("{id}/allowedActions")]
        public List<string> AllowedActions(int id)
        {
            return (_service as IReceptService).AllowedActions(id);
        }
        [HttpPost]
        public override Recept Insert(ReceptInsertRequest request)
        {
            return _service.Insert(request);
        }
        [HttpPut("{id}/DeleteRecept")]
        public Recept DeleteRecept(int id)
        {
            return ((IReceptService)_service).DeleteRecept(id);
        }
        [HttpGet("{receptId}/sastojci")]
        public ActionResult<List<ReceptSastojak>> GetSastojciForRecept(int receptId)
        {
            return ((IReceptService)_service).GetSastojciForRecept(receptId);
        }
    }
}

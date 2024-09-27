using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
     [ApiController]
    [Route("[controller]")]
    public class KorisnikController : BaseCURDController<Model.Korisnik,KorisnikSearchObject,KorisnikInsertRequest,KorisnikUpdateRequest>
    {
        protected IKorisnikService _service;
        public KorisnikController(IKorisnikService service):base(service) 
        {
        }
        
    }
}

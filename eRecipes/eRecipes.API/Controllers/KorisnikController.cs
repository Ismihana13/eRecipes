
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage;

namespace eRecipes.API.Controllers
{
     [ApiController]
    [Route("[controller]")]
    public class KorisnikController : BaseCURDController<Model.Korisnik,KorisnikSearchObject,KorisnikInsertRequest,KorisnikUpdateRequest>
    {
        protected IKorisnikService _service;
        public KorisnikController(IKorisnikService service):base(service) 
        {
            _service = service;
        }
        [HttpPost("login")]
        [AllowAnonymous]
        public Model.Korisnik Login(string username, string password)
        {
            if (_service == null)
            {
                throw new Exception("Servis nije inicijalizovan.");
            }
            return _service.Login(username, password);
        }


    }
}

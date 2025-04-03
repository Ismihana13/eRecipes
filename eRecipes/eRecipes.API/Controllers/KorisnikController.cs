
using Azure.Core;
using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage;
using System.Text;

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
        [AllowAnonymous]
        [HttpGet("check-username")]
        public IActionResult ProvjeriKorisnickoIme([FromQuery] string korisnickoIme)
        {
            var korisnik = _service.GetByUsername(korisnickoIme);
            if (korisnik == null)
            {
                return NotFound(new { message = "Korisnik sa datim korisničkim imenom nije pronađen." });
            }
            return Ok(new { message = "Korisničko ime postoji u sistemu." });
        }

        [HttpGet("Authenticate")]
        [AllowAnonymous]
        public Korisnik Authenticate()
        {
            string authorization = HttpContext.Request.Headers["Authorization"];
            string encodedHeader = authorization["Basic ".Length..].Trim();
            Encoding encoding = Encoding.GetEncoding("iso-8859-1");
            string usernamePassword = encoding.GetString(Convert.FromBase64String(encodedHeader));
            int seperatorIndex = usernamePassword.IndexOf(':');

            return ((IKorisnikService)_service).Login(usernamePassword.Substring(0, seperatorIndex), usernamePassword[(seperatorIndex + 1)..]);
        }

        [AllowAnonymous]
        public override Korisnik Insert(KorisnikInsertRequest request)
        {
            return base.Insert(request);
        }

        [HttpPut("{id}/UpdateMobile")]
        public Korisnik UpdateMobile(int id, [FromBody] KorisnikMobileUpdateRequest request)
        {
            return ((IKorisnikService)_service).UpdateMobile(id, request);
        }

        [HttpDelete("{id}/DeleteKorisnikProfil")]
        public Korisnik DeleteKorisnickiProfil(int id)
        {
            return ((IKorisnikService)_service).DeleteKorisnickiProfil(id);
        }
    
        [HttpPut("{id}/DeleteKorisnik")]
        public Korisnik DeleteKorisnik(int id)
        {
            return ((IKorisnikService)_service).DeleteKorisnik(id);
        }

        [HttpPut("{id}/uloga")]
        public Korisnik UpdateUloga(int id, [FromBody] int novaUlogaId)
        {
           return ((IKorisnikService)_service).UpdateUloga(id, novaUlogaId);
        }
        [HttpPost("{id}/ResetPassword")]
        public async Task<ActionResult> ResetPassword(int id)
        {
            bool success = await _service.ResetPassword(id);
            if (!success)
                return BadRequest("Resetovanje lozinke nije uspjelo.");

            return Ok("Lozinka je uspješno resetovana.");
        }
        [AllowAnonymous]
        [HttpPost("resetPasswordByEmail")]
        public async Task<IActionResult> ResetPasswordByEmail([FromBody] string email)
        {
            var user = await _service.ResetPasswordByEmail(email);

            if (user == null)
            {
                return BadRequest("Korisnik sa unesenim emailom nije pronađen.");
            }
            return Ok("Link za resetovanje lozinke je poslat na vaš email.");
        }
    }
}

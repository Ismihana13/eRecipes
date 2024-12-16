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
    public interface IKorisnikService:ICRUDService<Korisnik,KorisnikSearchObject,KorisnikInsertRequest,KorisnikUpdateRequest>
    {
      Model.Korisnik Login(string username, string password);
      //Model.Korisnik AddUloga(int id, KorisnikUpdateRequest request);
      //Model.Korisnik DeleteUloga(int id, KorisnikUpdateRequest request);
      Model.Korisnik DeleteKorisnik(int id);
    }
}

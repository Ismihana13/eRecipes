using eRecipes.Model;
using eRecipes.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public interface IKorisnikService

    {
        List<Korisnik> GetList();
        Korisnik Insert(KorisnikInsertRequest request);
        Korisnik Update(int id,KorisnikUpdateRequest request);
    }
}

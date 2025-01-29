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
    public interface IReceptService:ICRUDService<Recept,ReceptSearchObject, ReceptInsertRequest,ReceptUpdateRequest>
    {
       Model.Recept DeleteRecept(int id);
        List<Model.ReceptSastojak> GetSastojciForRecept(int id);
        Task<string> AddSastojkeToReceptAsync(int receptId, List<int> sastojakIds);
        List<Model.Recept> GetReceptiByKorisnikId(int korisnikId);
       Model.Recept BrisanjeRecepta(int id);

    }
}

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
    public interface ITransakcija14072025Service : ICRUDService<Transakcija14072025,Transakcija14072025SearchObject,Transakcija14072025UpsertRequest, Transakcija14072025UpsertRequest>
    {
        Task<List<Statistika>> GetIznos(int? KategorijaTransakcije14072025Id);
    }
}

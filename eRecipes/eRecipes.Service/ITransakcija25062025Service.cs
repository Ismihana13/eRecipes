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
    public interface ITransakcija25062025Service : ICRUDService<Transakcija25062025,Transakcija25062025SearchObject,Transakcija25062025UpsertRequest, Transakcija25062025UpsertRequest>
    {
        Task<List<StatKategorija>> GetStat(int? KategorijaTransakcije25062025Id);
    }
}

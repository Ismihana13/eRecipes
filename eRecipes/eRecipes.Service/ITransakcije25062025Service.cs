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
    public interface ITransakcije25062025Service : ICRUDService<Transakcija25062025,Transakcije25062025SearchObject, Transakcija25062025UpsertRequest, Transakcija25062025UpsertRequest>
    {
        Task<List<IznosKategorija>> IznosPoKategoriji(Transakcije25062025SearchObject search);
    }
}

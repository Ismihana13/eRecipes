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
    public interface IRezervacijaProstoraService : ICRUDService<RezervacijaProstora20022025, RezervacijaProstora20022025SearchObject, RezervacijaProstoraUpsertRequest, RezervacijaProstoraUpsertRequest>
    {
        Task<List<RezervacijaProstoraStatus>> BrojRezervacije();
    }
}

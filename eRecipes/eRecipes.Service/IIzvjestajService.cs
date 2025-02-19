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
    public interface IIzvjestajService 
    {
        public Task<List<Model.Izvjestaj>> GetIzvjestajList(IzvjestajSearchObject? search=null);
        public  Task<Model.Izvjestaj> Insert(IzvjestajInsert insert);
    }
}

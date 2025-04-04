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
    public interface INotifikacijeService 
    {
        Notifikacije Insert(NotifikacijeInsertRequest request);
        List<Notifikacije> Get(NotifikacijeSearchObject search);
        Model.Notifikacije Delete(int id);
        Notifikacije UpdateProcitano(int id, bool procitano);
    }
}

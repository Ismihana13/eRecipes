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
        //public Recept Acivate(int id);
        //public Recept Edit(int id);
       // public Recept Hide(int id);
        //public List<string> AllowedActions(int id);
        Model.Recept DeleteRecept(int id);
       public List<Model.ReceptSastojak> GetSastojciForRecept(int id);

    }
}

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
    public interface IVrstaJelaService: ICRUDService<VrstaJela,VrstaJelaSearchObject,VrsteJelaUpsertRequest, VrsteJelaUpsertRequest>
    {
        int GetBrojRecepataZaVrstuJela(int vrstaJelaId);
        Model.VrstaJela DeleteVrstaJela(int id);
    }
}

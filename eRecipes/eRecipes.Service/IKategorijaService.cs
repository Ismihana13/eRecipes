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
    public interface IKategorijaService : ICRUDService<Kategorija,KategorijaSearchObject, KategorijaUpsertRequest, KategorijaUpsertRequest>
    {
        int GetBrojRecepataZaKategoriju(int kategorijaId);
        Model.Kategorija DeleteKategorija(int id);
    }
}

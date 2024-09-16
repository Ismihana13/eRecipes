using eRecipes.Service.Database;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class ReceptService : IReceptService
    {
        public ERecipesContext Context { get; set; }

        public ReceptService(ERecipesContext context)
        {
            Context = context;

        }
        public virtual List<Model.Recept> GetList()
        {
            var list = Context.Recepts.ToList();
            var result = new List<Model.Recept>();
            list.ForEach(item =>
            {
                result.Add(new Model.Recept()
                {
                    ReceptId = item.ReceptId,
                    Naziv = item.Naziv,
                    OpisRecepta = item.OpisRecepta,
                    Slika = item.Slika,

                });
            });

            return result;
        }

    }
}

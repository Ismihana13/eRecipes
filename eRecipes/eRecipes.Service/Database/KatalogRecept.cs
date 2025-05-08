using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.Database
{
    public class KatalogRecept
    {
        public int KatalogReceptId { get; set; }
        public int KatalogId { get; set; }
        public virtual Katalog? Katalog { get; set; }
        public int ReceptId { get; set; }
        public virtual Recept? Recept { get; set; }
    }
}

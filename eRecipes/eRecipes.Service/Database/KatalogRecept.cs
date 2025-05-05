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
        public Katalog Katalog { get; set; }
        public int ReceptId { get; set; }
        public Recept Recept { get; set; }
    }
}

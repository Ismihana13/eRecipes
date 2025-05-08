using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
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

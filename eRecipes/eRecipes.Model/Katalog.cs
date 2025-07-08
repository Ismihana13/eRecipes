using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class Katalog
    {
        public int KatalogId { get; set; }
        public string Naziv { get; set; } = null!;
        public DateTime DatumKreiranja { get; set; }
        public string? Opis { get; set; }
        public ICollection<KatalogRecept> KatalogRecepts { get; set; } = new List<KatalogRecept>();
    }
}

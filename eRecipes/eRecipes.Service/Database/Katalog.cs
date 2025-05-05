using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.Database
{
    public class Katalog
    {
        public int KatalogId { get; set; }
        public string Naziv { get; set; }
        public DateTime DatumKreiranja { get; set; }
        public string? Opis { get; set; }
        public ICollection<KatalogRecept> KatalogRecepts { get; set; } = new List<KatalogRecept>();
    }
}

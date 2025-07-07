using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class Izvjestaj
    {
        public int IzvjestajId { get; set; }
        public int? ReceptId { get; set; }
        public int? BrojLajkova { get; set; } 
        public int? BrojOmiljenih { get; set; }
        public DateTime? DatumIzvjestaja { get; set; }
        public virtual Recept? Recept { get; set; } 
    }
}

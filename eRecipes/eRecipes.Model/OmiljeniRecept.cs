using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class OmiljeniRecept
    {
        public int OmiljeniReceptId { get; set; }
        public int? KorisnikId { get; set; }
        public int? ReceptId { get; set; }
        public Recept Recept { get; set; }
        public DateTime? DatumDodavanja { get; set; }
    }
}

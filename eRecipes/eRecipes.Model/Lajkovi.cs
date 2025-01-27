using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class Lajkovi
    {
        public int LajkoviId { get; set; }

        public int KorisnikId { get; set; }

        public int ReceptId { get; set; }

        public DateTime DatumLajka { get; set; } = DateTime.Now;

        public virtual Korisnik Korisnik { get; set; } = null!;

        public virtual Recept Recept { get; set; } = null!;

    }
}

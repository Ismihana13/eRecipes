using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class MoodTracker30012025
    {
        public int MoodTracker30012025Id { get; set; }
        public int KorisnikId { get; set; }
        public Korisnik Korisnik { get; set; }
        public string VrijednostRaspolozenja { get; set; }
        public string Opis { get; set; }
        public DateTime DatumEvidencije { get; set; }
    }
}

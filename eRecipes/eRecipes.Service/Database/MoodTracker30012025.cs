using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.Database
{
    public class MoodTracker30012025
    {
        public int MoodTracker30012025Id { get; set; }
        public int KorisnikId { get; set; }
        public Korisnik Korisnik { get; set; }
        public string VrijednostRaspolozenja { get; set; }
        public string Opis {  get; set; }
        public DateTime DatumEvidencije { get; set; }
    }
}

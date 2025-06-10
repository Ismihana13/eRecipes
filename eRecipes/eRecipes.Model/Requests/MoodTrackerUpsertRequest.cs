using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class MoodTrackerUpsertRequest
    {
        public int KorisnikId { get; set; }
        public string VrijednostRaspolozenja { get; set; }
        public string Opis { get; set; }
        public DateTime DatumEvidencije { get; set; }
    }
}

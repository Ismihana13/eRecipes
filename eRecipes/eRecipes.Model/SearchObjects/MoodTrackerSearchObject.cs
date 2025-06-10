using eRecipes.Service.Helper;
using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.SearchObjects
{
    public class MoodTrackerSearchObject : BaseSearchObject
    {
        public int? KorisnikId { get; set; }
        public VrijednostRaspolozenja? VrijednostRaspolozenja { get; set; }
        public DateTime? DatumEvidencije { get; set; }
    }
}

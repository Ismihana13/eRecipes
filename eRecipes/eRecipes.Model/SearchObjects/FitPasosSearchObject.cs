using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.SearchObjects
{
    public class FitPasosSearchObject : BaseSearchObject
    {
      public int? KorisnikId { get; set; }
        public DateTime? DatumVazenja { get; set; }
    }
}

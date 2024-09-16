using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public  class Recept
    {
        public int ReceptId { get; set; }

        public string Naziv { get; set; } = null!;

        public string? OpisRecepta { get; set; }

        public string? Slika { get; set; }

        public int? VrijemePripreme { get; set; }

        public int? KorisnikId { get; set; }

        public DateTime? DatumObjave { get; set; }

        public bool? Premium { get; set; }

    }
}

using System;
using System.Collections.Generic;

namespace eRecipes.Model.Requests
{
    public partial class ReceptInsertRequest
    {

        public string? Naziv { get; set; }

        public string? OpisRecepta { get; set; }

         public byte[]? Slika { get; set; }
        public string? OpisPripreme { get; set; }

        public int? VrijemePripreme { get; set; }

        public int? VrstaJelaId { get; set; }

        public int? KategorijaId { get; set; }
    }
}



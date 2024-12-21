using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class Recept
    {
        public int ReceptId { get; set; }

        public string Naziv { get; set; }

        public string? OpisRecepta { get; set; }

        public byte[]? Slika { get; set; }
        public int VrstaJelaId { get; set; }

        public int KategorijaId { get; set; }
        public int? VrijemePripreme { get; set; }
        public  VrstaJela VrstaJela{get;set;}

        public  Kategorija Kategorija { get; set; }
        public int? KorisnikId { get; set; }
        public Korisnik Korisnik { get; set; }

        public DateTime? DatumObjave { get; set; }

        public bool? Premium { get; set; }
        public bool? Status { get; set; }
        public string? StateMachine { get; set; }
        public ICollection<ReceptSastojak> ReceptSastojaks { get; set; } = new List<ReceptSastojak>();

    }
}

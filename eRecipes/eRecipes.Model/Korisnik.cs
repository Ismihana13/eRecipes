using System;
using System.Collections.Generic;

namespace eRecipes.Model
{
    public partial class Korisnik
    {
        public int KorisnikId { get; set; }

        public string Ime { get; set; } = null!;

        public string Prezime { get; set; } = null!;

        public DateTime? DatumRodjenja { get; set; }

        public string? Email { get; set; }

        public string? Telefon { get; set; }

        public string KorisnickoIme { get; set; } = null!;

        public bool? Status { get; set; }

        public virtual ICollection<KorisnikUloga> KorisnikUlogas  { get; set; } = new List<KorisnikUloga>();
    }
}

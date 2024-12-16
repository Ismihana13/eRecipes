using System;
using System.Collections.Generic;
using System.Linq;

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
        //public string Uloge => string.Join(", ", KorisnikUlogas?.Select(x => x.Uloga?.Naziv)?.ToList());
        public int? UlogaId { get; set; }
        public Uloga Uloga { get; set; }

        public bool? Status { get; set; }
    }
}

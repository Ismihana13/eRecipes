using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class KorisnikInsertRequest
    {
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public DateTime? DatumRodjenja { get; set; }
        public string? Email { get; set; }
        public string? Telefon { get; set; }
        public string KorisnickoIme { get; set; } = null!;
        public string Lozinka { get; set; }
        public string LozinkaPotvrda { get; set; }
        public bool? Status { get; set; }
        public int? UlogaId { get; set; }
    }
}

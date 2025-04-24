using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class Uplata
    {
        public int UplataId { get; set; }
        public int KorisnikId { get; set; }
        public decimal Iznos { get; set; } = 10.00m;
        public DateTime DatumUplate { get; set; } = DateTime.Now;
        public Korisnik Korisnik { get; set; }
    }
}

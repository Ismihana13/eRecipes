using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class FitPasos
    {
        public int FitPasosId { get; set; }
        public int KorisnikId { get; set; }
        public Korisnik Korisnik { get; set; }
        public DateTime DatumIzdavanja { get; set; }
        public bool Validan { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class Obavijest
    {
        public int ObavijestId { get; set; }
        public string Naslov { get; set; } = null!;
        public string Sadrzaj { get; set; } = null!;
        public int KorisnikId { get; set; }
        public string KorisnickoIme { get; set; } = null!; 
        public DateTime DatumSlanja { get; set; } = DateTime.Now;
        public int? ReceptId { get; set; }
        public string? ReceptNaziv { get; set; }
        public bool Procitano { get; set; } 

    }
}

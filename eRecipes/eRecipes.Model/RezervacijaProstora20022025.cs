using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class RezervacijaProstora20022025
    {
        public int RezervacijaProstora20022025Id { get; set; }
        public DateTime DatumIVrijemePocetkaRezervacije { get; set; }
        public int Trajanje { get; set; }
        public string StatusRezervacije { get; set; }
        public string Napomena { get; set; }
        public int KorisnikId { get; set; }
        public virtual Korisnik Korisnik { get; set; }
        public int RadniProstorId { get; set; }
        public virtual RadniProstor RadniProstor { get; set; }
    }
}

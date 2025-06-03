using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class RezervacijaProstoraUpsertRequest
    {
        public DateTime DatumIVrijemePocetkaRezervacije { get; set; }
        public int Trajanje { get; set; }
        public string StatusRezervacije { get; set; }
        public string Napomena { get; set; }
        public int KorisnikId { get; set; }
        public int RadniProstorId { get; set; }
    }
}

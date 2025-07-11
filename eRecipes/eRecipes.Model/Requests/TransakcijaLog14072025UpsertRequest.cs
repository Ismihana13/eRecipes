using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class TransakcijaLog14072025UpsertRequest
    {
        public string StaraVrijednost { get; set; }
        public string NovaVrijednost { get; set; }
        public DateTime DatumIVrijemePromjene { get; set; }
        public int KorisnikId { get; set; }
    }
}

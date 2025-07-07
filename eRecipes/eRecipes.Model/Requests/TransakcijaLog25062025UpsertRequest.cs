using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class TransakcijaLog25062025UpsertRequest
    {
        public string StaraVrijednost { get; set; }
        public string NovaVrijednost { get; set; }
        public DateTime DatumPromjene { get; set; }
        public int KorisnikId { get; set; }
    }
}

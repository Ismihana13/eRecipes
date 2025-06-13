using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class FitPasosUpsertRequest
    {
        public int KorisnikId { get; set; }
        public DateTime DatumIzdavanja { get; set; }
        public bool Validan { get; set; }
    }
}

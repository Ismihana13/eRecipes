using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class UplataUpsertRequest
    {
        public int KorisnikId { get; set; }
        public decimal Iznos { get; set; } = 10.00m;
        public DateTime DatumUplate { get; set; } = DateTime.Now;
    }
}

using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class NotifikacijeInsertRequest
    {
        public string Naslov { get; set; } = null!;
        public string Sadrzaj { get; set; } = null!;
        public int KorisnikId { get; set; }
        public DateTime DatumSlanja { get; set; } = DateTime.Now; 
        public int? ReceptId { get; set; }
    }
}

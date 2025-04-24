using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.Database
{
    public class Uplata
    {
        public int UplataId { get; set; }
        public int KorisnikId { get; set; }
        public decimal Iznos { get; set; }
        public DateTime DatumUplate { get; set; } 
        public virtual Korisnik Korisnik { get; set; } = null!;
    }
}

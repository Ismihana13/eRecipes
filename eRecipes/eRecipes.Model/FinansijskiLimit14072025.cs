using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Model
{
    public class FinansijskiLimit14072025
    {
        public int FinansijskiLimit14072025Id {  get; set; }
        public int KorisnikId { get; set; }
        public Korisnik Korisnik { get; set; }
        public KategorijaTransakcije14072025 KategorijaTransakcije14072025 { get; set; }
        public int KategorijaTransakcije14072025Id { get; set; }
        public float Limit {  get; set; }
    }
}

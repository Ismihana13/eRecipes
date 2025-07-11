using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Model
{
    public class Transakcija14072025
    {
        public int Transakcija14072025Id {  get; set; }
        public int KorisnikId { get; set; }
        public Korisnik Korisnik { get; set; }
        public float Iznos {  get; set; }
        public DateTime DatumTransakcije { get; set; }
        public string Opis {  get; set; }
        public int KategorijaTransakcije14072025Id { get; set; }
        public KategorijaTransakcije14072025 KategorijaTransakcije14072025 { get; set; }
        public string Status { get; set; }
    }
}

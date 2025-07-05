using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.Database
{
    public class TransakcijaLog25062025
    {
        public int TransakcijaLog25062025Id { get; set; }
        public string StaraVrijednost {  get; set; }
        public string NovaVrijednost { get; set; }
        public DateTime VrijemePromjene { get; set; }
        public Korisnik Korisnik { get; set; }
        public int KorisnikId { get; set; }

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.Database
{
    public class ToDo4924
    {
        public int ToDo4924Id {  get; set; }
        public int KorisnikId { get; set; }
        public virtual Korisnik Korisnik { get; set; }
        public string Naziv { get; set; }
        public string Opis {  get; set; }
        public DateTime DatumIzvrsenja { get; set; }
        public string Status    { get; set; }


    }
}

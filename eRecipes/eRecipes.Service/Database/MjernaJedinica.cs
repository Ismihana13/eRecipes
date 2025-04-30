using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.Database
{
    public class MjernaJedinica
    {
        public int MjernaJedinicaId { get; set; }
        public string Naziv {  get; set; }
        public string Oznaka { get; set; }
        public virtual ICollection<ReceptSastojak> ReceptSastojaks { get; set; } = new List<ReceptSastojak>();
    }
}

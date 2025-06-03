using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.Database
{
    public class RadniProstor
    {
        public int RadniProstorId {  get; set; }
        public string Oznaka { get; set; }
        public int Kapacitet { get; set; }
        public bool  Aktivna { get; set; }
    }
}

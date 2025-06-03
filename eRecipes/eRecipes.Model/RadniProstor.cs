using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class RadniProstor
    {
        public int RadniProstorId { get; set; }
        public string Oznaka { get; set; }
        public int Kapacitet { get; set; }
        public bool Aktivna { get; set; }
    }
}

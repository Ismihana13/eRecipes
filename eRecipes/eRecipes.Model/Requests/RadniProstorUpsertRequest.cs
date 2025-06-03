using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class RadniProstorUpsertRequest
    {
        public string Oznaka { get; set; }
        public int Kapacitet { get; set; }
        public bool Aktivna { get; set; }
    }
}

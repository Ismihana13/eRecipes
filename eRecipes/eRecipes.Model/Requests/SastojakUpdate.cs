using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class SastojakUpdateModel
    {
        public int SastojakId { get; set; }
        public double Kolicina { get; set; }
        public int MjernaJedinicaId { get; set; }
    }
}

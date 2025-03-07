using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class ReceptSastojak
    {
        public int ReceptSastojakId { get; set; }
        public int ReceptId { get; set; }
        public int SastojakId { get; set; }
        public virtual Recept? Recept { get; set; }
        public virtual Sastojak? Sastojak { get; set; }
    }
}

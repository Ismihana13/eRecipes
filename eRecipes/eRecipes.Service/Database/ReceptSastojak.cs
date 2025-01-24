using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class ReceptSastojak
{
    public int ReceptSastojakId { get; set; }

    public int ReceptId { get; set; }

    public int SastojakId { get; set; }

    //public float Kolicina { get; set; } = 0;

    //public string MjernaJedinica { get; set; } = string.Empty;

    public virtual Recept Recept { get; set; } = null!;

    public virtual Sastojak Sastojak { get; set; } = null!;
}

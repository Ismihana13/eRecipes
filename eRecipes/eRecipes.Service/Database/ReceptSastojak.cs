using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class ReceptSastojak
{
    public int ReceptSastojakId { get; set; }
    public int ReceptId { get; set; }
    public int SastojakId { get; set; }
    public int MjernaJedinicaId { get; set; }
    public double Kolicina { get; set; }
    public virtual Recept Recept { get; set; } = null!;
    public virtual Sastojak Sastojak { get; set; } = null!;
    public virtual MjernaJedinica MjernaJedinica { get; set; } = null!;
}

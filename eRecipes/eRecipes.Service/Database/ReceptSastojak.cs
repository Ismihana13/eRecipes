using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class ReceptSastojak
{
    public int ReceptSastojakId { get; set; }

    public int? ReceptId { get; set; }

    public int? SastojakId { get; set; }

    public decimal? Kolicina { get; set; }

    public string? MjernaJedinica { get; set; }

    public virtual Recept? Recept { get; set; }

    public virtual Sastojak? Sastojak { get; set; }
}

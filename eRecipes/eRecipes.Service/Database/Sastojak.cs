using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class Sastojak
{
    public int SastojakId { get; set; }

    public string Naziv { get; set; } = null!;

    public virtual ICollection<ReceptSastojak> ReceptSastojaks { get; set; } = new List<ReceptSastojak>();
}

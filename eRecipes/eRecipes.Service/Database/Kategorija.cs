using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class Kategorija
{
    public int KategorijaId { get; set; }
    public string Naziv { get; set; } = null!;
    public bool? Status { get; set; }
    public virtual ICollection<Recept> Recepts { get; set; } = new List<Recept>();
}

using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class VrstaJela
{
    public int VrstaJelaId { get; set; }
    public string Naziv { get; set; } = null!;
    public virtual ICollection<Recept> Recepts { get; set; } = new List<Recept>();
}

using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class Uloga
{
    public int UlogaId { get; set; }

    public string Naziv { get; set; } = null!;

    public string? Opis { get; set; }

    public virtual ICollection<Korisnik> Korisnik { get; set; }
}

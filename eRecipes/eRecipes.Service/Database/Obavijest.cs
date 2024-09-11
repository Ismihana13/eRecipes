using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class Obavijest
{
    public int ObavijestId { get; set; }

    public string Naslov { get; set; } = null!;

    public string Sadrzaj { get; set; } = null!;

    public int? KorisnikId { get; set; }

    public DateOnly DatumSlanja { get; set; }

    public virtual Korisnik? Korisnik { get; set; }
}

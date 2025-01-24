using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class Obavijest
{
    public int ObavijestId { get; set; }
    public string Naslov { get; set; } = null!;

    public string Sadrzaj { get; set; } = null!;

    public int KorisnikId { get; set; }

    public DateTime DatumSlanja { get; set; } = DateTime.Now;

    public virtual Korisnik Korisnik { get; set; } = null!;
}

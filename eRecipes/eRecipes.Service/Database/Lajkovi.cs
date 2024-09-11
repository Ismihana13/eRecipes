using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class Lajkovi
{
    public int LajkoviId { get; set; }

    public int? KorisnikId { get; set; }

    public int? ReceptId { get; set; }

    public DateTime? DatumLajka { get; set; }

    public virtual Korisnik? Korisnik { get; set; }

    public virtual Recept? Recept { get; set; }
}

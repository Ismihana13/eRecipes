using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class OmiljeniRecept
{
    public int OmiljeniReceptId { get; set; }

    public int? KorisnikId { get; set; }

    public int? ReceptId { get; set; }

    public DateTime? DatumDodavanja { get; set; }

    public virtual Korisnik? Korisnik { get; set; }

    public virtual Recept? Recept { get; set; }
}

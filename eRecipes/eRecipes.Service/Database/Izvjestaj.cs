using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class Izvjestaj
{
    public int IzvjestajId { get; set; }

    public int? ReceptId { get; set; }

    public int? BrojPregleda { get; set; }

    public int? BrojLajkova { get; set; }

    public int? BrojKupovina { get; set; }

    public DateOnly DatumIzvjestaja { get; set; }

    public virtual Recept? Recept { get; set; }
}

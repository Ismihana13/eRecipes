using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class Notifikacije
{
    public int NotifikacijeId { get; set; }
    public string Naslov { get; set; } = null!;
    public string Sadrzaj { get; set; } = null!;
    public int KorisnikId { get; set; }
    public DateTime DatumSlanja { get; set; } = DateTime.Now;
    public int? ReceptId { get; set; }
    public virtual Recept? Recept { get; set; }
    public virtual Korisnik Korisnik { get; set; } = null!;
    public bool Procitano { get; set; } = false;
}

using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class Recept
{
    public int ReceptId { get; set; }

    public string Naziv { get; set; } = null!;

    public string? OpisRecepta { get; set; }

    public byte[]? Slika { get; set; }

    public int? VrijemePripreme { get; set; }

    public int? KorisnikId { get; set; }

    public DateTime? DatumObjave { get; set; }

    public bool? Premium { get; set; }

    public int? VrstaJelaId { get; set; }

    public int? KategorijaId { get; set; }

    public bool? Status { get; set; }

    public string? StateMachine { get; set; }

    public virtual ICollection<Izvjestaj> Izvjestajs { get; set; } = new List<Izvjestaj>();

    public virtual Kategorija? Kategorija { get; set; }

    public virtual Korisnik? Korisnik { get; set; }

    public virtual ICollection<Lajkovi> Lajkovis { get; set; } = new List<Lajkovi>();

    public virtual ICollection<OmiljeniRecept> OmiljeniRecepts { get; set; } = new List<OmiljeniRecept>();

    public virtual ICollection<ReceptSastojak> ReceptSastojaks { get; set; } = new List<ReceptSastojak>();

    public virtual VrstaJela? VrstaJela { get; set; }
}

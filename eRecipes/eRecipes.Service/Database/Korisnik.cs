using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database;

public partial class Korisnik
{
    public int KorisnikId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public DateTime? DatumRodjenja { get; set; }

    public string? Email { get; set; }

    public string? Telefon { get; set; }

    public string KorisnickoIme { get; set; } = null!;

    public string LozinkaHash { get; set; } = null!;

    public string LozinkaSalt { get; set; } = null!;

    public bool? Status { get; set; }

    public int? UlogaId { get; set; }

    public virtual ICollection<Lajkovi> Lajkovis { get; set; } = new List<Lajkovi>();

    public virtual ICollection<Obavijest> Obavijests { get; set; } = new List<Obavijest>();

    public virtual ICollection<OmiljeniRecept> OmiljeniRecepts { get; set; } = new List<OmiljeniRecept>();

    public virtual ICollection<Recept> Recepts { get; set; } = new List<Recept>();

    public virtual Uloga? Uloga { get; set; }
}

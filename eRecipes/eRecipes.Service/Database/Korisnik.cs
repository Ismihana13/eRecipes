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
    public bool Status { get; set; } = true;
    public int UlogaId { get; set; }
    public virtual Uloga Uloga { get; set; } = null!;
    public virtual ICollection<Lajkovi> Lajkovis { get; set; } = new List<Lajkovi>();
    public virtual ICollection<Notifikacije> Obavijests { get; set; } = new List<Notifikacije>();
    public virtual ICollection<OmiljeniRecept> OmiljeniRecepts { get; set; } = new List<OmiljeniRecept>();
    public virtual ICollection<Recept> Recepts { get; set; } = new List<Recept>();
    public virtual ICollection<Uplata> Uplatas { get; set; } = new List<Uplata>();
}

using System;
using System.Collections.Generic;
using eRecipes.Model;
using eRecipes.Services.Helper;
using Microsoft.EntityFrameworkCore;

namespace eRecipes.Service.Database;

public partial class ERecipesContext : DbContext
{
    public ERecipesContext()
    {
    }

    public ERecipesContext(DbContextOptions<ERecipesContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Izvjestaj> Izvjestajs { get; set; }
    public virtual DbSet<Kategorija> Kategorijas { get; set; }
    public virtual DbSet<Korisnik> Korisniks { get; set; }
    public virtual DbSet<Lajkovi> Lajkovis { get; set; }
    public virtual DbSet<Notifikacije> Notifikacijes { get; set; }
    public virtual DbSet<OmiljeniRecept> OmiljeniRecepts { get; set; }
    public virtual DbSet<Recept> Recepts { get; set; }
    public virtual DbSet<ReceptSastojak> ReceptSastojaks { get; set; }
    public virtual DbSet<Sastojak> Sastojaks { get; set; }
    public virtual DbSet<Uloga> Ulogas { get; set; }
    public virtual DbSet<VrstaJela> VrstaJelas { get; set; }
    public virtual DbSet<Uplata> Uplatas { get; set; }
    public virtual DbSet<MjernaJedinica> MjernaJedinicas { get; set; }
    public virtual DbSet<Katalog> Katalogs { get; set; }
    public virtual DbSet<KatalogRecept> KatalogRecepts { get; set; }
    public virtual DbSet<KategorijaTransakcije14072025> KategorijaTransakcije14072025s { get; set; }
    public virtual DbSet<Transakcija14072025> Transakcija14072025s { get; set; }
    public virtual DbSet<TransakcijaLog14072025> TransakcijaLog14072025s { get; set; }
    public virtual DbSet<FinansijskiLimit14072025> FinansijskiLimit14072025s { get; set; }


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Lajkovi>()
       .HasOne(l => l.Korisnik)
       .WithMany(k => k.Lajkovis)
       .HasForeignKey(l => l.KorisnikId)
       .OnDelete(DeleteBehavior.Cascade); 

        modelBuilder.Entity<Lajkovi>()
            .HasOne(l => l.Recept)
            .WithMany(r => r.Lajkovis)
            .HasForeignKey(l => l.ReceptId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<OmiljeniRecept>()
      .HasOne(o => o.Korisnik)  
      .WithMany(k => k.OmiljeniRecepts)
      .HasForeignKey(o => o.KorisnikId)
      .OnDelete(DeleteBehavior.Restrict);  

        modelBuilder.Entity<OmiljeniRecept>()
            .HasOne(o => o.Recept)  
            .WithMany(r => r.OmiljeniRecepts)
            .HasForeignKey(o => o.ReceptId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Uloga>().HasData(
          new Uloga { UlogaId = 1, Naziv = "Admin", Opis = "Ovaj moze sta god hoce :D" },
          new Uloga { UlogaId = 2, Naziv = "Korisnik", Opis = "Ovaj je obican smrtnik" },
          new Uloga { UlogaId = 3, Naziv = "Premium korisnik", Opis = "Ovaj baja imama para" }

      );

        modelBuilder.Entity<Korisnik>().HasData(
            new Korisnik { KorisnikId = 1, Ime = "Admin", Prezime = "Adminovic", DatumRodjenja = DateTime.Now.AddYears(-30), Email = "admin@mail.com", Telefon = "060-000-000", KorisnickoIme = "admin", LozinkaHash = "tPW/IOLa2TZIKYSA50IDeaJKYtg=", LozinkaSalt = "2G2wAwYkdFgpMleomcwelg==", Status = true, UlogaId = 1 },
            new Korisnik { KorisnikId = 2, Ime = "Korisnik", Prezime = "Korisnikovic", DatumRodjenja = DateTime.Now.AddYears(-23), Email = "korisnik@mail.com", Telefon = "060-000-001", KorisnickoIme = "korisnik", LozinkaHash = "tPW/IOLa2TZIKYSA50IDeaJKYtg=", LozinkaSalt = "2G2wAwYkdFgpMleomcwelg==", Status = true, UlogaId = 2 },
            new Korisnik { KorisnikId = 3, Ime = "Baja", Prezime = "Bajaspare", DatumRodjenja = DateTime.Now.AddYears(-45), Email = "bajaspare@mail.com", Telefon = "060-000-002", KorisnickoIme = "premium", LozinkaHash = "tPW/IOLa2TZIKYSA50IDeaJKYtg=", LozinkaSalt = "2G2wAwYkdFgpMleomcwelg==", Status = true, UlogaId = 3 }
            );

        modelBuilder.Entity<Kategorija>().HasData(
            new Kategorija { KategorijaId = 1, Naziv = "Predjelo", Status = true },
            new Kategorija { KategorijaId = 2, Naziv = "Glavno jelo", Status = true },
            new Kategorija { KategorijaId = 3, Naziv = "Desert", Status = true }
        );

        modelBuilder.Entity<VrstaJela>().HasData(
            new VrstaJela { VrstaJelaId = 1, Naziv = "Kolač" },
            new VrstaJela { VrstaJelaId = 2, Naziv = "Juha" },
            new VrstaJela { VrstaJelaId = 3, Naziv = "Salata" },
            new VrstaJela { VrstaJelaId = 4, Naziv = "Tjestenina" },
            new VrstaJela { VrstaJelaId = 5, Naziv = "Pizza" },
            new VrstaJela { VrstaJelaId = 6, Naziv = "Sendvič" },
            new VrstaJela { VrstaJelaId = 7, Naziv = "Zdravi obrok" },
            new VrstaJela { VrstaJelaId = 8, Naziv = "Meso" },
            new VrstaJela { VrstaJelaId = 9, Naziv = "Slatko" },
             new VrstaJela { VrstaJelaId = 10, Naziv = "Tradicionalno jelo" }
        );

        modelBuilder.Entity<Sastojak>().HasData(
            new Sastojak { SastojakId = 1, Naziv = "Jaje" },
            new Sastojak { SastojakId = 2, Naziv = "Brašno" },
            new Sastojak { SastojakId = 3, Naziv = "Šećer" },
            new Sastojak { SastojakId = 4, Naziv = "Mlijeko" },
            new Sastojak { SastojakId = 5, Naziv = "Maslac" },
            new Sastojak { SastojakId = 6, Naziv = "So" },
            new Sastojak { SastojakId = 7, Naziv = "Prašak za pecivo" },
            new Sastojak { SastojakId = 8, Naziv = "Čokolada" },
            new Sastojak { SastojakId = 9, Naziv = "Vanilin šećer" },
            new Sastojak { SastojakId = 10, Naziv = "Maslinovo ulje" }
        );

        modelBuilder.Entity<Recept>().HasData(
            new Recept { ReceptId = 1, Naziv = "Palačinke", OpisRecepta = "Jednostavan recept za ukusne palačinke.", OpisPripreme = "Pomiješati sve sastojke i ispeći na tavi.", VrijemePripreme = 20, KorisnikId = 2, DatumObjave = DateTime.Now, Premium = false, VrstaJelaId = 9, KategorijaId = 3, Status = true, Slika = Convert.FromBase64String(Images.Slike[1]), },
            new Recept { ReceptId = 2, Naziv = "Pizza Margherita", OpisRecepta = "Klasična pizza s rajčicom, sirom i bosiljkom.", OpisPripreme = "Pripremiti tijesto, dodati sastojke i ispeći u pećnici.", VrijemePripreme = 40, KorisnikId = 2, DatumObjave = DateTime.Now, Premium = true, VrstaJelaId = 5, KategorijaId = 2, Status = true, Slika = Convert.FromBase64String(Images.Slike[0]), },
            new Recept { ReceptId = 3, Naziv = "Ćevapi", OpisRecepta = "Popularno jelo sa roštilja, sastavljeno od mljevenog mesa, obično govedine i janjetine.", OpisPripreme = "Pomiješati meso s začinima, oblikovati u male ćevape i ispeći na roštilju.", VrijemePripreme = 30, KorisnikId = 2, DatumObjave = DateTime.Now, Premium = false, VrstaJelaId = 8, KategorijaId = 2, Status = true, Slika = Convert.FromBase64String(Images.Slike[2]) },
            new Recept { ReceptId = 4, Naziv = "Tiramisu", OpisRecepta = "Ukusan talijanski desert sa slojevima kvasca, kave, kisele pavlake i kakaa.", OpisPripreme = "Pomiješati mascarpone s jajima, dodati kavu i složiti u slojeve s piškotama.", VrijemePripreme = 40, KorisnikId = 3, DatumObjave = DateTime.Now, Premium = true, VrstaJelaId = 9, KategorijaId = 3, Status = true, Slika = Convert.FromBase64String(Images.Slike[3]) },
            new Recept { ReceptId = 5, Naziv = "Pasta Carbonara", OpisRecepta = "Tradicionalni talijanski recept za pastu s jajima, pancetom, sirom i paprom.", OpisPripreme = "Skuhati pastu, pomiješati s prženim pancetama, dodati umak od jaja i sira.", VrijemePripreme = 25, KorisnikId = 2, DatumObjave = DateTime.Now, Premium = false, VrstaJelaId = 4, KategorijaId = 2, Status = true, Slika = Convert.FromBase64String(Images.Slike[4]) },
            new Recept { ReceptId = 6, Naziv = "Grčka salata", OpisRecepta = "Osnovna grčka salata s rajčicama, krastavcima, maslinama, sirom feta i maslinovim uljem.", OpisPripreme = "Sastaviti povrće, dodati masline i feta sir, začiniti maslinovim uljem i začinima.", VrijemePripreme = 15, KorisnikId = 2, DatumObjave = DateTime.Now, Premium = false, VrstaJelaId = 3, KategorijaId = 1, Status = true, Slika = Convert.FromBase64String(Images.Slike[5]) },
            new Recept { ReceptId = 7, Naziv = "Sarma", OpisRecepta = "Tradicionalno jelo od kiselog kupusa, punjeno mljevenim mesom, rižom i začinima.", OpisPripreme = "Napraviti smjesu od mesa i riže, obložiti kupusom i kuhati u loncu.", VrijemePripreme = 120, KorisnikId = 2, DatumObjave = DateTime.Now, Premium = false, VrstaJelaId = 10, KategorijaId = 2, Status = true, Slika = Convert.FromBase64String(Images.Slike[6]) },
            new Recept { ReceptId = 8, Naziv = "Pečena piletina", OpisRecepta = "Sočna piletina pečena u pećnici s povrćem.", OpisPripreme = "Začiniti piletinu, staviti u pećnicu s povrćem i peći dok ne postane zlatno smeđa.", VrijemePripreme = 60, KorisnikId = 2, DatumObjave = DateTime.Now, Premium = false, VrstaJelaId = 8, KategorijaId = 2, Status = true, Slika = Convert.FromBase64String(Images.Slike[7]) },
            new Recept { ReceptId = 9, Naziv = "Čokoladni mousse", OpisRecepta = "Lagan i kremast desert sa čokoladom.", OpisPripreme = "Otopiti čokoladu, pomiješati sa šlagom i hladiti.", VrijemePripreme = 30, KorisnikId = 3, DatumObjave = DateTime.Now, Premium = true, VrstaJelaId = 1, KategorijaId = 3, Status = true, Slika = Convert.FromBase64String(Images.Slike[8]) },
            new Recept { ReceptId = 10, Naziv = "Zapečeni krompir", OpisRecepta = "Ukusan krompir zapečen sa sirom i začinima.", OpisPripreme = "Krompir ispeći u pećnici sa sirom, maslacem i začinima.", VrijemePripreme = 45, KorisnikId = 2, DatumObjave = DateTime.Now, Premium = false, VrstaJelaId = 4, KategorijaId = 2, Status = true, Slika = Convert.FromBase64String(Images.Slike[9]) }
         );
        modelBuilder.Entity<MjernaJedinica>().HasData(
            new MjernaJedinica { MjernaJedinicaId = 1, Naziv = "Gram", Oznaka = "g" },
            new MjernaJedinica { MjernaJedinicaId = 2, Naziv = "Kilogram", Oznaka = "kg" },
            new MjernaJedinica { MjernaJedinicaId = 3, Naziv = "Mililitar", Oznaka = "ml" },
            new MjernaJedinica { MjernaJedinicaId = 4, Naziv = "Komad", Oznaka = "kom" },
            new MjernaJedinica { MjernaJedinicaId = 5, Naziv = "Šalica", Oznaka = "šalica" }
         );


        modelBuilder.Entity<ReceptSastojak>().HasData(
            new ReceptSastojak { ReceptSastojakId = 1, ReceptId = 1, SastojakId = 1, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 2, ReceptId = 1, SastojakId = 2, MjernaJedinicaId = 2, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 3, ReceptId = 1, SastojakId = 3, MjernaJedinicaId = 3, Kolicina = 100.00 },
            new ReceptSastojak { ReceptSastojakId = 4, ReceptId = 1, SastojakId = 4, MjernaJedinicaId = 4, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 5, ReceptId = 1, SastojakId = 5, MjernaJedinicaId = 5, Kolicina = 1.00 },

            new ReceptSastojak { ReceptSastojakId = 6, ReceptId = 2, SastojakId = 1, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 7, ReceptId = 2, SastojakId = 2, MjernaJedinicaId = 2, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 8, ReceptId = 2, SastojakId = 3, MjernaJedinicaId = 3, Kolicina = 100.00 },
            new ReceptSastojak { ReceptSastojakId = 9, ReceptId = 2, SastojakId = 4, MjernaJedinicaId = 4, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 10, ReceptId = 2, SastojakId = 6, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 11, ReceptId = 2, SastojakId = 8, MjernaJedinicaId = 5, Kolicina = 1.00 },

            new ReceptSastojak { ReceptSastojakId = 12, ReceptId = 3, SastojakId = 1, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 13, ReceptId = 3, SastojakId = 2, MjernaJedinicaId = 2, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 14, ReceptId = 3, SastojakId = 5, MjernaJedinicaId = 5, Kolicina = 1.00 },

            new ReceptSastojak { ReceptSastojakId = 15, ReceptId = 4, SastojakId = 1, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 16, ReceptId = 4, SastojakId = 4, MjernaJedinicaId = 4, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 17, ReceptId = 4, SastojakId = 9, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 18, ReceptId = 4, SastojakId = 8, MjernaJedinicaId = 5, Kolicina = 1.00 },

            new ReceptSastojak { ReceptSastojakId = 19, ReceptId = 5, SastojakId = 1, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 20, ReceptId = 5, SastojakId = 2, MjernaJedinicaId = 2, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 21, ReceptId = 5, SastojakId = 5, MjernaJedinicaId = 5, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 22, ReceptId = 5, SastojakId = 7, MjernaJedinicaId = 4, Kolicina = 1.00 },

            new ReceptSastojak { ReceptSastojakId = 23, ReceptId = 6, SastojakId = 1, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 24, ReceptId = 6, SastojakId = 6, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 25, ReceptId = 6, SastojakId = 10, MjernaJedinicaId = 5, Kolicina = 1.00 },

            new ReceptSastojak { ReceptSastojakId = 26, ReceptId = 7, SastojakId = 1, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 27, ReceptId = 7, SastojakId = 5, MjernaJedinicaId = 5, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 28, ReceptId = 7, SastojakId = 6, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 29, ReceptId = 7, SastojakId = 7, MjernaJedinicaId = 4, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 30, ReceptId = 7, SastojakId = 10, MjernaJedinicaId = 5, Kolicina = 1.00 },

            new ReceptSastojak { ReceptSastojakId = 31, ReceptId = 8, SastojakId = 1, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 32, ReceptId = 8, SastojakId = 2, MjernaJedinicaId = 2, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 33, ReceptId = 8, SastojakId = 5, MjernaJedinicaId = 5, Kolicina = 1.00 },
            new ReceptSastojak { ReceptSastojakId = 34, ReceptId = 8, SastojakId = 6, MjernaJedinicaId = 1, Kolicina = 200.00 },
            new ReceptSastojak { ReceptSastojakId = 35, ReceptId = 8, SastojakId = 8, MjernaJedinicaId = 5, Kolicina = 1.00 }
         );

        modelBuilder.Entity<Katalog>().HasData(
            new Katalog { KatalogId = 1, Naziv = "Tradicionalna jela", Opis = "Katalog tradicionalnih jela predstavlja zbirku recepata koji cine srz kulturne bastine, obicaja i gastronomskih tradicija iz razlicitih regiona. Svako jelo u ovom katalogu nosi pricu, jedinstvene sastojke i nacin pripreme koji su se prenosili kroz generacije, oblikujuci kulturni identitet zajednica. Bilo da je u pitanju jelo koje se priprema za posebne prilike, ili svakodnevni specijalitet, svaki recept u ovom katalogu odrazava bogatstvo ukusa i tradicije.",
                DatumKreiranja = DateTime.Now }
          );

        modelBuilder.Entity<KatalogRecept>().HasData(
            new KatalogRecept { KatalogReceptId=1, KatalogId=1, ReceptId=3},
            new KatalogRecept { KatalogReceptId = 2, KatalogId = 1, ReceptId = 7 },
            new KatalogRecept { KatalogReceptId = 3, KatalogId = 1, ReceptId = 4 }
            );

        modelBuilder.Entity<Lajkovi>().HasData(
            new Lajkovi { LajkoviId = 1, KorisnikId =2,ReceptId=2,DatumLajka=DateTime.Now },
            new Lajkovi { LajkoviId = 2, KorisnikId = 1, ReceptId = 3, DatumLajka = DateTime.Now },
            new Lajkovi { LajkoviId = 3, KorisnikId = 2, ReceptId = 3, DatumLajka = DateTime.Now }
          );

        modelBuilder.Entity<OmiljeniRecept>().HasData(
            new OmiljeniRecept { OmiljeniReceptId = 1, KorisnikId = 2, ReceptId = 1, DatumDodavanja=DateTime.Now },
            new OmiljeniRecept { OmiljeniReceptId = 2, KorisnikId = 1, ReceptId = 3, DatumDodavanja = DateTime.Now },
            new OmiljeniRecept { OmiljeniReceptId = 3, KorisnikId = 2, ReceptId = 3, DatumDodavanja = DateTime.Now }
        );

        modelBuilder.Entity<Izvjestaj>().HasData(
            new Izvjestaj { IzvjestajId = 1, ReceptId = 3, BrojLajkova = 2,BrojOmiljenih=2, DatumIzvjestaja = new DateTime(2024, 3, 7) }
        );

        modelBuilder.Entity<Notifikacije>().HasData(
           new Notifikacije { NotifikacijeId = 1, KorisnikId = 3, ReceptId = 2, Procitano = true, DatumSlanja=DateTime.Now,Naslov="Test", Sadrzaj="TEst" }
       );
        modelBuilder.Entity<KategorijaTransakcije14072025>().HasData(
            new KategorijaTransakcije14072025 { KategorijaTransakcije14072025Id = 1, Naziv = "Hrana", Tip = Tip.Rashod.ToString() },
            new KategorijaTransakcije14072025 { KategorijaTransakcije14072025Id = 2, Naziv = "Prevoz", Tip = Tip.Rashod.ToString() },
            new KategorijaTransakcije14072025 { KategorijaTransakcije14072025Id = 3, Naziv = "Zabava", Tip = Tip.Rashod.ToString() }
            );

        modelBuilder.Entity<Transakcija14072025>().HasData(
           new Transakcija14072025 { Transakcija14072025Id = 1, KorisnikId = 1, KategorijaTransakcije14072025Id = 3, Iznos=100, DatumTransakcije=new DateTime(2025,07,14),Opis="Test", Status=Status.Planirano.ToString()  },
           new Transakcija14072025 { Transakcija14072025Id = 2, KorisnikId = 2, KategorijaTransakcije14072025Id = 1, Iznos = 100, DatumTransakcije = new DateTime(2025, 07, 14), Opis = "Test", Status = Status.Planirano.ToString() }
          
           );
        modelBuilder.Entity<FinansijskiLimit14072025>().HasData(
         new FinansijskiLimit14072025 { FinansijskiLimit14072025Id = 1, KorisnikId = 2, KategorijaTransakcije14072025Id = 2, Limit=300 },
         new FinansijskiLimit14072025 { FinansijskiLimit14072025Id = 2, KorisnikId = 1, KategorijaTransakcije14072025Id = 2, Limit = 300 }
        
       );
    }
}


using System;
using System.Collections.Generic;
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

    public virtual DbSet<Obavijest> Obavijests { get; set; }

    public virtual DbSet<OmiljeniRecept> OmiljeniRecepts { get; set; }

    public virtual DbSet<Recept> Recepts { get; set; }

    public virtual DbSet<ReceptSastojak> ReceptSastojaks { get; set; }

    public virtual DbSet<Sastojak> Sastojaks { get; set; }

    public virtual DbSet<Uloga> Ulogas { get; set; }

    public virtual DbSet<VrstaJela> VrstaJelas { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Lajkovi>()
       .HasOne(l => l.Korisnik)
       .WithMany(k => k.Lajkovis)
       .HasForeignKey(l => l.KorisnikId)
       .OnDelete(DeleteBehavior.Cascade); // Or DeleteBehavior.Restrict if you want to disable cascading deletes here

        modelBuilder.Entity<Lajkovi>()
            .HasOne(l => l.Recept)
            .WithMany(r => r.Lajkovis)
            .HasForeignKey(l => l.ReceptId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<OmiljeniRecept>()
      .HasOne(o => o.Korisnik)  // Assuming a relationship between OmiljeniRecept and Korisnik
      .WithMany(k => k.OmiljeniRecepts)
      .HasForeignKey(o => o.KorisnikId)
      .OnDelete(DeleteBehavior.Restrict);  // Or DeleteBehavior.SetNull

        modelBuilder.Entity<OmiljeniRecept>()
            .HasOne(o => o.Recept)  // Assuming a relationship between OmiljeniRecept and Recept
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
            new VrstaJela { VrstaJelaId = 4, Naziv = "Kolač" },
            new VrstaJela { VrstaJelaId = 5, Naziv = "Juha" },
            new VrstaJela { VrstaJelaId = 6, Naziv = "Salata" },
            new VrstaJela { VrstaJelaId = 7, Naziv = "Tjestenina" },
            new VrstaJela { VrstaJelaId = 8, Naziv = "Pizza" },
            new VrstaJela { VrstaJelaId = 9, Naziv = "Sendvič" },
            new VrstaJela { VrstaJelaId = 10, Naziv = "Zdravi obrok" }
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
        //modelBuilder.Entity<Recept>().HasData(
        //    new Recept
        //    {
        //        ReceptId = 1,
        //        Naziv = "Palačinke",
        //        OpisRecepta = "Jednostavan recept za ukusne palačinke.",
        //        OpisPripreme = "Pomiješati sve sastojke i ispeći na tavi.",
        //        VrijemePripreme = 20,
        //        KorisnikId = 1,
        //        DatumObjave = DateTime.Now,
        //        Premium = false,
        //        VrstaJelaId = 1, 
        //        KategorijaId = 1, 
        //        Status = true
        //    },
        //    new Recept
        //    { 
        //        ReceptId = 2,
        //        Naziv = "Pizza Margherita",
        //        OpisRecepta = "Klasična pizza s rajčicom, sirom i bosiljkom.",
        //        OpisPripreme = "Pripremiti tijesto, dodati sastojke i ispeći u pećnici.",
        //        VrijemePripreme = 40,
        //        KorisnikId = 2,
        //        DatumObjave = DateTime.Now,
        //        Premium = true,
        //        VrstaJelaId = 8,    
        //        KategorijaId = 2, 
        //        Status = true
        //     }
        //);
        //modelBuilder.Entity<ReceptSastojak>().HasData(
        //    new ReceptSastojak
        //    {
        //        ReceptSastojakId = 1,
        //        ReceptId = 1, 
        //        SastojakId = 1, 
        //        Kolicina = 2,
        //        MjernaJedinica = "kom"
        //    },
        //    new ReceptSastojak
        //    {
        //        ReceptSastojakId = 2,
        //        ReceptId = 1, 
        //        SastojakId = 2, 
        //        Kolicina = 200,
        //        MjernaJedinica = "gr"
        //    },
        //    new ReceptSastojak
        //    {
        //        ReceptSastojakId = 3,
        //        ReceptId = 2, 
        //        SastojakId = 3, 
        //        Kolicina = 1,
        //        MjernaJedinica = "kašičica"
        //    },
        //    new ReceptSastojak
        //    {
        //        ReceptSastojakId = 4,
        //        ReceptId = 2, 
        //        SastojakId = 4, 
        //        Kolicina = 100,
        //        MjernaJedinica = "ml"
        //    }
        //);




    }

}


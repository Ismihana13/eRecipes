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

    public virtual DbSet<KorisnikUloga> KorisnikUlogas { get; set; }

    public virtual DbSet<Lajkovi> Lajkovis { get; set; }

    public virtual DbSet<Obavijest> Obavijests { get; set; }

    public virtual DbSet<OmiljeniRecept> OmiljeniRecepts { get; set; }

    public virtual DbSet<Recept> Recepts { get; set; }

    public virtual DbSet<ReceptSastojak> ReceptSastojaks { get; set; }

    public virtual DbSet<Sastojak> Sastojaks { get; set; }

    public virtual DbSet<Uloga> Ulogas { get; set; }

    public virtual DbSet<VrstaJela> VrstaJelas { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost, 1434; Initial Catalog=eRecipes; user=sa; Password=ismi123; TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Izvjestaj>(entity =>
        {
            entity.HasKey(e => e.IzvjestajId).HasName("PK__Izvjesta__0892A342115805A3");

            entity.ToTable("Izvjestaj");

            entity.Property(e => e.BrojKupovina).HasDefaultValue(0);
            entity.Property(e => e.BrojLajkova).HasDefaultValue(0);
            entity.Property(e => e.BrojPregleda).HasDefaultValue(0);

            entity.HasOne(d => d.Recept).WithMany(p => p.Izvjestajs)
                .HasForeignKey(d => d.ReceptId)
                .HasConstraintName("FK__Izvjestaj__Recep__5BE2A6F2");
        });

        modelBuilder.Entity<Kategorija>(entity =>
        {
            entity.HasKey(e => e.KategorijaId).HasName("PK__Kategori__6C3B8FEE5DB06CF5");

            entity.ToTable("Kategorija");
        });

        modelBuilder.Entity<Korisnik>(entity =>
        {
            entity.HasKey(e => e.KorisnikId).HasName("PK__Korisnik__80B06D412AF902FE");

            entity.ToTable("Korisnik");

            entity.Property(e => e.DatumRodjenja).HasColumnType("datetime");
        });

        modelBuilder.Entity<KorisnikUloga>(entity =>
        {
            entity.HasKey(e => e.KorisnikUlogaId).HasName("PK__Korisnik__1608726E898FD924");

            entity.ToTable("KorisnikUloga");

            entity.Property(e => e.DatumIzmjene).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikUlogas)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__KorisnikU__Koris__3F466844");

            entity.HasOne(d => d.Uloga).WithMany(p => p.KorisnikUlogas)
                .HasForeignKey(d => d.UlogaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__KorisnikU__Uloga__403A8C7D");
        });

        modelBuilder.Entity<Lajkovi>(entity =>
        {
            entity.HasKey(e => e.LajkoviId).HasName("PK__Lajkovi__3D31B5F953B26C49");

            entity.ToTable("Lajkovi");

            entity.Property(e => e.DatumLajka).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Lajkovis)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__Lajkovi__Korisni__4CA06362");

            entity.HasOne(d => d.Recept).WithMany(p => p.Lajkovis)
                .HasForeignKey(d => d.ReceptId)
                .HasConstraintName("FK__Lajkovi__ReceptI__4D94879B");
        });

        modelBuilder.Entity<Obavijest>(entity =>
        {
            entity.HasKey(e => e.ObavijestId).HasName("PK__Obavijes__99D330E0EA8A25AD");

            entity.ToTable("Obavijest");

            entity.Property(e => e.Sadrzaj).HasColumnType("text");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Obavijests)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__Obavijest__Koris__5629CD9C");
        });

        modelBuilder.Entity<OmiljeniRecept>(entity =>
        {
            entity.HasKey(e => e.OmiljeniReceptId).HasName("PK__Omiljeni__1A663C0CF03DFE09");

            entity.ToTable("OmiljeniRecept");

            entity.Property(e => e.DatumDodavanja).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.OmiljeniRecepts)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__OmiljeniR__Koris__48CFD27E");

            entity.HasOne(d => d.Recept).WithMany(p => p.OmiljeniRecepts)
                .HasForeignKey(d => d.ReceptId)
                .HasConstraintName("FK__OmiljeniR__Recep__49C3F6B7");
        });

        modelBuilder.Entity<Recept>(entity =>
        {
            entity.HasKey(e => e.ReceptId).HasName("PK__Recept__AFE1E3C322D7424C");

            entity.ToTable("Recept");

            entity.Property(e => e.DatumObjave).HasColumnType("datetime");
            entity.Property(e => e.OpisRecepta).HasColumnType("text");
            entity.Property(e => e.Premium).HasDefaultValue(false);

            entity.HasOne(d => d.Kategorija).WithMany(p => p.Recepts)
                .HasForeignKey(d => d.KategorijaId)
                .HasConstraintName("FK__Recept__Kategori__45F365D3");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Recepts)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__Recept__Korisnik__440B1D61");

            entity.HasOne(d => d.VrstaJela).WithMany(p => p.Recepts)
                .HasForeignKey(d => d.VrstaJelaId)
                .HasConstraintName("FK__Recept__VrstaJel__44FF419A");
        });

        modelBuilder.Entity<ReceptSastojak>(entity =>
        {
            entity.HasKey(e => e.ReceptSastojakId).HasName("PK__ReceptSa__865053CEFA1A8ED2");

            entity.ToTable("ReceptSastojak");

            entity.Property(e => e.Kolicina).HasColumnType("decimal(5, 2)");

            entity.HasOne(d => d.Recept).WithMany(p => p.ReceptSastojaks)
                .HasForeignKey(d => d.ReceptId)
                .HasConstraintName("FK__ReceptSas__Recep__52593CB8");

            entity.HasOne(d => d.Sastojak).WithMany(p => p.ReceptSastojaks)
                .HasForeignKey(d => d.SastojakId)
                .HasConstraintName("FK__ReceptSas__Sasto__534D60F1");
        });

        modelBuilder.Entity<Sastojak>(entity =>
        {
            entity.HasKey(e => e.SastojakId).HasName("PK__Sastojak__114FC27F5EBEDC87");

            entity.ToTable("Sastojak");
        });

        modelBuilder.Entity<Uloga>(entity =>
        {
            entity.HasKey(e => e.UlogaId).HasName("PK__Uloga__DCAB23CBCE26A230");

            entity.ToTable("Uloga");
        });

        modelBuilder.Entity<VrstaJela>(entity =>
        {
            entity.HasKey(e => e.VrstaJelaId).HasName("PK__VrstaJel__E76FF56D8812CE35");

            entity.ToTable("VrstaJela");

            entity.Property(e => e.Naziv).HasMaxLength(100);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

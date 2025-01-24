using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRecipes.Service.Migrations
{
    /// <inheritdoc />
    public partial class Init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Kategorijas",
                columns: table => new
                {
                    KategorijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kategorijas", x => x.KategorijaId);
                });

            migrationBuilder.CreateTable(
                name: "Sastojaks",
                columns: table => new
                {
                    SastojakId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Sastojaks", x => x.SastojakId);
                });

            migrationBuilder.CreateTable(
                name: "Ulogas",
                columns: table => new
                {
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ulogas", x => x.UlogaId);
                });

            migrationBuilder.CreateTable(
                name: "VrstaJelas",
                columns: table => new
                {
                    VrstaJelaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VrstaJelas", x => x.VrstaJelaId);
                });

            migrationBuilder.CreateTable(
                name: "Korisniks",
                columns: table => new
                {
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumRodjenja = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: false),
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisniks", x => x.KorisnikId);
                    table.ForeignKey(
                        name: "FK_Korisniks_Ulogas_UlogaId",
                        column: x => x.UlogaId,
                        principalTable: "Ulogas",
                        principalColumn: "UlogaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Obavijests",
                columns: table => new
                {
                    ObavijestId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    DatumSlanja = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Obavijests", x => x.ObavijestId);
                    table.ForeignKey(
                        name: "FK_Obavijests_Korisniks_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisniks",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Recepts",
                columns: table => new
                {
                    ReceptId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    OpisRecepta = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    OpisPripreme = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    VrijemePripreme = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    DatumObjave = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Premium = table.Column<bool>(type: "bit", nullable: false),
                    VrstaJelaId = table.Column<int>(type: "int", nullable: false),
                    KategorijaId = table.Column<int>(type: "int", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Recepts", x => x.ReceptId);
                    table.ForeignKey(
                        name: "FK_Recepts_Kategorijas_KategorijaId",
                        column: x => x.KategorijaId,
                        principalTable: "Kategorijas",
                        principalColumn: "KategorijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Recepts_Korisniks_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisniks",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Recepts_VrstaJelas_VrstaJelaId",
                        column: x => x.VrstaJelaId,
                        principalTable: "VrstaJelas",
                        principalColumn: "VrstaJelaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Izvjestajs",
                columns: table => new
                {
                    IzvjestajId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ReceptId = table.Column<int>(type: "int", nullable: false),
                    BrojPregleda = table.Column<int>(type: "int", nullable: false),
                    BrojLajkova = table.Column<int>(type: "int", nullable: false),
                    BrojKupovina = table.Column<int>(type: "int", nullable: false),
                    DatumIzvjestaja = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Izvjestajs", x => x.IzvjestajId);
                    table.ForeignKey(
                        name: "FK_Izvjestajs_Recepts_ReceptId",
                        column: x => x.ReceptId,
                        principalTable: "Recepts",
                        principalColumn: "ReceptId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Lajkovis",
                columns: table => new
                {
                    LajkoviId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    ReceptId = table.Column<int>(type: "int", nullable: false),
                    DatumLajka = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lajkovis", x => x.LajkoviId);
                    table.ForeignKey(
                        name: "FK_Lajkovis_Korisniks_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisniks",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Lajkovis_Recepts_ReceptId",
                        column: x => x.ReceptId,
                        principalTable: "Recepts",
                        principalColumn: "ReceptId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "OmiljeniRecepts",
                columns: table => new
                {
                    OmiljeniReceptId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    ReceptId = table.Column<int>(type: "int", nullable: false),
                    DatumDodavanja = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OmiljeniRecepts", x => x.OmiljeniReceptId);
                    table.ForeignKey(
                        name: "FK_OmiljeniRecepts_Korisniks_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisniks",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_OmiljeniRecepts_Recepts_ReceptId",
                        column: x => x.ReceptId,
                        principalTable: "Recepts",
                        principalColumn: "ReceptId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "ReceptSastojaks",
                columns: table => new
                {
                    ReceptSastojakId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ReceptId = table.Column<int>(type: "int", nullable: false),
                    SastojakId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ReceptSastojaks", x => x.ReceptSastojakId);
                    table.ForeignKey(
                        name: "FK_ReceptSastojaks_Recepts_ReceptId",
                        column: x => x.ReceptId,
                        principalTable: "Recepts",
                        principalColumn: "ReceptId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ReceptSastojaks_Sastojaks_SastojakId",
                        column: x => x.SastojakId,
                        principalTable: "Sastojaks",
                        principalColumn: "SastojakId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Kategorijas",
                columns: new[] { "KategorijaId", "Naziv", "Status" },
                values: new object[,]
                {
                    { 1, "Predjelo", true },
                    { 2, "Glavno jelo", true },
                    { 3, "Desert", true }
                });

            migrationBuilder.InsertData(
                table: "Sastojaks",
                columns: new[] { "SastojakId", "Naziv" },
                values: new object[,]
                {
                    { 1, "Jaje" },
                    { 2, "Brašno" },
                    { 3, "Šećer" },
                    { 4, "Mlijeko" },
                    { 5, "Maslac" },
                    { 6, "So" },
                    { 7, "Prašak za pecivo" },
                    { 8, "Čokolada" },
                    { 9, "Vanilin šećer" },
                    { 10, "Maslinovo ulje" }
                });

            migrationBuilder.InsertData(
                table: "Ulogas",
                columns: new[] { "UlogaId", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Admin", "Ovaj moze sta god hoce :D" },
                    { 2, "Korisnik", "Ovaj je obican smrtnik" },
                    { 3, "Premium korisnik", "Ovaj baja imama para" }
                });

            migrationBuilder.InsertData(
                table: "VrstaJelas",
                columns: new[] { "VrstaJelaId", "Naziv" },
                values: new object[,]
                {
                    { 4, "Kolač" },
                    { 5, "Juha" },
                    { 6, "Salata" },
                    { 7, "Tjestenina" },
                    { 8, "Pizza" },
                    { 9, "Sendvič" },
                    { 10, "Zdravi obrok" }
                });

            migrationBuilder.InsertData(
                table: "Korisniks",
                columns: new[] { "KorisnikId", "DatumRodjenja", "Email", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "Status", "Telefon", "UlogaId" },
                values: new object[,]
                {
                    { 1, new DateTime(1995, 1, 23, 20, 59, 35, 262, DateTimeKind.Local).AddTicks(7303), "admin@mail.com", "Admin", "admin", "tPW/IOLa2TZIKYSA50IDeaJKYtg=", "2G2wAwYkdFgpMleomcwelg==", "Adminovic", true, "060-000-000", 1 },
                    { 2, new DateTime(2002, 1, 23, 20, 59, 35, 262, DateTimeKind.Local).AddTicks(7393), "korisnik@mail.com", "Korisnik", "korisnik", "tPW/IOLa2TZIKYSA50IDeaJKYtg=", "2G2wAwYkdFgpMleomcwelg==", "Korisnikovic", true, "060-000-001", 2 },
                    { 3, new DateTime(1980, 1, 23, 20, 59, 35, 262, DateTimeKind.Local).AddTicks(7397), "bajaspare@mail.com", "Baja", "premium", "tPW/IOLa2TZIKYSA50IDeaJKYtg=", "2G2wAwYkdFgpMleomcwelg==", "Bajaspare", true, "060-000-002", 3 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Izvjestajs_ReceptId",
                table: "Izvjestajs",
                column: "ReceptId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisniks_UlogaId",
                table: "Korisniks",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_Lajkovis_KorisnikId",
                table: "Lajkovis",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Lajkovis_ReceptId",
                table: "Lajkovis",
                column: "ReceptId");

            migrationBuilder.CreateIndex(
                name: "IX_Obavijests_KorisnikId",
                table: "Obavijests",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_OmiljeniRecepts_KorisnikId",
                table: "OmiljeniRecepts",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_OmiljeniRecepts_ReceptId",
                table: "OmiljeniRecepts",
                column: "ReceptId");

            migrationBuilder.CreateIndex(
                name: "IX_Recepts_KategorijaId",
                table: "Recepts",
                column: "KategorijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Recepts_KorisnikId",
                table: "Recepts",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Recepts_VrstaJelaId",
                table: "Recepts",
                column: "VrstaJelaId");

            migrationBuilder.CreateIndex(
                name: "IX_ReceptSastojaks_ReceptId",
                table: "ReceptSastojaks",
                column: "ReceptId");

            migrationBuilder.CreateIndex(
                name: "IX_ReceptSastojaks_SastojakId",
                table: "ReceptSastojaks",
                column: "SastojakId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Izvjestajs");

            migrationBuilder.DropTable(
                name: "Lajkovis");

            migrationBuilder.DropTable(
                name: "Obavijests");

            migrationBuilder.DropTable(
                name: "OmiljeniRecepts");

            migrationBuilder.DropTable(
                name: "ReceptSastojaks");

            migrationBuilder.DropTable(
                name: "Recepts");

            migrationBuilder.DropTable(
                name: "Sastojaks");

            migrationBuilder.DropTable(
                name: "Kategorijas");

            migrationBuilder.DropTable(
                name: "Korisniks");

            migrationBuilder.DropTable(
                name: "VrstaJelas");

            migrationBuilder.DropTable(
                name: "Ulogas");
        }
    }
}

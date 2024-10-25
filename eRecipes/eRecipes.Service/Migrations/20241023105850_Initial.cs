using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRecipes.Service.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Kategorija",
                columns: table => new
                {
                    KategorijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Kategori__6C3B8FEE5DB06CF5", x => x.KategorijaId);
                });

            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumRodjenja = table.Column<DateTime>(type: "datetime", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Korisnik__80B06D412AF902FE", x => x.KorisnikId);
                });

            migrationBuilder.CreateTable(
                name: "Sastojak",
                columns: table => new
                {
                    SastojakId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Sastojak__114FC27F5EBEDC87", x => x.SastojakId);
                });

            migrationBuilder.CreateTable(
                name: "Uloga",
                columns: table => new
                {
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Uloga__DCAB23CBCE26A230", x => x.UlogaId);
                });

            migrationBuilder.CreateTable(
                name: "VrstaJela",
                columns: table => new
                {
                    VrstaJelaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__VrstaJel__E76FF56D8812CE35", x => x.VrstaJelaId);
                });

            migrationBuilder.CreateTable(
                name: "Obavijest",
                columns: table => new
                {
                    ObavijestId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Sadrzaj = table.Column<string>(type: "text", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    DatumSlanja = table.Column<DateOnly>(type: "date", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Obavijes__99D330E0EA8A25AD", x => x.ObavijestId);
                    table.ForeignKey(
                        name: "FK__Obavijest__Koris__5629CD9C",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                });

            migrationBuilder.CreateTable(
                name: "KorisnikUloga",
                columns: table => new
                {
                    KorisnikUlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    UlogaId = table.Column<int>(type: "int", nullable: false),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Korisnik__1608726E898FD924", x => x.KorisnikUlogaId);
                    table.ForeignKey(
                        name: "FK__KorisnikU__Koris__3F466844",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK__KorisnikU__Uloga__403A8C7D",
                        column: x => x.UlogaId,
                        principalTable: "Uloga",
                        principalColumn: "UlogaId");
                });

            migrationBuilder.CreateTable(
                name: "Recept",
                columns: table => new
                {
                    ReceptId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    OpisRecepta = table.Column<string>(type: "text", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    VrijemePripreme = table.Column<int>(type: "int", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    DatumObjave = table.Column<DateTime>(type: "datetime", nullable: true),
                    Premium = table.Column<bool>(type: "bit", nullable: true, defaultValue: false),
                    VrstaJelaId = table.Column<int>(type: "int", nullable: true),
                    KategorijaId = table.Column<int>(type: "int", nullable: true),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    StateMachine = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Recept__AFE1E3C322D7424C", x => x.ReceptId);
                    table.ForeignKey(
                        name: "FK__Recept__Kategori__45F365D3",
                        column: x => x.KategorijaId,
                        principalTable: "Kategorija",
                        principalColumn: "KategorijaId");
                    table.ForeignKey(
                        name: "FK__Recept__Korisnik__440B1D61",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK__Recept__VrstaJel__44FF419A",
                        column: x => x.VrstaJelaId,
                        principalTable: "VrstaJela",
                        principalColumn: "VrstaJelaId");
                });

            migrationBuilder.CreateTable(
                name: "Izvjestaj",
                columns: table => new
                {
                    IzvjestajId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ReceptId = table.Column<int>(type: "int", nullable: true),
                    BrojPregleda = table.Column<int>(type: "int", nullable: true, defaultValue: 0),
                    BrojLajkova = table.Column<int>(type: "int", nullable: true, defaultValue: 0),
                    BrojKupovina = table.Column<int>(type: "int", nullable: true, defaultValue: 0),
                    DatumIzvjestaja = table.Column<DateOnly>(type: "date", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Izvjesta__0892A342115805A3", x => x.IzvjestajId);
                    table.ForeignKey(
                        name: "FK__Izvjestaj__Recep__5BE2A6F2",
                        column: x => x.ReceptId,
                        principalTable: "Recept",
                        principalColumn: "ReceptId");
                });

            migrationBuilder.CreateTable(
                name: "Lajkovi",
                columns: table => new
                {
                    LajkoviId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    ReceptId = table.Column<int>(type: "int", nullable: true),
                    DatumLajka = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Lajkovi__3D31B5F953B26C49", x => x.LajkoviId);
                    table.ForeignKey(
                        name: "FK__Lajkovi__Korisni__4CA06362",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK__Lajkovi__ReceptI__4D94879B",
                        column: x => x.ReceptId,
                        principalTable: "Recept",
                        principalColumn: "ReceptId");
                });

            migrationBuilder.CreateTable(
                name: "OmiljeniRecept",
                columns: table => new
                {
                    OmiljeniReceptId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    ReceptId = table.Column<int>(type: "int", nullable: true),
                    DatumDodavanja = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Omiljeni__1A663C0CF03DFE09", x => x.OmiljeniReceptId);
                    table.ForeignKey(
                        name: "FK__OmiljeniR__Koris__48CFD27E",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId");
                    table.ForeignKey(
                        name: "FK__OmiljeniR__Recep__49C3F6B7",
                        column: x => x.ReceptId,
                        principalTable: "Recept",
                        principalColumn: "ReceptId");
                });

            migrationBuilder.CreateTable(
                name: "ReceptSastojak",
                columns: table => new
                {
                    ReceptSastojakId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ReceptId = table.Column<int>(type: "int", nullable: true),
                    SastojakId = table.Column<int>(type: "int", nullable: true),
                    Kolicina = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    MjernaJedinica = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ReceptSa__865053CEFA1A8ED2", x => x.ReceptSastojakId);
                    table.ForeignKey(
                        name: "FK__ReceptSas__Recep__52593CB8",
                        column: x => x.ReceptId,
                        principalTable: "Recept",
                        principalColumn: "ReceptId");
                    table.ForeignKey(
                        name: "FK__ReceptSas__Sasto__534D60F1",
                        column: x => x.SastojakId,
                        principalTable: "Sastojak",
                        principalColumn: "SastojakId");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Izvjestaj_ReceptId",
                table: "Izvjestaj",
                column: "ReceptId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloga_KorisnikId",
                table: "KorisnikUloga",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloga_UlogaId",
                table: "KorisnikUloga",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_Lajkovi_KorisnikId",
                table: "Lajkovi",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Lajkovi_ReceptId",
                table: "Lajkovi",
                column: "ReceptId");

            migrationBuilder.CreateIndex(
                name: "IX_Obavijest_KorisnikId",
                table: "Obavijest",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_OmiljeniRecept_KorisnikId",
                table: "OmiljeniRecept",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_OmiljeniRecept_ReceptId",
                table: "OmiljeniRecept",
                column: "ReceptId");

            migrationBuilder.CreateIndex(
                name: "IX_Recept_KategorijaId",
                table: "Recept",
                column: "KategorijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Recept_KorisnikId",
                table: "Recept",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Recept_VrstaJelaId",
                table: "Recept",
                column: "VrstaJelaId");

            migrationBuilder.CreateIndex(
                name: "IX_ReceptSastojak_ReceptId",
                table: "ReceptSastojak",
                column: "ReceptId");

            migrationBuilder.CreateIndex(
                name: "IX_ReceptSastojak_SastojakId",
                table: "ReceptSastojak",
                column: "SastojakId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Izvjestaj");

            migrationBuilder.DropTable(
                name: "KorisnikUloga");

            migrationBuilder.DropTable(
                name: "Lajkovi");

            migrationBuilder.DropTable(
                name: "Obavijest");

            migrationBuilder.DropTable(
                name: "OmiljeniRecept");

            migrationBuilder.DropTable(
                name: "ReceptSastojak");

            migrationBuilder.DropTable(
                name: "Uloga");

            migrationBuilder.DropTable(
                name: "Recept");

            migrationBuilder.DropTable(
                name: "Sastojak");

            migrationBuilder.DropTable(
                name: "Kategorija");

            migrationBuilder.DropTable(
                name: "Korisnik");

            migrationBuilder.DropTable(
                name: "VrstaJela");
        }
    }
}

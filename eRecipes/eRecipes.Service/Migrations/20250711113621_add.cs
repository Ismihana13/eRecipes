using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRecipes.Service.Migrations
{
    /// <inheritdoc />
    public partial class add : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "KategorijaTransakcije14072025s",
                columns: table => new
                {
                    KategorijaTransakcije14072025Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Tip = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KategorijaTransakcije14072025s", x => x.KategorijaTransakcije14072025Id);
                });

            migrationBuilder.CreateTable(
                name: "TransakcijaLog14072025s",
                columns: table => new
                {
                    TransakcijaLog14072025Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    StaraVrijednost = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    NovaVrijednost = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumIVrijemePromjene = table.Column<DateTime>(type: "datetime2", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TransakcijaLog14072025s", x => x.TransakcijaLog14072025Id);
                    table.ForeignKey(
                        name: "FK_TransakcijaLog14072025s_Korisniks_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisniks",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "FinansijskiLimit14072025s",
                columns: table => new
                {
                    FinansijskiLimit14072025Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    KategorijaTransakcije14072025Id = table.Column<int>(type: "int", nullable: false),
                    Limit = table.Column<float>(type: "real", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FinansijskiLimit14072025s", x => x.FinansijskiLimit14072025Id);
                    table.ForeignKey(
                        name: "FK_FinansijskiLimit14072025s_KategorijaTransakcije14072025s_KategorijaTransakcije14072025Id",
                        column: x => x.KategorijaTransakcije14072025Id,
                        principalTable: "KategorijaTransakcije14072025s",
                        principalColumn: "KategorijaTransakcije14072025Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_FinansijskiLimit14072025s_Korisniks_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisniks",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Transakcija14072025s",
                columns: table => new
                {
                    Transakcija14072025Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    Iznos = table.Column<float>(type: "real", nullable: false),
                    DatumTransakcije = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    KategorijaTransakcije14072025Id = table.Column<int>(type: "int", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Transakcija14072025s", x => x.Transakcija14072025Id);
                    table.ForeignKey(
                        name: "FK_Transakcija14072025s_KategorijaTransakcije14072025s_KategorijaTransakcije14072025Id",
                        column: x => x.KategorijaTransakcije14072025Id,
                        principalTable: "KategorijaTransakcije14072025s",
                        principalColumn: "KategorijaTransakcije14072025Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Transakcija14072025s_Korisniks_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisniks",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "Katalogs",
                keyColumn: "KatalogId",
                keyValue: 1,
                columns: new[] { "DatumKreiranja", "Opis" },
                values: new object[] { new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(7468), "Katalog tradicionalnih jela predstavlja zbirku recepata koji cine srz kulturne bastine, obicaja i gastronomskih tradicija iz razlicitih regiona. Svako jelo u ovom katalogu nosi pricu, jedinstvene sastojke i nacin pripreme koji su se prenosili kroz generacije, oblikujuci kulturni identitet zajednica. Bilo da je u pitanju jelo koje se priprema za posebne prilike, ili svakodnevni specijalitet, svaki recept u ovom katalogu odrazava bogatstvo ukusa i tradicije." });

            migrationBuilder.InsertData(
                table: "KategorijaTransakcije14072025s",
                columns: new[] { "KategorijaTransakcije14072025Id", "Naziv", "Tip" },
                values: new object[,]
                {
                    { 1, "Hrana", "Rashod" },
                    { 2, "Prevoz", "Rashod" },
                    { 3, "Zabava", "Rashod" }
                });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 1,
                column: "DatumRodjenja",
                value: new DateTime(1995, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(4047));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 2,
                column: "DatumRodjenja",
                value: new DateTime(2002, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(4161));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 3,
                column: "DatumRodjenja",
                value: new DateTime(1980, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(4166));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 1,
                column: "DatumLajka",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(7516));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 2,
                column: "DatumLajka",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(7519));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 3,
                column: "DatumLajka",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(7521));

            migrationBuilder.UpdateData(
                table: "Notifikacijes",
                keyColumn: "NotifikacijeId",
                keyValue: 1,
                column: "DatumSlanja",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(7618));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 1,
                column: "DatumDodavanja",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(7557));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 2,
                column: "DatumDodavanja",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(7560));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 3,
                column: "DatumDodavanja",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(7563));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(4320));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(4513));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(4811));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 4,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(5000));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 5,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(5998));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 6,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(6201));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 7,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(6492));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 8,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(6790));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 9,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(7008));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 10,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 11, 13, 36, 20, 554, DateTimeKind.Local).AddTicks(7150));

            migrationBuilder.InsertData(
                table: "FinansijskiLimit14072025s",
                columns: new[] { "FinansijskiLimit14072025Id", "KategorijaTransakcije14072025Id", "KorisnikId", "Limit" },
                values: new object[,]
                {
                    { 1, 2, 2, 300f },
                    { 2, 2, 1, 300f }
                });

            migrationBuilder.InsertData(
                table: "Transakcija14072025s",
                columns: new[] { "Transakcija14072025Id", "DatumTransakcije", "Iznos", "KategorijaTransakcije14072025Id", "KorisnikId", "Opis", "Status" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 7, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), 100f, 3, 1, "Test", "Planirano" },
                    { 2, new DateTime(2025, 7, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), 100f, 1, 2, "Test", "Planirano" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_FinansijskiLimit14072025s_KategorijaTransakcije14072025Id",
                table: "FinansijskiLimit14072025s",
                column: "KategorijaTransakcije14072025Id");

            migrationBuilder.CreateIndex(
                name: "IX_FinansijskiLimit14072025s_KorisnikId",
                table: "FinansijskiLimit14072025s",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Transakcija14072025s_KategorijaTransakcije14072025Id",
                table: "Transakcija14072025s",
                column: "KategorijaTransakcije14072025Id");

            migrationBuilder.CreateIndex(
                name: "IX_Transakcija14072025s_KorisnikId",
                table: "Transakcija14072025s",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_TransakcijaLog14072025s_KorisnikId",
                table: "TransakcijaLog14072025s",
                column: "KorisnikId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FinansijskiLimit14072025s");

            migrationBuilder.DropTable(
                name: "Transakcija14072025s");

            migrationBuilder.DropTable(
                name: "TransakcijaLog14072025s");

            migrationBuilder.DropTable(
                name: "KategorijaTransakcije14072025s");

            migrationBuilder.UpdateData(
                table: "Katalogs",
                keyColumn: "KatalogId",
                keyValue: 1,
                columns: new[] { "DatumKreiranja", "Opis" },
                values: new object[] { new DateTime(2025, 5, 13, 15, 3, 4, 734, DateTimeKind.Local).AddTicks(379), "Katalog tradicionalnih jela predstavlja zbirku recepata koji čine srž kulturne baštine, običaja i gastronomskih tradicija iz različitih regiona. Svako jelo u ovom katalogu nosi priču, jedinstvene sastojke i način pripreme koji su se prenosili kroz generacije, oblikujući kulturni identitet zajednica. Bilo da je u pitanju jelo koje se priprema za posebne prilike, ili svakodnevni specijalitet, svaki recept u ovom katalogu odražava bogatstvo ukusa i tradicije." });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 1,
                column: "DatumRodjenja",
                value: new DateTime(1995, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(7465));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 2,
                column: "DatumRodjenja",
                value: new DateTime(2002, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(7533));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 3,
                column: "DatumRodjenja",
                value: new DateTime(1980, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(7537));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 1,
                column: "DatumLajka",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 734, DateTimeKind.Local).AddTicks(439));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 2,
                column: "DatumLajka",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 734, DateTimeKind.Local).AddTicks(441));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 3,
                column: "DatumLajka",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 734, DateTimeKind.Local).AddTicks(444));

            migrationBuilder.UpdateData(
                table: "Notifikacijes",
                keyColumn: "NotifikacijeId",
                keyValue: 1,
                column: "DatumSlanja",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 734, DateTimeKind.Local).AddTicks(556));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 1,
                column: "DatumDodavanja",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 734, DateTimeKind.Local).AddTicks(497));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 2,
                column: "DatumDodavanja",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 734, DateTimeKind.Local).AddTicks(501));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 3,
                column: "DatumDodavanja",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 734, DateTimeKind.Local).AddTicks(503));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(7761));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(7890));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(8142));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 4,
                column: "DatumObjave",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(8324));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 5,
                column: "DatumObjave",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(9249));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 6,
                column: "DatumObjave",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(9383));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 7,
                column: "DatumObjave",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(9518));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 8,
                column: "DatumObjave",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(9723));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 9,
                column: "DatumObjave",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 733, DateTimeKind.Local).AddTicks(9947));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 10,
                column: "DatumObjave",
                value: new DateTime(2025, 5, 13, 15, 3, 4, 734, DateTimeKind.Local).AddTicks(83));
        }
    }
}

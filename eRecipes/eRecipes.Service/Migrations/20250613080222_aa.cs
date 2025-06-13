using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRecipes.Service.Migrations
{
    /// <inheritdoc />
    public partial class aa : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "FitPasos",
                columns: table => new
                {
                    FitPasosId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    DatumIzdavanja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Validan = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FitPasos", x => x.FitPasosId);
                    table.ForeignKey(
                        name: "FK_FitPasos_Korisniks_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisniks",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "FitPasos",
                columns: new[] { "FitPasosId", "DatumIzdavanja", "KorisnikId", "Validan" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, true },
                    { 2, new DateTime(2025, 2, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, true }
                });

            migrationBuilder.UpdateData(
                table: "Katalogs",
                keyColumn: "KatalogId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(6082));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 1,
                column: "DatumRodjenja",
                value: new DateTime(1995, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(3046));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 2,
                column: "DatumRodjenja",
                value: new DateTime(2002, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(3116));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 3,
                column: "DatumRodjenja",
                value: new DateTime(1980, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(3120));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 1,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(6142));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 2,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(6145));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 3,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(6148));

            migrationBuilder.UpdateData(
                table: "Notifikacijes",
                keyColumn: "NotifikacijeId",
                keyValue: 1,
                column: "DatumSlanja",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(6238));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 1,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(6174));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 2,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(6176));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 3,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(6179));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(3275));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(3433));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(3679));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 4,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(3841));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 5,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(4864));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 6,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(5124));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 7,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(5259));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 8,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(5453));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 9,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(5637));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 10,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 13, 10, 2, 22, 327, DateTimeKind.Local).AddTicks(5752));

            migrationBuilder.CreateIndex(
                name: "IX_FitPasos_KorisnikId",
                table: "FitPasos",
                column: "KorisnikId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FitPasos");

            migrationBuilder.UpdateData(
                table: "Katalogs",
                keyColumn: "KatalogId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(4021));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 1,
                column: "DatumRodjenja",
                value: new DateTime(1995, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(871));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 2,
                column: "DatumRodjenja",
                value: new DateTime(2002, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(931));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 3,
                column: "DatumRodjenja",
                value: new DateTime(1980, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(934));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 1,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(4075));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 2,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(4078));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 3,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(4081));

            migrationBuilder.UpdateData(
                table: "Notifikacijes",
                keyColumn: "NotifikacijeId",
                keyValue: 1,
                column: "DatumSlanja",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(4169));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 1,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(4105));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 2,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(4108));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 3,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(4111));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(1071));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(1245));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(1588));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 4,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(1758));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 5,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(2781));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 6,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(2918));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 7,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(3054));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 8,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(3243));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 9,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(3565));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 10,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 12, 10, 38, 28, 626, DateTimeKind.Local).AddTicks(3704));
        }
    }
}

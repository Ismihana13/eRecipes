using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRecipes.Service.Migrations
{
    /// <inheritdoc />
    public partial class adddd : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ToDo4924s",
                columns: table => new
                {
                    ToDo4924Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumIzvrsenja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ToDo4924s", x => x.ToDo4924Id);
                    table.ForeignKey(
                        name: "FK_ToDo4924s_Korisniks_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisniks",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                });

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

            migrationBuilder.InsertData(
                table: "ToDo4924s",
                columns: new[] { "ToDo4924Id", "DatumIzvrsenja", "KorisnikId", "Naziv", "Opis", "Status" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 1, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "Aktivnost 1", "Ovo je neka napomena", "Istekla" },
                    { 2, new DateTime(2025, 2, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Aktivnost 2", "Rezervacija za sastanak", "U_toku" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_ToDo4924s_KorisnikId",
                table: "ToDo4924s",
                column: "KorisnikId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ToDo4924s");

            migrationBuilder.UpdateData(
                table: "Katalogs",
                keyColumn: "KatalogId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(9141));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 1,
                column: "DatumRodjenja",
                value: new DateTime(1995, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(5029));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 2,
                column: "DatumRodjenja",
                value: new DateTime(2002, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(5118));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 3,
                column: "DatumRodjenja",
                value: new DateTime(1980, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(5122));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 1,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(9218));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 2,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(9221));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 3,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(9224));

            migrationBuilder.UpdateData(
                table: "Notifikacijes",
                keyColumn: "NotifikacijeId",
                keyValue: 1,
                column: "DatumSlanja",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(9318));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 1,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(9247));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 2,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(9250));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 3,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(9253));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(5320));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(5511));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(5865));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 4,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(6058));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 5,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(7436));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 6,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(7574));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 7,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(7715));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 8,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(7914));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 9,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(8287));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 10,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 9, 15, 40, 41, 223, DateTimeKind.Local).AddTicks(8703));
        }
    }
}

using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRecipes.Service.Migrations
{
    /// <inheritdoc />
    public partial class a : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<decimal>(
                name: "Limit",
                table: "FinansijskiLimit25062026s",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.UpdateData(
                table: "FinansijskiLimit25062026s",
                keyColumn: "FinansijskiLimit25062026Id",
                keyValue: 1,
                column: "Limit",
                value: 100m);

            migrationBuilder.UpdateData(
                table: "FinansijskiLimit25062026s",
                keyColumn: "FinansijskiLimit25062026Id",
                keyValue: 2,
                column: "Limit",
                value: 200m);

            migrationBuilder.UpdateData(
                table: "Katalogs",
                keyColumn: "KatalogId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(5127));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 1,
                column: "DatumRodjenja",
                value: new DateTime(1995, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(1896));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 2,
                column: "DatumRodjenja",
                value: new DateTime(2002, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(1965));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 3,
                column: "DatumRodjenja",
                value: new DateTime(1980, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(1970));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 1,
                column: "DatumLajka",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(5193));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 2,
                column: "DatumLajka",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(5195));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 3,
                column: "DatumLajka",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(5198));

            migrationBuilder.UpdateData(
                table: "Notifikacijes",
                keyColumn: "NotifikacijeId",
                keyValue: 1,
                column: "DatumSlanja",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(5298));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 1,
                column: "DatumDodavanja",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(5226));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 2,
                column: "DatumDodavanja",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(5230));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 3,
                column: "DatumDodavanja",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(5233));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(2131));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(2373));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(2648));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 4,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(2827));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 5,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(3886));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 6,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(4025));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 7,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(4161));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 8,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(4517));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 9,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(4710));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 10,
                column: "DatumObjave",
                value: new DateTime(2025, 7, 2, 11, 5, 26, 36, DateTimeKind.Local).AddTicks(4830));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "Limit",
                table: "FinansijskiLimit25062026s",
                type: "int",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.UpdateData(
                table: "FinansijskiLimit25062026s",
                keyColumn: "FinansijskiLimit25062026Id",
                keyValue: 1,
                column: "Limit",
                value: 100);

            migrationBuilder.UpdateData(
                table: "FinansijskiLimit25062026s",
                keyColumn: "FinansijskiLimit25062026Id",
                keyValue: 2,
                column: "Limit",
                value: 200);

            migrationBuilder.UpdateData(
                table: "Katalogs",
                keyColumn: "KatalogId",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(5291));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 1,
                column: "DatumRodjenja",
                value: new DateTime(1995, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(2280));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 2,
                column: "DatumRodjenja",
                value: new DateTime(2002, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(2350));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikId",
                keyValue: 3,
                column: "DatumRodjenja",
                value: new DateTime(1980, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(2355));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 1,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(5345));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 2,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(5348));

            migrationBuilder.UpdateData(
                table: "Lajkovis",
                keyColumn: "LajkoviId",
                keyValue: 3,
                column: "DatumLajka",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(5351));

            migrationBuilder.UpdateData(
                table: "Notifikacijes",
                keyColumn: "NotifikacijeId",
                keyValue: 1,
                column: "DatumSlanja",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(5446));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 1,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(5376));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 2,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(5379));

            migrationBuilder.UpdateData(
                table: "OmiljeniRecepts",
                keyColumn: "OmiljeniReceptId",
                keyValue: 3,
                column: "DatumDodavanja",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(5382));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(2549));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(2699));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(2945));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 4,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(3129));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 5,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(4055));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 6,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(4238));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 7,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(4393));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 8,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(4612));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 9,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(4827));

            migrationBuilder.UpdateData(
                table: "Recepts",
                keyColumn: "ReceptId",
                keyValue: 10,
                column: "DatumObjave",
                value: new DateTime(2025, 6, 30, 12, 6, 2, 577, DateTimeKind.Local).AddTicks(4973));
        }
    }
}

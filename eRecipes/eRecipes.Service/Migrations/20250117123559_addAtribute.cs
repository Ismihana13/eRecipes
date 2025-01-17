using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRecipes.Service.Migrations
{
    /// <inheritdoc />
    public partial class addAtribute : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "OpisPripreme",
                table: "Recept",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "OpisPripreme",
                table: "Recept");
        }
    }
}

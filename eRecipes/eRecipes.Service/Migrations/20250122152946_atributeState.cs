using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRecipes.Service.Migrations
{
    /// <inheritdoc />
    public partial class atributeState : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "StateMachine",
                table: "Recept");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "StateMachine",
                table: "Recept",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: true);
        }
    }
}

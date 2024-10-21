using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentOglasi.Services.Migrations
{
    /// <inheritdoc />
    public partial class UpdateObavijestiTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ObjaveId",
                table: "Obavijesti",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Obavijesti_ObjaveId",
                table: "Obavijesti",
                column: "ObjaveId");

            migrationBuilder.AddForeignKey(
                name: "FK_Obavijesti_Objave",
                table: "Obavijesti",
                column: "ObjaveId",
                principalTable: "Objave",
                principalColumn: "ID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Obavijesti_Objave",
                table: "Obavijesti");

            migrationBuilder.DropIndex(
                name: "IX_Obavijesti_ObjaveId",
                table: "Obavijesti");

            migrationBuilder.DropColumn(
                name: "ObjaveId",
                table: "Obavijesti");
        }
    }
}

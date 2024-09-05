using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentOglasi.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddObavijestiTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase(
                oldCollation: "SQL_Latin1_General_CP1_CI_AS");

            migrationBuilder.AlterColumn<string>(
                name: "PostType",
                table: "Ocjene",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50);

            migrationBuilder.CreateTable(
                name: "Obavijesti",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SmjestajiId = table.Column<int>(type: "int", nullable: true),
                    OglasiId = table.Column<int>(type: "int", nullable: true),
                    Naziv = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Obavijes__3214EC0753F85485", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Obavijesti_Oglasi",
                        column: x => x.OglasiId,
                        principalTable: "Oglasi",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Obavijesti_Smjestaji",
                        column: x => x.SmjestajiId,
                        principalTable: "Smjestaji",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Obavijesti_OglasiId",
                table: "Obavijesti",
                column: "OglasiId");

            migrationBuilder.CreateIndex(
                name: "IX_Obavijesti_SmjestajiId",
                table: "Obavijesti",
                column: "SmjestajiId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Obavijesti");

            migrationBuilder.AlterDatabase(
                collation: "SQL_Latin1_General_CP1_CI_AS");

            migrationBuilder.AlterColumn<string>(
                name: "PostType",
                table: "Ocjene",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50,
                oldDefaultValue: "");
        }
    }
}

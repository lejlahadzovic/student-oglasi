using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentOglasi.Services.Migrations
{
    /// <inheritdoc />
    public partial class UpdateOcjeneTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Ocjena_Fakultet_FakultetID",
                table: "Ocjene");

            migrationBuilder.DropForeignKey(
                name: "FK_Ocjena_Firma_FirmaID",
                table: "Ocjene");

            migrationBuilder.DropForeignKey(
                name: "FK_Ocjena_Stipenditor_StipenditorID",
                table: "Ocjene");

            migrationBuilder.DropForeignKey(
                name: "FK_Ocjena_Student_StudentId",
                table: "Ocjene");

            migrationBuilder.DropForeignKey(
                name: "FK_Ocjena_Univerzitet_UniverzitetID",
                table: "Ocjene");

            migrationBuilder.DropForeignKey(
                name: "FK__Ocjene__Smjestaj__236943A5",
                table: "Ocjene");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Ocjena",
                table: "Ocjene");

            migrationBuilder.DropIndex(
                name: "IX_Ocjena_FakultetID",
                table: "Ocjene");

            migrationBuilder.DropIndex(
                name: "IX_Ocjena_FirmaID",
                table: "Ocjene");

            migrationBuilder.DropIndex(
                name: "IX_Ocjena_StipenditorID",
                table: "Ocjene");

            migrationBuilder.DropIndex(
                name: "IX_Ocjena_UniverzitetID",
                table: "Ocjene");

            migrationBuilder.DropIndex(
                name: "IX_Ocjene_SmjestajID",
                table: "Ocjene");

            migrationBuilder.DropColumn(
                name: "FakultetID",
                table: "Ocjene");

            migrationBuilder.DropColumn(
                name: "FirmaID",
                table: "Ocjene");

            migrationBuilder.DropColumn(
                name: "Komentar",
                table: "Ocjene");

            migrationBuilder.DropColumn(
                name: "SmjestajID",
                table: "Ocjene");

            migrationBuilder.DropColumn(
                name: "StipenditorID",
                table: "Ocjene");

            migrationBuilder.DropColumn(
                name: "UniverzitetID",
                table: "Ocjene");

            migrationBuilder.RenameColumn(
                name: "Vrijednost",
                table: "Ocjene",
                newName: "PostId");

            migrationBuilder.RenameIndex(
                name: "IX_Ocjena_StudentId",
                table: "Ocjene",
                newName: "IX_Ocjene_StudentId");

            migrationBuilder.AddColumn<decimal>(
                name: "Ocjena",
                table: "Ocjene",
                type: "decimal(3,2)",
                nullable: false,
                defaultValue: 0m);

            migrationBuilder.AddColumn<string>(
                name: "PostType",
                table: "Ocjene",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<string>(
                name: "PostType",
                table: "Komentari",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50);

            migrationBuilder.AddPrimaryKey(
                name: "PK__Ocjene__3214EC27B212595A",
                table: "Ocjene",
                column: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK__Ocjene__StudentI__339FAB6E",
                table: "Ocjene",
                column: "StudentId",
                principalTable: "Studenti",
                principalColumn: "ID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__Ocjene__StudentI__339FAB6E",
                table: "Ocjene");

            migrationBuilder.DropPrimaryKey(
                name: "PK__Ocjene__3214EC27B212595A",
                table: "Ocjene");

            migrationBuilder.DropColumn(
                name: "Ocjena",
                table: "Ocjene");

            migrationBuilder.DropColumn(
                name: "PostType",
                table: "Ocjene");

            migrationBuilder.RenameColumn(
                name: "PostId",
                table: "Ocjene",
                newName: "Vrijednost");

            migrationBuilder.RenameIndex(
                name: "IX_Ocjene_StudentId",
                table: "Ocjene",
                newName: "IX_Ocjena_StudentId");

            migrationBuilder.AddColumn<int>(
                name: "FakultetID",
                table: "Ocjene",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "FirmaID",
                table: "Ocjene",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Komentar",
                table: "Ocjene",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "SmjestajID",
                table: "Ocjene",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "StipenditorID",
                table: "Ocjene",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "UniverzitetID",
                table: "Ocjene",
                type: "int",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "PostType",
                table: "Komentari",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50,
                oldDefaultValue: "");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Ocjena",
                table: "Ocjene",
                column: "ID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_FakultetID",
                table: "Ocjene",
                column: "FakultetID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_FirmaID",
                table: "Ocjene",
                column: "FirmaID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_StipenditorID",
                table: "Ocjene",
                column: "StipenditorID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_UniverzitetID",
                table: "Ocjene",
                column: "UniverzitetID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_SmjestajID",
                table: "Ocjene",
                column: "SmjestajID");

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjena_Fakultet_FakultetID",
                table: "Ocjene",
                column: "FakultetID",
                principalTable: "Fakulteti",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjena_Firma_FirmaID",
                table: "Ocjene",
                column: "FirmaID",
                principalTable: "Organizacije",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjena_Stipenditor_StipenditorID",
                table: "Ocjene",
                column: "StipenditorID",
                principalTable: "Stipenditori",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjena_Student_StudentId",
                table: "Ocjene",
                column: "StudentId",
                principalTable: "Studenti",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjena_Univerzitet_UniverzitetID",
                table: "Ocjene",
                column: "UniverzitetID",
                principalTable: "Univerziteti",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK__Ocjene__Smjestaj__236943A5",
                table: "Ocjene",
                column: "SmjestajID",
                principalTable: "Smjestaji",
                principalColumn: "ID");
        }
    }
}

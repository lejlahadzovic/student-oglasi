using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentOglasi.Services.Migrations
{
    /// <inheritdoc />
    public partial class UpdateKomentariTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Komentar_Komentar_KomentarID",
                table: "Komentari");

            migrationBuilder.DropForeignKey(
                name: "FK_Komentar_Korisnik_KorisnikID",
                table: "Komentari");

            migrationBuilder.DropForeignKey(
                name: "FK_Komentar_Objava_ObjavaID",
                table: "Komentari");

            migrationBuilder.DropForeignKey(
                name: "FK_Komentar_Oglas_OglasID",
                table: "Komentari");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Komentar",
                table: "Komentari");

            migrationBuilder.DropIndex(
                name: "IX_Komentar_KomentarID",
                table: "Komentari");

            migrationBuilder.DropIndex(
                name: "IX_Komentar_ObjavaID",
                table: "Komentari");

            migrationBuilder.DropColumn(
                name: "KomentarID",
                table: "Komentari");

            migrationBuilder.DropColumn(
                name: "ObjavaID",
                table: "Komentari");

            migrationBuilder.RenameColumn(
                name: "KorisnikID",
                table: "Komentari",
                newName: "KorisnikId");

            migrationBuilder.RenameColumn(
                name: "ID",
                table: "Komentari",
                newName: "Id");

            migrationBuilder.RenameColumn(
                name: "OglasID",
                table: "Komentari",
                newName: "ParentKomentarId");

            migrationBuilder.RenameIndex(
                name: "IX_Komentar_OglasID",
                table: "Komentari",
                newName: "IX_Komentar_ParentKomentarId");

            migrationBuilder.AlterColumn<DateTime>(
                name: "VrijemeObjave",
                table: "Komentari",
                type: "datetime",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

            migrationBuilder.AddColumn<int>(
                name: "PostId",
                table: "Komentari",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "PostType",
                table: "Komentari",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddPrimaryKey(
                name: "PK__Komentar__3214EC073529E1CC",
                table: "Komentari",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Komentar_PostID",
                table: "Komentari",
                column: "PostId");

            migrationBuilder.AddForeignKey(
                name: "FK_Komentar_Korisnik",
                table: "Komentari",
                column: "KorisnikId",
                principalTable: "Korisnici",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Komentar_ParentComment",
                table: "Komentari",
                column: "ParentKomentarId",
                principalTable: "Komentari",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Komentar_Korisnik",
                table: "Komentari");

            migrationBuilder.DropForeignKey(
                name: "FK_Komentar_ParentComment",
                table: "Komentari");

            migrationBuilder.DropPrimaryKey(
                name: "PK__Komentar__3214EC073529E1CC",
                table: "Komentari");

            migrationBuilder.DropIndex(
                name: "IX_Komentar_PostID",
                table: "Komentari");

            migrationBuilder.DropColumn(
                name: "PostId",
                table: "Komentari");

            migrationBuilder.DropColumn(
                name: "PostType",
                table: "Komentari");

            migrationBuilder.RenameColumn(
                name: "KorisnikId",
                table: "Komentari",
                newName: "KorisnikID");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Komentari",
                newName: "ID");

            migrationBuilder.RenameColumn(
                name: "ParentKomentarId",
                table: "Komentari",
                newName: "OglasID");

            migrationBuilder.RenameIndex(
                name: "IX_Komentar_ParentKomentarId",
                table: "Komentari",
                newName: "IX_Komentar_OglasID");

            migrationBuilder.AlterColumn<DateTime>(
                name: "VrijemeObjave",
                table: "Komentari",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                oldClrType: typeof(DateTime),
                oldType: "datetime",
                oldNullable: true);

            migrationBuilder.AddColumn<int>(
                name: "KomentarID",
                table: "Komentari",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ObjavaID",
                table: "Komentari",
                type: "int",
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_Komentar",
                table: "Komentari",
                column: "ID");

            migrationBuilder.CreateIndex(
                name: "IX_Komentar_KomentarID",
                table: "Komentari",
                column: "KomentarID");

            migrationBuilder.CreateIndex(
                name: "IX_Komentar_ObjavaID",
                table: "Komentari",
                column: "ObjavaID");

            migrationBuilder.AddForeignKey(
                name: "FK_Komentar_Komentar_KomentarID",
                table: "Komentari",
                column: "KomentarID",
                principalTable: "Komentari",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Komentar_Korisnik_KorisnikID",
                table: "Komentari",
                column: "KorisnikID",
                principalTable: "Korisnici",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Komentar_Objava_ObjavaID",
                table: "Komentari",
                column: "ObjavaID",
                principalTable: "Objave",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Komentar_Oglas_OglasID",
                table: "Komentari",
                column: "OglasID",
                principalTable: "Oglasi",
                principalColumn: "ID");
        }
    }
}

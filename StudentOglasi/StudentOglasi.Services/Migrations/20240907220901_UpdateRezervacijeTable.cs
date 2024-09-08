using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentOglasi.Services.Migrations
{
    /// <inheritdoc />
    public partial class UpdateRezervacijeTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__Rezervaci__Smjes__1209AD79",
                table: "Rezervacije");

            migrationBuilder.DropForeignKey(
                name: "FK__Rezervaci__Statu__13F1F5EB",
                table: "Rezervacije");

            migrationBuilder.DropForeignKey(
                name: "FK__Rezervaci__Stude__12FDD1B2",
                table: "Rezervacije");

            migrationBuilder.DropPrimaryKey(
                name: "PK__Rezervac__A59BA9A7F156796A",
                table: "Rezervacije");

            migrationBuilder.RenameColumn(
                name: "StatusID",
                table: "Rezervacije",
                newName: "StatusId");

            migrationBuilder.RenameColumn(
                name: "StudentID",
                table: "Rezervacije",
                newName: "StudentId");

            migrationBuilder.RenameColumn(
                name: "SmjestajnaJedinicaID",
                table: "Rezervacije",
                newName: "SmjestajnaJedinicaId");

            migrationBuilder.RenameIndex(
                name: "IX_Rezervacije_StudentID",
                table: "Rezervacije",
                newName: "IX_Rezervacije_StudentId");

            migrationBuilder.RenameIndex(
                name: "IX_Rezervacije_StatusID",
                table: "Rezervacije",
                newName: "IX_Rezervacije_StatusId");

            migrationBuilder.AddColumn<int>(
                name: "Id",
                table: "Rezervacije",
                type: "int",
                nullable: false,
                defaultValue: 0)
                .Annotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AddPrimaryKey(
                name: "PK__Rezervac__CABA44DDB20D5066",
                table: "Rezervacije",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_SmjestajnaJedinicaId",
                table: "Rezervacije",
                column: "SmjestajnaJedinicaId");

            migrationBuilder.AddForeignKey(
                name: "FK__Rezervaci__Smjes__3D2915A8",
                table: "Rezervacije",
                column: "SmjestajnaJedinicaId",
                principalTable: "SmjestajnaJedinica",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK__Rezervaci__Statu__3E1D39E1",
                table: "Rezervacije",
                column: "StatusId",
                principalTable: "StatusPrijave",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK__Rezervaci__Stude__3C34F16F",
                table: "Rezervacije",
                column: "StudentId",
                principalTable: "Studenti",
                principalColumn: "ID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__Rezervaci__Smjes__3D2915A8",
                table: "Rezervacije");

            migrationBuilder.DropForeignKey(
                name: "FK__Rezervaci__Statu__3E1D39E1",
                table: "Rezervacije");

            migrationBuilder.DropForeignKey(
                name: "FK__Rezervaci__Stude__3C34F16F",
                table: "Rezervacije");

            migrationBuilder.DropPrimaryKey(
                name: "PK__Rezervac__CABA44DDB20D5066",
                table: "Rezervacije");

            migrationBuilder.DropIndex(
                name: "IX_Rezervacije_SmjestajnaJedinicaId",
                table: "Rezervacije");

            migrationBuilder.DropColumn(
                name: "Id",
                table: "Rezervacije");

            migrationBuilder.RenameColumn(
                name: "StudentId",
                table: "Rezervacije",
                newName: "StudentID");

            migrationBuilder.RenameColumn(
                name: "StatusId",
                table: "Rezervacije",
                newName: "StatusID");

            migrationBuilder.RenameColumn(
                name: "SmjestajnaJedinicaId",
                table: "Rezervacije",
                newName: "SmjestajnaJedinicaID");

            migrationBuilder.RenameIndex(
                name: "IX_Rezervacije_StudentId",
                table: "Rezervacije",
                newName: "IX_Rezervacije_StudentID");

            migrationBuilder.RenameIndex(
                name: "IX_Rezervacije_StatusId",
                table: "Rezervacije",
                newName: "IX_Rezervacije_StatusID");

            migrationBuilder.AddPrimaryKey(
                name: "PK__Rezervac__A59BA9A7F156796A",
                table: "Rezervacije",
                columns: new[] { "SmjestajnaJedinicaID", "StudentID" });

            migrationBuilder.AddForeignKey(
                name: "FK__Rezervaci__Smjes__1209AD79",
                table: "Rezervacije",
                column: "SmjestajnaJedinicaID",
                principalTable: "SmjestajnaJedinica",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK__Rezervaci__Statu__13F1F5EB",
                table: "Rezervacije",
                column: "StatusID",
                principalTable: "StatusPrijave",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK__Rezervaci__Stude__12FDD1B2",
                table: "Rezervacije",
                column: "StudentID",
                principalTable: "Studenti",
                principalColumn: "ID");
        }
    }
}

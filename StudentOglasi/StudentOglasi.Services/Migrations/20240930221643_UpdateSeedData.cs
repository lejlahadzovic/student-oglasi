using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentOglasi.Services.Migrations
{
    /// <inheritdoc />
    public partial class UpdateSeedData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 1,
                column: "Email",
                value: "kemal.hajdarpasic@edu.fit.ba");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 2,
                column: "Email",
                value: "lejla.hadzovic@edu.fit.ba");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 3,
                column: "Email",
                value: "kemal.hajdarpasic@edu.fit.ba");

            migrationBuilder.UpdateData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 1, 2 },
                column: "PropratnoPismo",
                value: "Propratno_pismo_1.pdf");

            migrationBuilder.UpdateData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 2, 3 },
                column: "PropratnoPismo",
                value: "Propratno_pismo_2.pdf");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 1,
                column: "Email",
                value: "kh@example.com");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 2,
                column: "Email",
                value: "lh@example.com");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 3,
                column: "Email",
                value: "kh@example.com");

            migrationBuilder.UpdateData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 1, 2 },
                column: "PropratnoPismo",
                value: "Propratno pismo studenta 1 za praksu 1");

            migrationBuilder.UpdateData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 2, 3 },
                column: "PropratnoPismo",
                value: "Propratno pismo studenta 2 za praksu 2");
        }
    }
}

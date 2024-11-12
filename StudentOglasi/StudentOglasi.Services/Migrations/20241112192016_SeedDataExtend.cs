using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace StudentOglasi.Services.Migrations
{
    /// <inheritdoc />
    public partial class SeedDataExtend : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "PrijavePraksa",
                columns: new[] { "PraksaId", "StudentId", "Certifikati", "CV", "PropratnoPismo", "StatusID" },
                values: new object[,]
                {
                    { 6, 5, "Certifikati_studenta.pdf", "CV_studenta.pdf", "Propratno_pismo.pdf", 4 },
                    { 7, 6, "Certifikati_studenta.pdf", "CV_studenta.pdf", "Propratno_pismo.pdf", 2 },
                    { 8, 7, "Certifikati_studenta.pdf", "CV_studenta.pdf", "Propratno_pismo.pdf", 3 },
                    { 1, 8, "Certifikati_studenta.pdf", "CV_studenta.pdf", "Propratno_pismo.pdf", 2 },
                    { 2, 9, "Certifikati_studenta.pdf", "CV_studenta.pdf", "Propratno_pismo.pdf", 4 }
                });

            migrationBuilder.InsertData(
                table: "PrijaveStipendija",
                columns: new[] { "StipendijaID", "StudentId", "CV", "Dokumentacija", "ProsjekOcjena", "StatusID" },
                values: new object[,]
                {
                    { 12, 6, "CV_studenta.pdf", "Dokumentacija_studenta.pdf", 8.7m, 4 },
                    { 13, 7, "CV_studenta.pdf", "Dokumentacija_studenta.pdf", 9.1m, 2 },
                    { 3, 8, "CV_studenta.pdf", "Dokumentacija_studenta.pdf", 8.0m, 2 },
                    { 4, 9, "CV_studenta.pdf", "Dokumentacija_studenta.pdf", 7.9m, 3 }
                });

            migrationBuilder.InsertData(
                table: "Rezervacije",
                columns: new[] { "Id", "BrojOsoba", "Cijena", "DatumOdjave", "DatumPrijave", "Napomena", "SmjestajnaJedinicaId", "StatusId", "StudentId" },
                values: new object[,]
                {
                    { 3, 2, 250.00m, new DateTime(2024, 8, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Poruka o specijalnim potrebama", 3, 3, 4 },
                    { 4, 4, 400.00m, new DateTime(2024, 9, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), "Dodatni zahtevi za doručak", 4, 3, 5 },
                    { 5, 1, 150.00m, new DateTime(2024, 10, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 10, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, 5, 4, 6 },
                    { 6, 2, 180.00m, new DateTime(2024, 11, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), "Specijalne instrukcije za prijavu", 6, 4, 7 },
                    { 7, 2, 220.00m, new DateTime(2024, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "Kasna prijava", 1, 2, 8 }
                });

            migrationBuilder.UpdateData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 13,
                column: "Naziv",
                value: "hotel4.jpg");

            migrationBuilder.UpdateData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 14,
                column: "Naziv",
                value: "hotel6.jpg");

            migrationBuilder.UpdateData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 15,
                column: "Naziv",
                value: "hotel5.jpg");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 6, 5 });

            migrationBuilder.DeleteData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 7, 6 });

            migrationBuilder.DeleteData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 8, 7 });

            migrationBuilder.DeleteData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 1, 8 });

            migrationBuilder.DeleteData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 2, 9 });

            migrationBuilder.DeleteData(
                table: "PrijaveStipendija",
                keyColumns: new[] { "StipendijaID", "StudentId" },
                keyValues: new object[] { 12, 6 });

            migrationBuilder.DeleteData(
                table: "PrijaveStipendija",
                keyColumns: new[] { "StipendijaID", "StudentId" },
                keyValues: new object[] { 13, 7 });

            migrationBuilder.DeleteData(
                table: "PrijaveStipendija",
                keyColumns: new[] { "StipendijaID", "StudentId" },
                keyValues: new object[] { 3, 8 });

            migrationBuilder.DeleteData(
                table: "PrijaveStipendija",
                keyColumns: new[] { "StipendijaID", "StudentId" },
                keyValues: new object[] { 4, 9 });

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.UpdateData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 13,
                column: "Naziv",
                value: "hotel2.jpg");

            migrationBuilder.UpdateData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 14,
                column: "Naziv",
                value: "hotel3.jpg");

            migrationBuilder.UpdateData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 15,
                column: "Naziv",
                value: "hotel2.jpg");
        }
    }
}

using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentOglasi.Services.Migrations
{
    /// <inheritdoc />
    public partial class SeedDataUpdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 12, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 2,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 12, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 11, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 3,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 12, 31, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 6,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 12, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 10, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 7,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 12, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 8,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 12, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 11, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 10,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 12, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 11,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 12, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 5, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 13,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 12, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 10, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 14,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 12, 29, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 11, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "KrajPrakse", "PocetakPrakse", "StatusID" },
                values: new object[] { new DateTime(2025, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 1, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 3 });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 2,
                columns: new[] { "KrajPrakse", "PocetakPrakse" },
                values: new object[] { new DateTime(2025, 3, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 5,
                column: "StatusID",
                value: 4);

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 6,
                columns: new[] { "KrajPrakse", "PocetakPrakse", "StatusID" },
                values: new object[] { new DateTime(2025, 4, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 3, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 3 });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 7,
                columns: new[] { "KrajPrakse", "PocetakPrakse", "StatusID" },
                values: new object[] { new DateTime(2025, 4, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 3, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 3 });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 8,
                columns: new[] { "KrajPrakse", "PocetakPrakse", "StatusID" },
                values: new object[] { new DateTime(2025, 2, 21, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 3 });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 9,
                column: "StatusID",
                value: 4);

            migrationBuilder.UpdateData(
                table: "StatusOglasi",
                keyColumn: "ID",
                keyValue: 1,
                column: "Naziv",
                value: "Kreiran");

            migrationBuilder.UpdateData(
                table: "StatusOglasi",
                keyColumn: "ID",
                keyValue: 2,
                column: "Naziv",
                value: "Skica");

            migrationBuilder.UpdateData(
                table: "StatusOglasi",
                keyColumn: "ID",
                keyValue: 4,
                column: "Naziv",
                value: "Istekao");

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 3,
                column: "StatusID",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 4,
                column: "StatusID",
                value: 4);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 10,
                column: "StatusID",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 11,
                column: "StatusID",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 12,
                column: "StatusID",
                value: 4);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 13,
                column: "StatusID",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 14,
                column: "StatusID",
                value: 3);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 6, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 2,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 7, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 3,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 6,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 7, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 10, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 7,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 7, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 15, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 8,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 8, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 20, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 10,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 11,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 8, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 13,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 9, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 15, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 14,
                columns: new[] { "RokPrijave", "VrijemeObjave" },
                values: new object[] { new DateTime(2024, 9, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 20, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "KrajPrakse", "PocetakPrakse", "StatusID" },
                values: new object[] { new DateTime(2024, 9, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 7, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 2,
                columns: new[] { "KrajPrakse", "PocetakPrakse" },
                values: new object[] { new DateTime(2024, 10, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 5,
                column: "StatusID",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 6,
                columns: new[] { "KrajPrakse", "PocetakPrakse", "StatusID" },
                values: new object[] { new DateTime(2024, 11, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 7,
                columns: new[] { "KrajPrakse", "PocetakPrakse", "StatusID" },
                values: new object[] { new DateTime(2024, 10, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 8,
                columns: new[] { "KrajPrakse", "PocetakPrakse", "StatusID" },
                values: new object[] { new DateTime(2024, 11, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 9,
                column: "StatusID",
                value: 2);

            migrationBuilder.UpdateData(
                table: "StatusOglasi",
                keyColumn: "ID",
                keyValue: 1,
                column: "Naziv",
                value: "Initial");

            migrationBuilder.UpdateData(
                table: "StatusOglasi",
                keyColumn: "ID",
                keyValue: 2,
                column: "Naziv",
                value: "Draft");

            migrationBuilder.UpdateData(
                table: "StatusOglasi",
                keyColumn: "ID",
                keyValue: 4,
                column: "Naziv",
                value: "Update");

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 3,
                column: "StatusID",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 4,
                column: "StatusID",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 10,
                column: "StatusID",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 11,
                column: "StatusID",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 12,
                column: "StatusID",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 13,
                column: "StatusID",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 14,
                column: "StatusID",
                value: 2);
        }
    }
}

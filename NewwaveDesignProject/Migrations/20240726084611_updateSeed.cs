using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace NewwaveDesignProject.Migrations
{
    /// <inheritdoc />
    public partial class updateSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Invoices",
                columns: new[] { "Id", "Amount", "CardId", "Date", "Icon", "Status", "UserName" },
                values: new object[,]
                {
                    { 5, 50m, 2, new DateTime(2021, 10, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "user1.png", 1, "Willam" },
                    { 6, 120m, 3, new DateTime(2021, 10, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "user1.png", 1, "Willam" },
                    { 7, 150m, 4, new DateTime(2021, 10, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "user1.png", 1, "Willam" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Invoices",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Invoices",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Invoices",
                keyColumn: "Id",
                keyValue: 7);
        }
    }
}

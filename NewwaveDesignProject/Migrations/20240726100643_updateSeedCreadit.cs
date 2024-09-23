using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace NewwaveDesignProject.Migrations
{
    /// <inheritdoc />
    public partial class updateSeedCreadit : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Cards",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "ChipImage", "Logo" },
                values: new object[] { "ChipCardGray.png", "EllipseGray.png" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Cards",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "ChipImage", "Logo" },
                values: new object[] { "ChipCard.png", "Ellipse.png" });
        }
    }
}

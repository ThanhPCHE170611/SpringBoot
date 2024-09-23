using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace NewwaveDesignProject.Migrations
{
    /// <inheritdoc />
    public partial class InitialDB : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "CardTypes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Name = table.Column<string>(type: "TEXT", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CardTypes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "LoanTypes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Name = table.Column<string>(type: "TEXT", nullable: true),
                    Description = table.Column<string>(type: "TEXT", nullable: true),
                    Icon = table.Column<string>(type: "TEXT", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LoanTypes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Stocks",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Name = table.Column<string>(type: "TEXT", nullable: true),
                    Logo = table.Column<string>(type: "TEXT", nullable: true),
                    Description = table.Column<string>(type: "TEXT", nullable: true),
                    Price = table.Column<decimal>(type: "TEXT", nullable: false),
                    ReturnValue = table.Column<decimal>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Stocks", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    UserName = table.Column<string>(type: "TEXT", nullable: true),
                    FullName = table.Column<string>(type: "TEXT", nullable: true),
                    Email = table.Column<string>(type: "TEXT", nullable: true),
                    Password = table.Column<string>(type: "TEXT", nullable: true),
                    DateOfBirth = table.Column<DateTime>(type: "TEXT", nullable: false),
                    PresentAddress = table.Column<string>(type: "TEXT", nullable: true),
                    PermanentAddress = table.Column<string>(type: "TEXT", nullable: true),
                    City = table.Column<string>(type: "TEXT", nullable: true),
                    Country = table.Column<string>(type: "TEXT", nullable: true),
                    PostalCode = table.Column<string>(type: "TEXT", nullable: true),
                    Currency = table.Column<string>(type: "TEXT", nullable: true),
                    TimeZone = table.Column<string>(type: "TEXT", nullable: true),
                    IsReceiveDigitalCurrency = table.Column<bool>(type: "INTEGER", nullable: false),
                    IsReceiveMerchantOrder = table.Column<bool>(type: "INTEGER", nullable: false),
                    IsRecommendation = table.Column<bool>(type: "INTEGER", nullable: false),
                    Avatar = table.Column<string>(type: "TEXT", nullable: true),
                    IsTwoFactorAuthentication = table.Column<bool>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Banks",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Name = table.Column<string>(type: "TEXT", nullable: true),
                    UserId = table.Column<int>(type: "INTEGER", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Banks", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Banks_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "BankServices",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    ServiceName = table.Column<string>(type: "TEXT", nullable: true),
                    Image = table.Column<string>(type: "TEXT", nullable: true),
                    Slogan = table.Column<string>(type: "TEXT", nullable: true),
                    Description = table.Column<string>(type: "TEXT", nullable: true),
                    FirstText = table.Column<string>(type: "TEXT", nullable: true),
                    SecondText = table.Column<string>(type: "TEXT", nullable: true),
                    ThirdText = table.Column<string>(type: "TEXT", nullable: true),
                    FourthText = table.Column<string>(type: "TEXT", nullable: true),
                    FifthText = table.Column<string>(type: "TEXT", nullable: true),
                    SixthText = table.Column<string>(type: "TEXT", nullable: true),
                    UsageCount = table.Column<int>(type: "INTEGER", nullable: false),
                    BankId = table.Column<int>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BankServices", x => x.Id);
                    table.ForeignKey(
                        name: "FK_BankServices_Banks_BankId",
                        column: x => x.BankId,
                        principalTable: "Banks",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Cards",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    UserId = table.Column<int>(type: "INTEGER", nullable: false),
                    BankId = table.Column<int>(type: "INTEGER", nullable: false),
                    CardTypeId = table.Column<int>(type: "INTEGER", nullable: false),
                    Holder = table.Column<string>(type: "TEXT", nullable: true),
                    Number = table.Column<string>(type: "TEXT", nullable: true),
                    ValidThru = table.Column<DateTime>(type: "TEXT", nullable: false),
                    ChipImage = table.Column<string>(type: "TEXT", nullable: true),
                    Logo = table.Column<string>(type: "TEXT", nullable: true),
                    Icon = table.Column<string>(type: "TEXT", nullable: true),
                    Balance = table.Column<decimal>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cards", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Cards_Banks_BankId",
                        column: x => x.BankId,
                        principalTable: "Banks",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Cards_CardTypes_CardTypeId",
                        column: x => x.CardTypeId,
                        principalTable: "CardTypes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Cards_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CardServices",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Icon = table.Column<string>(type: "TEXT", nullable: true),
                    Title = table.Column<string>(type: "TEXT", nullable: true),
                    Content = table.Column<string>(type: "TEXT", nullable: true),
                    CardId = table.Column<int>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CardServices", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CardServices_Cards_CardId",
                        column: x => x.CardId,
                        principalTable: "Cards",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Investments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    CardId = table.Column<int>(type: "INTEGER", nullable: false),
                    StockId = table.Column<int>(type: "INTEGER", nullable: false),
                    Amount = table.Column<decimal>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Investments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Investments_Cards_CardId",
                        column: x => x.CardId,
                        principalTable: "Cards",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Investments_Stocks_StockId",
                        column: x => x.StockId,
                        principalTable: "Stocks",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Invoices",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    CardId = table.Column<int>(type: "INTEGER", nullable: false),
                    Icon = table.Column<string>(type: "TEXT", nullable: true),
                    UserName = table.Column<string>(type: "TEXT", nullable: true),
                    Date = table.Column<DateTime>(type: "TEXT", nullable: false),
                    Amount = table.Column<decimal>(type: "TEXT", nullable: false),
                    Status = table.Column<int>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Invoices", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Invoices_Cards_CardId",
                        column: x => x.CardId,
                        principalTable: "Cards",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Loans",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    LoanMoney = table.Column<decimal>(type: "TEXT", nullable: false),
                    RepayMoney = table.Column<decimal>(type: "TEXT", nullable: false),
                    Duration = table.Column<int>(type: "INTEGER", nullable: false),
                    Interest = table.Column<decimal>(type: "TEXT", nullable: false),
                    Instalment = table.Column<decimal>(type: "TEXT", nullable: false),
                    CardId = table.Column<int>(type: "INTEGER", nullable: false),
                    LoanTypeId = table.Column<int>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Loans", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Loans_Cards_CardId",
                        column: x => x.CardId,
                        principalTable: "Cards",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Loans_LoanTypes_LoanTypeId",
                        column: x => x.LoanTypeId,
                        principalTable: "LoanTypes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Transactions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    InvoiceId = table.Column<int>(type: "INTEGER", nullable: false),
                    Date = table.Column<DateTime>(type: "TEXT", nullable: false),
                    Description = table.Column<string>(type: "TEXT", nullable: true),
                    Amount = table.Column<decimal>(type: "TEXT", nullable: false),
                    Type = table.Column<string>(type: "TEXT", nullable: true),
                    Status = table.Column<string>(type: "TEXT", nullable: true),
                    ImageType = table.Column<string>(type: "TEXT", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Transactions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Transactions_Invoices_InvoiceId",
                        column: x => x.InvoiceId,
                        principalTable: "Invoices",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Banks",
                columns: new[] { "Id", "Name", "UserId" },
                values: new object[,]
                {
                    { 1, "DBL Bank", null },
                    { 2, "BRC Bank", null },
                    { 3, "ABM Bank", null },
                    { 4, "MCB Bank", null }
                });

            migrationBuilder.InsertData(
                table: "CardTypes",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Visa" },
                    { 2, "MasterCard" },
                    { 3, "American Express" },
                    { 4, "Discover" },
                    { 5, "JCB" }
                });

            migrationBuilder.InsertData(
                table: "LoanTypes",
                columns: new[] { "Id", "Description", "Icon", "Name" },
                values: new object[,]
                {
                    { 1, "$50,000", "User.png", "Personal Loan" },
                    { 2, "$100,000", "Bag.png", "Corporate Loans" },
                    { 3, "$500,000", "Support.png", "Business Loans" },
                    { 4, "Chose Money", "Setting.png", "Custom Loans" }
                });

            migrationBuilder.InsertData(
                table: "Stocks",
                columns: new[] { "Id", "Description", "Logo", "Name", "Price", "ReturnValue" },
                values: new object[,]
                {
                    { 1, "E-commerce, Marketplace", "apple.png", "Trivago", 520m, 5m },
                    { 2, "E-commerce, Marketplace", "google.png", "Samsung Mobile", 740m, 5m },
                    { 3, "E-commerce, Marketplace", "apple.png", "Trivago", 200m, -3m },
                    { 4, "E-commerce, Marketplace", "apple.png", "Trivago", 240m, 2m },
                    { 5, "E-commerce, Marketplace", "apple.png", "Trivago", 670m, -12m }
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "Avatar", "City", "Country", "Currency", "DateOfBirth", "Email", "FullName", "IsReceiveDigitalCurrency", "IsReceiveMerchantOrder", "IsRecommendation", "IsTwoFactorAuthentication", "Password", "PermanentAddress", "PostalCode", "PresentAddress", "TimeZone", "UserName" },
                values: new object[] { 1, "userAvatar.png", "San Jose", "USA", "USD", new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "charlenereed@gmail.com", "Charlene Reed", true, false, true, true, "123456", "San Jose, California, USA", "45962", "San Jose, California, USA", "(GMT-12:00) International Date Line West", "Charlene Reed" });

            migrationBuilder.InsertData(
                table: "BankServices",
                columns: new[] { "Id", "BankId", "Description", "FifthText", "FirstText", "FourthText", "Image", "SecondText", "ServiceName", "SixthText", "Slogan", "ThirdText", "UsageCount" },
                values: new object[,]
                {
                    { 1, 1, "It is a long established", "Lorem Ipsum", "Lorem Ipsum", "Many publishing", "LifeInsuranceServices.png", "Many publishing", "Life Insurance", "Many publishing", "Unlimited protection", "Lorem Ipsum", 100 },
                    { 2, 1, "It is a long established", "Lorem Ipsum", "Lorem Ipsum", "Many publishing", "ShoppingServices.png", "Many publishing", "Shopping", "Many publishing", "Buy. Think. Grow.", "Lorem Ipsum", 99 },
                    { 3, 1, "It is a long established", "Lorem Ipsum", "Lorem Ipsum", "Many publishing", "SafetyServices.png", "Many publishing", "Safety", "Many publishing", "We are your allies.", "Lorem Ipsum", 98 },
                    { 4, 1, "It is a long established", "Lorem Ipsum", "Lorem Ipsum", "Many publishing", "Loan.png", "Many publishing", "Bussiness loans", "Many publishing", "Unlimited protection", "Lorem Ipsum", 10 },
                    { 5, 1, "It is a long established", "Lorem Ipsum", "Lorem Ipsum", "Many publishing", "Loan.png", "Many publishing", "Shopping", "Many publishing", "Buy. Think. Grow.", "Lorem Ipsum", 9 },
                    { 6, 1, "It is a long established", "Lorem Ipsum", "Lorem Ipsum", "Many publishing", "Loan.png", "Many publishing", "Safety", "Many publishing", "We are your allies.", "Lorem Ipsum", 8 },
                    { 7, 1, "It is a long established", "Lorem Ipsum", "Lorem Ipsum", "Many publishing", "Loan.png", "Many publishing", "Life Insurance", "Many publishing", "Unlimited protection", "Lorem Ipsum", 7 },
                    { 8, 1, "It is a long established", "Lorem Ipsum", "Lorem Ipsum", "Many publishing", "Loan.png", "Many publishing", "Shopping", "Many publishing", "Buy. Think. Grow.", "Lorem Ipsum", 6 },
                    { 9, 1, "It is a long established", "Lorem Ipsum", "Lorem Ipsum", "Many publishing", "Loan.png", "Many publishing", "Safety", "Many publishing", "We are your allies.", "Lorem Ipsum", 5 }
                });

            migrationBuilder.InsertData(
                table: "Cards",
                columns: new[] { "Id", "Balance", "BankId", "CardTypeId", "ChipImage", "Holder", "Icon", "Logo", "Number", "UserId", "ValidThru" },
                values: new object[,]
                {
                    { 1, 1500.00m, 1, 1, "ChipCard.png", "John Doe", "CreditCardBlue.png", "Ellipse.png", "12345678512345678", 1, new DateTime(2025, 12, 31, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 2, 1500.00m, 1, 1, "ChipCard.png", "Dinh Dien", "CreditCardBlue.png", "Ellipse.png", "12354567812345678", 1, new DateTime(2025, 12, 31, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 3, 2500.00m, 2, 1, "ChipCard.png", "Jane Smith", "CreditCardGold.png", "Ellipse.png", "23458678923456789", 1, new DateTime(2024, 11, 30, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 4, 3000.00m, 3, 1, "ChipCard.png", "Alice Johnson", "CreditCardPink.png", "EllipseGray.png", "34567893034567890", 1, new DateTime(2026, 10, 31, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 5, 3000.00m, 4, 1, "ChipCard.png", "Dinh Khang", "CreditCardPink.png", "EllipseGray.png", "34564789034567890", 1, new DateTime(2026, 10, 31, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 6, 3000.00m, 2, 1, "ChipCard.png", "Dinh Trang", "CreditCardPink.png", "EllipseGray.png", "34567890534567890", 1, new DateTime(2026, 10, 31, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "CardServices",
                columns: new[] { "Id", "CardId", "Content", "Icon", "Title" },
                values: new object[,]
                {
                    { 1, 1, "The most widely accepted credit card.", "AppleIcon.png", "Visa Card" },
                    { 2, 1, "A global payment solutions provider.", "AppleIcon.png", "BlockCard.png" },
                    { 3, 1, "Known for premium services and rewards.", "BlockCard.png", "American Express" },
                    { 4, 1, "Known for premium services and rewards.", "ChangePinCode.png", "American Express" },
                    { 5, 1, "Known for premium services and rewards.", "Gooogle.png", "American Express" }
                });

            migrationBuilder.InsertData(
                table: "Investments",
                columns: new[] { "Id", "Amount", "CardId", "StockId" },
                values: new object[,]
                {
                    { 1, 54000m, 1, 1 },
                    { 2, 25000m, 1, 2 },
                    { 3, 8200m, 1, 3 }
                });

            migrationBuilder.InsertData(
                table: "Invoices",
                columns: new[] { "Id", "Amount", "CardId", "Date", "Icon", "Status", "UserName" },
                values: new object[,]
                {
                    { 1, 450m, 1, new DateTime(2021, 10, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "apple.png", 1, "Apple Store" },
                    { 2, 160m, 1, new DateTime(2021, 10, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "user2.png", 1, "Michael" },
                    { 3, 1085m, 1, new DateTime(2021, 10, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "playstation.png", 1, "Play Station" },
                    { 4, 90m, 1, new DateTime(2021, 10, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "user1.png", 1, "Willam" }
                });

            migrationBuilder.InsertData(
                table: "Loans",
                columns: new[] { "Id", "CardId", "Duration", "Instalment", "Interest", "LoanMoney", "LoanTypeId", "RepayMoney" },
                values: new object[,]
                {
                    { 1, 1, 12, 1000.00m, 0.05m, 10000.00m, 1, 12000.00m },
                    { 2, 1, 24, 1000.00m, 0.06m, 20000.00m, 2, 24000.00m },
                    { 3, 1, 36, 1000.00m, 0.07m, 30000.00m, 1, 36000.00m },
                    { 4, 1, 48, 1000.00m, 0.08m, 40000.00m, 1, 48000.00m },
                    { 5, 1, 60, 1000.00m, 0.09m, 50000.00m, 2, 60000.00m },
                    { 6, 1, 72, 1000.00m, 0.1m, 60000.00m, 2, 72000.00m },
                    { 7, 1, 84, 1000.00m, 0.11m, 70000.00m, 1, 84000.00m },
                    { 8, 1, 96, 1000.00m, 0.12m, 80000.00m, 2, 96000.00m }
                });

            migrationBuilder.InsertData(
                table: "Transactions",
                columns: new[] { "Id", "Amount", "Date", "Description", "ImageType", "InvoiceId", "Status", "Type" },
                values: new object[,]
                {
                    { 1, -150m, new DateTime(2021, 1, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "Spotify Subscription", "bell.png", 1, "Pending", "Shopping" },
                    { 2, -340m, new DateTime(2021, 1, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "Apple Store", "settings.png", 2, "Completed", "Service" },
                    { 3, 780m, new DateTime(2021, 1, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "Apple Store", "user1.png", 2, "Completed", "Transfer" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Banks_UserId",
                table: "Banks",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_BankServices_BankId",
                table: "BankServices",
                column: "BankId");

            migrationBuilder.CreateIndex(
                name: "IX_Cards_BankId",
                table: "Cards",
                column: "BankId");

            migrationBuilder.CreateIndex(
                name: "IX_Cards_CardTypeId",
                table: "Cards",
                column: "CardTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_Cards_UserId",
                table: "Cards",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_CardServices_CardId",
                table: "CardServices",
                column: "CardId");

            migrationBuilder.CreateIndex(
                name: "IX_Investments_CardId",
                table: "Investments",
                column: "CardId");

            migrationBuilder.CreateIndex(
                name: "IX_Investments_StockId",
                table: "Investments",
                column: "StockId");

            migrationBuilder.CreateIndex(
                name: "IX_Invoices_CardId",
                table: "Invoices",
                column: "CardId");

            migrationBuilder.CreateIndex(
                name: "IX_Loans_CardId",
                table: "Loans",
                column: "CardId");

            migrationBuilder.CreateIndex(
                name: "IX_Loans_LoanTypeId",
                table: "Loans",
                column: "LoanTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_Transactions_InvoiceId",
                table: "Transactions",
                column: "InvoiceId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BankServices");

            migrationBuilder.DropTable(
                name: "CardServices");

            migrationBuilder.DropTable(
                name: "Investments");

            migrationBuilder.DropTable(
                name: "Loans");

            migrationBuilder.DropTable(
                name: "Transactions");

            migrationBuilder.DropTable(
                name: "Stocks");

            migrationBuilder.DropTable(
                name: "LoanTypes");

            migrationBuilder.DropTable(
                name: "Invoices");

            migrationBuilder.DropTable(
                name: "Cards");

            migrationBuilder.DropTable(
                name: "Banks");

            migrationBuilder.DropTable(
                name: "CardTypes");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}

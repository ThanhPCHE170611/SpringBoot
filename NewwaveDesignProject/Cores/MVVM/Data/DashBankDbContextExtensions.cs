using Microsoft.EntityFrameworkCore;
using NewwaveDesignProject.Cores.MVVM.Models;
using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Cores.MVVM.Data
{
    public static class DashBankDbContextExtensions
    {
        /// <summary>
        /// This extention method will seed data into database
        /// </summary>
        /// <param name="modelBuilder"></param>
        public static void SeedData(this ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BankService>().HasData(SeedBankServicesList());
            modelBuilder.Entity<User>().HasData(SeedUser());
            modelBuilder.Entity<Bank>().HasData(SeedBank());
            modelBuilder.Entity<CardType>().HasData(SeedCreditCardTypes());
            modelBuilder.Entity<Card>().HasData(SeedCards());
            modelBuilder.Entity<CardService>().HasData(SeedCardServices());
            modelBuilder.Entity<Transaction>().HasData(SeedTransaction());
            modelBuilder.Entity<Invoice>().HasData(SeedInvoice());
            modelBuilder.Entity<Stock>().HasData(SeedStock());
            modelBuilder.Entity<Investment>().HasData(SeedInvestment());
            modelBuilder.Entity<LoanType>().HasData(SeedLoanType());
            modelBuilder.Entity<Loan>().HasData(SeedLoans());

        }
        public static List<BankService> SeedBankServicesList()
        {
            return [
                new()
                {
                    Id = 1,
                    BankId = 1,
                    ServiceName = "Life Insurance",
                    Slogan = "Unlimited protection",
                    Image = "LifeInsuranceServices.png",
                    Description="It is a long established",
                    FirstText="Lorem Ipsum", ThirdText="Lorem Ipsum", FifthText="Lorem Ipsum",
                    SecondText="Many publishing", FourthText="Many publishing", SixthText="Many publishing",
                    UsageCount=100
                },
                 new()
                {
                    Id = 2,
                    BankId = 1,
                    ServiceName = "Shopping",
                    Slogan = "Buy. Think. Grow.",
                    Image = "ShoppingServices.png",
                    Description="It is a long established",
                    FirstText="Lorem Ipsum", ThirdText="Lorem Ipsum", FifthText="Lorem Ipsum",
                    SecondText="Many publishing", FourthText="Many publishing", SixthText="Many publishing",
                    UsageCount=99
                },
                 new()
                {
                    Id = 3,
                    BankId = 1,
                    ServiceName = "Safety",
                    Slogan = "We are your allies.",
                    Image = "SafetyServices.png",
                    Description="It is a long established",
                    FirstText="Lorem Ipsum", ThirdText="Lorem Ipsum", FifthText="Lorem Ipsum",
                    SecondText="Many publishing", FourthText="Many publishing", SixthText="Many publishing",
                    UsageCount=98
                },
                new()
                {
                    Id = 4,
                    BankId = 1,
                    ServiceName = "Bussiness loans",
                    Slogan = "Unlimited protection",
                    Image = "Loan.png",
                    Description="It is a long established",
                    FirstText="Lorem Ipsum", ThirdText="Lorem Ipsum", FifthText="Lorem Ipsum",
                    SecondText="Many publishing", FourthText="Many publishing", SixthText="Many publishing",
                    UsageCount=10

                },
                 new()
                {
                    Id = 5,
                    BankId = 1,
                    ServiceName = "Shopping",
                    Slogan = "Buy. Think. Grow.",
                    Image = "Loan.png",
                    Description="It is a long established",
                    FirstText="Lorem Ipsum", ThirdText="Lorem Ipsum", FifthText="Lorem Ipsum",
                    SecondText="Many publishing", FourthText="Many publishing", SixthText="Many publishing",
                    UsageCount=9
                },
                 new()
                {
                    Id = 6,
                    BankId = 1,
                    ServiceName = "Safety",
                    Slogan = "We are your allies.",
                    Image = "Loan.png",
                    Description="It is a long established",
                    FirstText="Lorem Ipsum", ThirdText="Lorem Ipsum", FifthText="Lorem Ipsum",
                    SecondText="Many publishing", FourthText="Many publishing", SixthText="Many publishing",
                    UsageCount=8
                },
                new()
                {
                    Id = 7,
                    BankId = 1,
                    ServiceName = "Life Insurance",
                    Slogan = "Unlimited protection",
                    Image = "Loan.png",
                    Description="It is a long established",
                    FirstText="Lorem Ipsum", ThirdText="Lorem Ipsum", FifthText="Lorem Ipsum",
                    SecondText="Many publishing", FourthText="Many publishing", SixthText="Many publishing",
                    UsageCount=7
                },
                 new()
                {
                    Id = 8,
                    BankId = 1,
                    ServiceName = "Shopping",
                    Slogan = "Buy. Think. Grow.",
                    Image = "Loan.png",
                    Description="It is a long established",
                    FirstText="Lorem Ipsum", ThirdText="Lorem Ipsum", FifthText="Lorem Ipsum",
                    SecondText="Many publishing", FourthText="Many publishing", SixthText="Many publishing",
                    UsageCount=6
                },
                 new()
                {
                    Id = 9,
                    BankId = 1,
                    ServiceName = "Safety",
                    Slogan = "We are your allies.",
                    Image = "Loan.png",
                    Description="It is a long established",
                    FirstText="Lorem Ipsum", ThirdText="Lorem Ipsum", FifthText="Lorem Ipsum",
                    SecondText="Many publishing", FourthText="Many publishing", SixthText="Many publishing",
                    UsageCount=5
                },
            ];
        }

        public static User SeedUser()
        {
            User user = new User()
            {
                Id = 1,
                Avatar = "userAvatar.png",
                UserName = "Charlene Reed",
                FullName = "Charlene Reed",
                Email = "charlenereed@gmail.com",
                DateOfBirth = new DateTime(10 / 09 / 2003),
                Password = "123456",
                PresentAddress = "San Jose, California, USA",
                PermanentAddress = "San Jose, California, USA",
                City = "San Jose",
                PostalCode = "45962",
                Country = "USA",
                Currency = "USD",
                TimeZone = "(GMT-12:00) International Date Line West",
                IsReceiveDigitalCurrency = true,
                IsRecommendation = true,
                IsTwoFactorAuthentication = true,
            };
            return user;
        }

        public static List<Bank> SeedBank()
        {
            return new List<Bank>
            {
                new Bank { Id = 1, Name = "DBL Bank" },
                new Bank { Id = 2, Name = "BRC Bank" },
                new Bank { Id = 3, Name = "ABM Bank" },
                new Bank { Id = 4, Name = "MCB Bank" }
            };
        }

        public static List<CardType> SeedCreditCardTypes()
        {
            List<CardType> cardTypes = new List<CardType>
            {
                new CardType { Id = 1, Name = "Visa" },
                new CardType { Id = 2, Name = "MasterCard" },
                new CardType { Id = 3, Name = "American Express" },
                new CardType { Id = 4, Name = "Discover" },
                new CardType { Id = 5, Name = "JCB" }
            };

            return cardTypes;
        }
        public static List<Card> SeedCards()
        {
            List<Card> cards = new List<Card>
            {
                new Card
                {
                    Id = 1,
                    UserId = 1,
                    BankId = 1,
                    CardTypeId = 1,
                    Holder = "John Doe",
                    Number = "12345678512345678",
                    ValidThru = new DateTime(2025, 12, 31),
                    ChipImage = "ChipCard.png",
                    Logo = "Ellipse.png",
                    Icon = "CreditCardBlue.png",
                    Balance = 1500.00m,
                    Investments = new ObservableCollection<Investment>(),
                    Invoices = new ObservableCollection<Invoice>(),
                    CardServices = new ObservableCollection<CardService>(),
                    Loans = new ObservableCollection<Loan>()
                },new Card
                {
                    Id = 2,
                    UserId = 1,
                    BankId = 1,
                    CardTypeId = 1,
                    Holder = "Dinh Dien",
                    Number = "12354567812345678",
                    ValidThru = new DateTime(2025, 12, 31),
                    ChipImage = "ChipCard.png",
                    Logo = "Ellipse.png",
                    Icon = "CreditCardBlue.png",
                    Balance = 1500.00m,
                    Investments = new ObservableCollection<Investment>(),
                    Invoices = new ObservableCollection<Invoice>(),
                    CardServices = new ObservableCollection<CardService>(),
                    Loans = new ObservableCollection<Loan>()
                },
                new Card
                {
                    Id = 3,
                    UserId = 1,
                    BankId = 2,
                    CardTypeId = 1,
                    Holder = "Jane Smith",
                    Number = "23458678923456789",
                    ValidThru = new DateTime(2024, 11, 30),
                    ChipImage = "ChipCardGray.png",
                    Logo = "EllipseGray.png",
                    Icon = "CreditCardGold.png",
                    Balance = 2500.00m,
                    Investments = new ObservableCollection<Investment>(),
                    Invoices = new ObservableCollection<Invoice>(),
                    CardServices = new ObservableCollection<CardService>(),
                    Loans = new ObservableCollection<Loan>()
                },
                new Card
                {
                    Id = 4,
                    UserId = 1,
                    BankId = 3,
                    CardTypeId = 1,
                    Holder = "Alice Johnson",
                    Number = "34567893034567890",
                    ValidThru = new DateTime(2026, 10, 31),
                    ChipImage = "ChipCard.png",
                    Logo = "EllipseGray.png",
                    Icon = "CreditCardPink.png",
                    Balance = 3000.00m,
                    Investments = new ObservableCollection<Investment>(),
                    Invoices = new ObservableCollection<Invoice>(),
                    CardServices = new ObservableCollection<CardService>(),
                    Loans = new ObservableCollection<Loan>()
                },
                new Card
                {
                    Id = 5,
                    UserId = 1,
                    BankId = 4,
                    CardTypeId = 1,
                    Holder = "Dinh Khang",
                    Number = "34564789034567890",
                    ValidThru = new DateTime(2026, 10, 31),
                    ChipImage = "ChipCard.png",
                    Logo = "EllipseGray.png",
                    Icon = "CreditCardPink.png",
                    Balance = 3000.00m,
                    Investments = new ObservableCollection<Investment>(),
                    Invoices = new ObservableCollection<Invoice>(),
                    CardServices = new ObservableCollection<CardService>(),
                    Loans = new ObservableCollection<Loan>()
                },
                new Card
                {
                    Id = 6,
                    UserId = 1,
                    BankId = 2,
                    CardTypeId = 1,
                    Holder = "Dinh Trang",
                    Number = "34567890534567890",
                    ValidThru = new DateTime(2026, 10, 31),
                    ChipImage = "ChipCard.png",
                    Logo = "EllipseGray.png",
                    Icon = "CreditCardPink.png",
                    Balance = 3000.00m,
                    Investments = new ObservableCollection<Investment>(),
                    Invoices = new ObservableCollection<Invoice>(),
                    CardServices = new ObservableCollection<CardService>(),
                    Loans = new ObservableCollection<Loan>()
                },
            };

            return cards;
        }

        public static List<CardService> SeedCardServices()
        {
            List<CardService> cardServices = new List<CardService>
            {
                new CardService(1,"AppleIcon.png", "Visa Card", "The most widely accepted credit card.", 1),
                new CardService(2,"AppleIcon.png", "BlockCard.png", "A global payment solutions provider.", 1),
                new CardService(3,"BlockCard.png", "American Express", "Known for premium services and rewards.", 1),
                new CardService(4,"ChangePinCode.png", "American Express", "Known for premium services and rewards.", 1),
                new CardService(5,"Gooogle.png", "American Express", "Known for premium services and rewards.", 1)
            };

            return cardServices;
        }
        public static List<Transaction> SeedTransaction()
        {
            List<Transaction> transactionList = new List<Transaction>()
            {
                new Transaction
                {
                    Id = 1,
                    InvoiceId = 1,
                    Date = new DateTime(2021, 1, 25),
                    Description = "Spotify Subscription",
                    Amount = -150,
                    Status ="Pending",
                    ImageType= "bell.png",
                    Type= "Shopping"
                },
                new Transaction
                {
                    Id = 2,
                    InvoiceId = 2,
                    Date = new DateTime(2021, 1, 25),
                    Description = "Apple Store",
                    Amount = -340,
                    Status ="Completed",
                    ImageType= "settings.png",
                    Type= "Service"
                },
                new Transaction
                {
                    Id = 3,
                    InvoiceId = 2,
                    Date = new DateTime(2021, 1, 25),
                    Description = "Apple Store",
                    Amount = 780,
                    Status ="Completed",
                    ImageType= "user1.png",
                    Type= "Transfer"
                },

            };
            return transactionList;
        }

        public static List<Invoice> SeedInvoice()
        {
            List<Invoice> invoices = new List<Invoice>()
            {
                new Invoice ()
                {
                    Id = 1,
                    Amount = 450,
                    CardId = 1,
                    Date = new DateTime(2021, 10, 1 ),
                    Status = 1,
                    Icon = "apple.png",
                    UserName= "Apple Store"

                }, new Invoice ()
                {
                    Id = 2,
                    Amount = 160 ,
                    CardId = 1,
                    Date = new DateTime(2021, 10, 1 ),
                    Status = 1,
                    Icon = "user2.png",
                    UserName= "Michael"

                }, new Invoice ()
                {
                    Id = 3,
                    Amount = 1085,
                    CardId = 1,
                    Date = new DateTime(2021, 10, 1 ),
                    Status = 1,
                    Icon = "playstation.png",
                    UserName= "Play Station"

                }, new Invoice ()
                {
                    Id = 4,
                    Amount = 90,
                    CardId = 1,
                    Date = new DateTime(2021, 10, 1 ),
                    Status = 1,
                    Icon = "user1.png",
                    UserName= "Willam"

                },new Invoice ()
                {
                    Id = 5,
                    Amount = 50,
                    CardId = 2,
                    Date = new DateTime(2021, 10, 1 ),
                    Status = 1,
                    Icon = "user1.png",
                    UserName= "Willam"

                },new Invoice ()
                {
                    Id = 6,
                    Amount = 120,
                    CardId = 3,
                    Date = new DateTime(2021, 10, 1 ),
                    Status = 1,
                    Icon = "user1.png",
                    UserName= "Willam"

                },new Invoice ()
                {
                    Id = 7,
                    Amount = 150,
                    CardId = 4,
                    Date = new DateTime(2021, 10, 1 ),
                    Status = 1,
                    Icon = "user1.png",
                    UserName= "Willam"

                },
            };
            return invoices;
        }

        public static List<LoanType> SeedLoanType()
        {
            List<LoanType> loanTypes = new List<LoanType>
               {
                new LoanType(1,"Personal Loan", "$50,000", "User.png"),
                new LoanType(2,"Corporate Loans", "$100,000", "Bag.png"),
                new LoanType(3,"Business Loans", "$500,000", "Support.png"),
                new LoanType(4,"Custom Loans", "Chose Money", "Setting.png")
            };

            return loanTypes;
        }

        public static List<Loan> SeedLoans()
        {
            List<Loan> loans = new List<Loan>()
            {
                new Loan(1,10000.00m, 12000.00m, 12, 0.05m, 1000.00m, 1, 1),
                new Loan(2,20000.00m, 24000.00m, 24, 0.06m, 1000.00m, 1, 2),
                new Loan(3,30000.00m, 36000.00m, 36, 0.07m, 1000.00m, 1, 1),
                new Loan(4,40000.00m, 48000.00m, 48, 0.08m, 1000.00m, 1, 1),
                new Loan(5,50000.00m, 60000.00m, 60, 0.09m, 1000.00m, 1, 2),
                new Loan(6,60000.00m, 72000.00m, 72, 0.1m, 1000.00m, 1, 2),
                new Loan(7,70000.00m, 84000.00m, 84, 0.11m, 1000.00m, 1, 1),
                new Loan(8,80000.00m, 96000.00m, 96, 0.12m, 1000.00m, 1, 2)
            };

            return loans;
        }

        public static List<Stock> SeedStock()
        {
            List<Stock> stocks = new List<Stock>()
            {
                new Stock
                {
                    Id = 1,
                    Description = "E-commerce, Marketplace",
                    Logo = "apple.png",
                    Name = "Trivago",
                    Price = 520,
                    ReturnValue = 5,
                },new Stock
                {
                    Id = 2,
                    Description = "E-commerce, Marketplace",
                    Logo = "google.png",
                    Name = "Samsung Mobile",
                    Price = 740,
                    ReturnValue = 5
                },new Stock
                {
                    Id = 3,
                    Description = "E-commerce, Marketplace",
                    Logo = "apple.png",
                    Name = "Trivago",
                    Price = 200,
                    ReturnValue = -3
                },new Stock
                {
                    Id = 4,
                    Description = "E-commerce, Marketplace",
                    Logo = "apple.png",
                    Name = "Trivago",
                    Price = 240,
                    ReturnValue = 2
                },new Stock
                {
                    Id = 5,
                    Description = "E-commerce, Marketplace",
                    Logo = "apple.png",
                    Name = "Trivago",
                    Price = 670,
                    ReturnValue = -12
                }
            };
            return stocks;
        }

        public static List<Investment> SeedInvestment()
        {
            List<Investment> investments = new List<Investment>
            {
                new Investment{
                    Id = 1,
                    CardId = 1,
                    StockId = 1,
                    Amount = 54000,
                },
                new Investment{
                    Id = 2,
                    CardId = 1,
                    StockId = 2,
                    Amount = 25000,
                },
                new Investment{
                    Id = 3,
                    CardId = 1,
                    StockId = 3,
                    Amount = 8200,
                },
            };
            return investments;
        }


    }
}

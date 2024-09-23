using Microsoft.EntityFrameworkCore;
using NewwaveDesignProject.Cores.MVVM.Models;
using System.IO;

namespace NewwaveDesignProject.Cores.MVVM.Data
{
    public partial class DashBankDbContext : DbContext
    {
        string path = Path.GetFullPath(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"..\..\..\DashbankDataBase.db"));

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) 
        {
			optionsBuilder.UseSqlite($"Data Source={path}");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)

        {
            modelBuilder.SeedData();
        }

        public virtual DbSet<Bank> Banks { get; set; }
        public virtual DbSet<BankService> BankServices { get; set; }
        public virtual DbSet<Card> Cards { get; set; }
        public virtual DbSet<CardService> CardServices { get; set; }
        public virtual DbSet<CardType> CardTypes { get; set; }
        public virtual DbSet<Investment> Investments { get; set; }
        public virtual DbSet<Invoice> Invoices { get; set; }
        public virtual DbSet<Loan> Loans { get; set; }
        public virtual DbSet<LoanType> LoanTypes { get; set; }
        public virtual DbSet<Stock> Stocks { get; set; }
        public virtual DbSet<Transaction> Transactions { get; set; }
        public virtual DbSet<User> Users { get; set; }

    }
}

using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class Card : Entity
    {
        [Key]
        public int Id { get; set; }
        [ForeignKey("User")]
        public int UserId { get; set; }

        [ForeignKey("Bank")]
        public int BankId { get; set; }

        [ForeignKey("CardType")]
        public int CardTypeId { get; set; }

        public string? Holder { get; set; }
        public string? Number { get; set; }
        public DateTime ValidThru { get; set; }
        public string? ChipImage { get; set; }
        public string? Logo { get; set; }
        public string? Icon { get; set; }
        public decimal Balance { get; set; }
        public virtual User? User { get; set; }
        public virtual Bank? Bank { get; set; }
        public virtual CardType? CardType { get; set; }

        public virtual ObservableCollection<Investment>? Investments { get; set; }
        public virtual ObservableCollection<Invoice>? Invoices { get; set; }
        public virtual ObservableCollection<CardService>? CardServices { get; set; }
        public virtual ObservableCollection<Loan>? Loans { get; set; }
    }
}


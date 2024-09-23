using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations.Schema;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class Invoice : Entity
    {
		[ForeignKey("Card")]
		public int CardId { get; set; }
		public string? Icon { get; set; }
        public string? UserName { get; set; }
        public DateTime Date { get; set; }
        public decimal Amount { get; set; }
        public int Status { get; set; }
		public virtual Card? Card { get; set; }
		public virtual ObservableCollection<Transaction>? Transactions { get; set; }
        
    }
}

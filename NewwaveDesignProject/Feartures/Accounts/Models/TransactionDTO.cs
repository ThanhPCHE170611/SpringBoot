using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Models;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Accounts.Models
{
    public class TransactionDTO : ModelBase
	{
		public int Id { get; set; }
		public int InvoiceId { get; set; }
		public Brush? BackgroundImage { get; set; }
		public ImageSource? Image { get; set; }
		public string? Description { get; set; }
		public DateTime Date { get; set; }
		public string? Category { get; set; }
		public string? CardNumber { get; set; }
		public string? Status { get; set; }
		public string? Amount { get; set; }
		public virtual Invoice? Invoice { get; set; }
	}
}

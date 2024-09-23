using NewwaveDesignProject.Cores.MVVM;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Accounts.Models
{
    public class InvoiceSent : ModelBase
	{
		public int Id { get; set; }	
		public Brush? BackgroundUser { get; set; }
		public ImageSource? Image { get; set; }
		public string? UserName { get; set; }
		public string? TimeVoice { get; set; }
		public string? Amount { get; set; }
	}
}

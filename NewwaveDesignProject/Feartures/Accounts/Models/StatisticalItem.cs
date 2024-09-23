using NewwaveDesignProject.Cores.MVVM;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Accounts.Models
{
    public class StatisticalItem : ModelBase
	{
		public Brush? BackgroundColor { get; set; }
		public ImageSource? Icon { get; set; }
		public string? Title { get; set; }
		public string? Detail { get; set; }
	}
}

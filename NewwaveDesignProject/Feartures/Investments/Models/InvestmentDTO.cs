using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Models;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Investments.Models
{
    public class InvestmentDTO : ModelBase
	{
		public int Id { get; set; }
		public ImageSource? Icon { get; set; }
		public string? Description { get; set; }
		public string? Name { get; set; }
		public string? Amount { get; set; }
		public string? Unit { get; set; }
		public string? Percentage { get; set; }
		public string? PercentageDescription { get; set; }
		public int CardId { get; set; }
		public int StockId { get; set; }
		public Card? Card { get; set; }
		public Stock? Stock { get; set; }
	}
}

using NewwaveDesignProject.Cores.MVVM;

namespace NewwaveDesignProject.Feartures.Investments.Models
{
    public class StockDTO : ModelBase
	{
		public int NumbericalOrder { get; set; }
		public string? Name { get; set; }
		public string? Description { get; set; }
		public string? Logo { get; set; }
		public string? Price { get; set; }
		public string? ReturnValue { get; set; }
	}
}

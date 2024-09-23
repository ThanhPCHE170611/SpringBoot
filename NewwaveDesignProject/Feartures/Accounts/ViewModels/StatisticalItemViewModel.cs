using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Accounts.Models;

namespace NewwaveDesignProject.Feartures.Accounts.ViewModels
{
	public class StatisticalItemViewModel : ViewModalBase
	{
		public StatisticalItem? statisticalItem { get; set; }
		public StatisticalItem? statisticalItem1 { get; set; }
		public StatisticalItem? statisticalItem2 { get; set; }
		public StatisticalItem? statisticalItem3 { get; set; }

		private void InitialStatisticalItem()
		{
			statisticalItem = new StatisticalItem()
			{
				BackgroundColor = UserInterface.CreateSolidColorBrush("#DCFAF8"),
				Icon = UserInterface.CreateBitmapImage("Accounts", "moneytag.png"),
				Title = "My balance",
				Detail = "$12,750"
			};
		}

		private void InitialStatisticalItem1()
		{
			statisticalItem1 = new StatisticalItem()
			{
				BackgroundColor = UserInterface.CreateSolidColorBrush("#E7EDFF"),
				Icon = UserInterface.CreateBitmapImage("Accounts", "group.png"),
				Title = "Income",
				Detail = "$5,750"
			};
		}
		private void InitialStatisticalItem2()
		{
			statisticalItem2 = new StatisticalItem()
			{
				Title = "Expense",
				BackgroundColor = UserInterface.CreateSolidColorBrush("#FFE0EB"),
				Detail = "$3,750",
				Icon = UserInterface.CreateBitmapImage("Accounts", "medical.png")
			};
		}
		private void InitialStatisticalItem3()
		{
			statisticalItem3 = new StatisticalItem()
			{
				Title = "Total Saving",
				BackgroundColor = UserInterface.CreateSolidColorBrush("#DCFAF8"),
				Detail = "$7,750",
				Icon = UserInterface.CreateBitmapImage("Accounts", "saving.png")
			};
		}
		public StatisticalItemViewModel()
		{
			InitialStatisticalItem();
			InitialStatisticalItem1();
			InitialStatisticalItem2();
			InitialStatisticalItem3();
		}
	}
}

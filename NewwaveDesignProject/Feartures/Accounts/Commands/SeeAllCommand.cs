using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.CreditCards.Views;
using NewwaveDesignProject.Feartures.Investments.Views;
using NewwaveDesignProject.Feartures.Navigations.Models;
using NewwaveDesignProject.Feartures.Navigations.ViewModels;
using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.Feartures.Accounts.Commands
{
	public class SeeAllCommand : BaseCommand<object>
	{
		private readonly NavigationViewModel navigationViewModel;
        public SeeAllCommand(NavigationViewModel NavigationViewModel)
        {
			navigationViewModel = NavigationViewModel;
        }

		public override void Execute(object? parameter)
		{
				MenuItemModel? menuItem = navigationViewModel.MenuItems[Constant.POSITIONCREDITCARD];
				navigationViewModel.MenuItemClickCommand?.Execute(menuItem);
		}
	}
}

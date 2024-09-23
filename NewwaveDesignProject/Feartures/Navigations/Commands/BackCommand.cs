using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.Navigations.Models;
using NewwaveDesignProject.Feartures.Navigations.ViewModels;

namespace NewwaveDesignProject.Feartures.Navigations.Commands
{
	public class BackCommand : BaseCommand<object>
	{

		private readonly NavigationViewModel navigationViewModel;

		public BackCommand(NavigationViewModel NavigationViewModel)
		{
			navigationViewModel = NavigationViewModel;
		}

		public override bool CanExecute(object? parameter) {
			return navigationViewModel.BackStack.Count > 0;
			
		}

		public override void Execute(object? parameter)
		{
			if (navigationViewModel.BackStack.Count > 0)
			{
				navigationViewModel.ForwardStack.Push(navigationViewModel.CurrentMenuIndex);
				navigationViewModel.CurrentMenuIndex = navigationViewModel.BackStack.Pop();
				MenuItemModel? menuItem = navigationViewModel?.MenuItems?[navigationViewModel.CurrentMenuIndex];
				navigationViewModel?.MenuItemClickCommand?.Execute(menuItem);
				
			}

		}
	}
}

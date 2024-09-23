using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.Navigations.Models;
using NewwaveDesignProject.Feartures.Navigations.ViewModels;

namespace NewwaveDesignProject.Feartures.Navigations.Commands
{
	public class NextCommand : BaseCommand<object>
	{
		private NavigationViewModel navigationViewModel;
		public NextCommand(NavigationViewModel viewModel)
		{
			navigationViewModel = viewModel;
		}

		public override bool CanExecute(object? parameter)
		{
			return navigationViewModel.ForwardStack.Count > 0;
		}
		public override void Execute(object? parameter)
		{
			if (navigationViewModel.ForwardStack.Count > 0)
			{
				navigationViewModel.BackStack.Push(navigationViewModel.CurrentMenuIndex);
				navigationViewModel.CurrentMenuIndex = navigationViewModel.ForwardStack.Pop();
				MenuItemModel? menuItem = navigationViewModel.MenuItems?[navigationViewModel.CurrentMenuIndex];
				navigationViewModel.MenuItemClickCommand?.Execute(menuItem);
			}
		}
	}
}

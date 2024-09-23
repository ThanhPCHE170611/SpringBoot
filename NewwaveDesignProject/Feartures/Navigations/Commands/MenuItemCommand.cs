using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.Navigations.Models;
using NewwaveDesignProject.Feartures.Navigations.ViewModels;
using System.Collections.ObjectModel;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Navigation;

namespace NewwaveDesignProject.Feartures.Navigations.Commands
{
	public class MenuItemCommand : BaseCommand<MenuItemModel>
	{
		private readonly NavigationViewModel navigationViewModel;
		private readonly INavigationService _navigationService;

		public MenuItemCommand(NavigationViewModel viewModel, INavigationService navigationService)
		{
			_navigationService = navigationService;
			navigationViewModel = viewModel;
		}

		public override void Execute(object? parameter)
		{
			if (parameter is MenuItemModel menuItem)
			{
				OnMenuItemClick(menuItem);
			}
		}

		public void OnMenuItemClick(MenuItemModel menuItem)
		{
			if (menuItem == null) return;

			int newIndex = navigationViewModel.MenuItems.IndexOf(menuItem);
			if (newIndex != navigationViewModel.CurrentMenuIndex)
			{
				navigationViewModel.BackStack.Push(navigationViewModel.CurrentMenuIndex);
				navigationViewModel.ForwardStack.Clear();
			}

			foreach (var item in navigationViewModel.MenuItems)
			{
				item.IsSelected = (item == menuItem);
				UpdateMenuItemImage(item, item.IsSelected);
			}

			navigationViewModel.CurrentMenuIndex = newIndex;
			NavigateToMenuItem(menuItem);
		}


		private void UpdateMenuItemImage(MenuItemModel menuItem, bool isSelected)
		{
			menuItem.ImageSource = $"/UI/Images/LeftSideBar/{menuItem.Header.Replace(" ", "")}{(isSelected ? "change" : "Default")}.png";
		}

		public void NavigateToMenuItem(MenuItemModel menuItem)
		{
			if (menuItem.ViewType != null)
			{
				_navigationService?.NavigateTo(menuItem.ViewType);
			}
		}

	}

}

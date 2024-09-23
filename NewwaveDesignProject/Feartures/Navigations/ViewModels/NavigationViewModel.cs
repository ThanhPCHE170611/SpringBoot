using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.Accounts.Views;
using NewwaveDesignProject.Feartures.CreditCards.Views;
using NewwaveDesignProject.Feartures.Investments.Views;
using NewwaveDesignProject.Feartures.Navigations.Commands;
using NewwaveDesignProject.Feartures.Navigations.Models;
using NewwaveDesignProject.Views;
using System.Collections.ObjectModel;
using System.Windows.Input;

namespace NewwaveDesignProject.Feartures.Navigations.ViewModels
{
    public class NavigationViewModel : ViewModalBase
	{
		public readonly INavigationService? navigationService;
		public ObservableCollection<MenuItemModel>? MenuItems { get; set; }
		public Stack<int> BackStack { get; } = new Stack<int>();
		public Stack<int> ForwardStack { get; } = new Stack<int>();
		private static bool isFirstMenuItemInitialized = false;
		public int CurrentMenuIndex { get; set; }

		public ICommand? MenuItemClickCommand { get; set; }
		public ICommand? OnBack { get; private set; }
		public ICommand? OnNext { get; private set; }

		public string HeaderText { get; set; }

		public NavigationViewModel(INavigationService navigationService)
		{
			this.navigationService = navigationService;
			InitializeCommands();
			InitializeMenuItems();
			if (!isFirstMenuItemInitialized)
			{
				isFirstMenuItemInitialized = true;
				InitializeFirstMenuItem();
			}
			
		}

		private void InitializeCommands()
		{
			MenuItemClickCommand = new RelayCommand<Object>(Execute);
			OnNext = new NextCommand(this);
			OnBack = new BackCommand(this);
		}

		private void Execute(object parameter)
		{
			if (parameter is MenuItemModel menuItem)
			{
				OnMenuItemClick(menuItem);
			}
		}

		private void InitializeFirstMenuItem()
		{
				MenuItemClickCommand?.Execute(MenuItems?[0]);
		}

		private void InitializeMenuItems()
		{
			MenuItems = new ObservableCollection<MenuItemModel>
				{
					new MenuItemModel { Header = "DashBoard", ViewType = typeof(DashBoard.Views.DashBoard) },
					new MenuItemModel { Header = "Transactions", ViewType = typeof(Transaction.Views.Transaction) },
					new MenuItemModel { Header = "Accounts", ViewType = typeof(Account) },
					new MenuItemModel { Header = "Investments", ViewType = typeof(Investment) },
					new MenuItemModel { Header = "Credit Cards", ViewType = typeof(CreditCardPage) },
					new MenuItemModel { Header = "Loans", ViewType = typeof(LoanPage) },
					new MenuItemModel { Header = "Services", ViewType = typeof(ServicesPage) },
					new MenuItemModel { Header = "My Privileges", ViewType =typeof(SettingPage) },
					new MenuItemModel { Header = "Setting", ViewType = typeof(SettingPage) }
				};
		}
		

		public void OnMenuItemClick(MenuItemModel menuItem)
		{
			if (menuItem == null) return;

			int newIndex = MenuItems.IndexOf(menuItem);
			if (newIndex != CurrentMenuIndex)
			{
				BackStack.Push(CurrentMenuIndex);
				ForwardStack.Clear();
			}

			foreach (var item in MenuItems)
			{
				item.IsSelected = (item == menuItem);
				UpdateMenuItemImage(item, item.IsSelected);
			}

			CurrentMenuIndex = newIndex;
			NavigateToMenuItem(menuItem);
			HeaderText = MenuItems[CurrentMenuIndex].Header;
		}


		private void UpdateMenuItemImage(MenuItemModel menuItem, bool isSelected)
		{
			menuItem.ImageSource = $"/UI/Images/LeftSideBar/{menuItem.Header.Replace(" ", "")}{(isSelected ? "change" : "Default")}.png";
		}

		public void NavigateToMenuItem(MenuItemModel menuItem)
		{
			if (menuItem.ViewType != null)
			{
				navigationService?.NavigateTo(menuItem.ViewType);
			}
		}
	}
}

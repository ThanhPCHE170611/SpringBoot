using NewwaveDesignProject.Cores.MVVM;
using System.Windows.Input;
using NewwaveDesignProject.Cores.MVVM.Data;
using NewwaveDesignProject.Repository;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Feartures.Navigations.ViewModels;
using NewwaveDesignProject.Feartures.DashBoard.Services;
using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.Navigations.Models;

namespace NewwaveDesignProject.Feartures.DashBoard.Viewmodels
{
    public class DashBoardViewModel : ViewModalBase
    {
        public MyCardService myCardViewModel { get; set; }
        public QuickTransferService quickTransferViewModel { get; set; }
        public RecentTransactionServices recentTransactionViewModel { get; set; }
        private NavigationViewModel navigationViewModel;

		public ICommand SeeAllCards { get; set; }
        public DashBoardViewModel(
			NavigationViewModel NavigationViewModel,
            MyCardService myCardService, 
            QuickTransferService quickTransferService,
            RecentTransactionServices recentTransactionServices)
        {
            navigationViewModel = NavigationViewModel;
            myCardViewModel = myCardService;
            quickTransferViewModel = quickTransferService;
            recentTransactionViewModel = recentTransactionServices;
            SeeAllCards = new RelayCommand<object>(NavigateToCreditCard);
        }

        private void NavigateToCreditCard(object t)
        {
            MenuItemModel? menuItem = navigationViewModel.MenuItems[Constant.POSITIONCREDITCARD];
            navigationViewModel.MenuItemClickCommand?.Execute(menuItem);
        }
    }
}

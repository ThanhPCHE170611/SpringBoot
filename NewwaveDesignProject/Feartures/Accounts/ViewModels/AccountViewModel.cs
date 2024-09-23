using LiveCharts;
using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Feartures.Accounts.Commands;
using NewwaveDesignProject.Feartures.Accounts.Models;
using NewwaveDesignProject.Feartures.Accounts.Services;
using NewwaveDesignProject.Feartures.Navigations.ViewModels;
using System.Collections.ObjectModel;
using System.Windows.Input;

namespace NewwaveDesignProject.Feartures.Accounts.ViewModels
{
	public partial class AccountViewModel : ViewModalBase
	{
		private readonly NavigationViewModel navigationViewModel;
		private readonly IAccountService accountService;
		public ObservableCollection<TransactionDTO>? listTransaction { get; set; }
		public ObservableCollection<InvoiceSent>? listInvoiceSent { get; set; }
		public SeriesCollection? RevenueStaticByColumn { get; set; }
		public CardDTO CardData { get; set; }
		public StatisticalItem BalanceStatistic { get; set; }

		public StatisticalItemViewModel statisticalItemViewModel { get; }
		public ICommand SeeAllCommand { get; set; }
		public AccountViewModel(
			IAccountService accountService,
			StatisticalItemViewModel StatisticalItemViewModel,
			NavigationViewModel NavigationViewModel)
		{
			this.accountService = accountService;
			statisticalItemViewModel = StatisticalItemViewModel;
			navigationViewModel = NavigationViewModel;
			SeeAllCommand = new SeeAllCommand(navigationViewModel);
			GetData();
		
		}

		public async Task  GetData() {
			listTransaction = await accountService.getAllTransactionAsync(Constant.USERID);
			listInvoiceSent = await accountService.getAllInvoiceAsync(Constant.USERID);
			RevenueStaticByColumn =  accountService.RevenueStaticByColumn();
			CardData = await accountService.GetCardData();
			BalanceStatistic = await accountService.BalanceStatistic();
		}
	}

}

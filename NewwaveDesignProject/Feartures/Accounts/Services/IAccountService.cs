using LiveCharts;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Feartures.Accounts.Models;
using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Feartures.Accounts.Services
{
	public interface IAccountService
	{
		Task<ObservableCollection<TransactionDTO>> getAllTransactionAsync(int userId);
		Task<ObservableCollection<InvoiceSent>> getAllInvoiceAsync(int userId);
		SeriesCollection RevenueStaticByColumn();
		Task<CardDTO> GetCardData();
		Task<StatisticalItem> BalanceStatistic();
	}
}

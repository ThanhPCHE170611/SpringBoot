using LiveCharts;
using NewwaveDesignProject.Feartures.Investments.Models;
using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Feartures.Investments.Services
{
	public interface IInvestmentService
	{
		Task<ObservableCollection<InvestmentDTO>> getAllInvestmentAsync(int userId);
		Task<ObservableCollection<StockDTO>> getAllStockAsync(int userId);

		SeriesCollection SeriesCollectionLineSmooth();
		SeriesCollection SeriesCollectionLineStraight();

		Task<InvestmentStatisticalItem> GetTotalInvestAmount();
		Task<InvestmentStatisticalItem> GetNumberOfInvestments();
		Task<InvestmentStatisticalItem> GetRateOfReturn();
	}
}

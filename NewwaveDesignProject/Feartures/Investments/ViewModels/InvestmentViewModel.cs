using LiveCharts;
using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Feartures.Investments.Models;
using NewwaveDesignProject.Feartures.Investments.Services;
using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Feartures.Investments.ViewModels
{
	public class InvestmentViewModel:ViewModalBase
	{

		private IInvestmentService investmentService;
		public ObservableCollection<InvestmentDTO>? ListMyInvestment { get; set; }
		public ObservableCollection<StockDTO>? ListTrendingStock { get; set; }
		public SeriesCollection? SeriesCollectionLineSmooth { get; set; }
		public SeriesCollection? SeriesCollectionLineStraight { get; set; }
		public InvestmentStatisticalItem TotalInvestAmount { get; set; }
		public InvestmentStatisticalItem NumberOfInvestments { get; set; }
		public InvestmentStatisticalItem RateOfReturn { get; set; }
		
        public InvestmentViewModel(
			IInvestmentService investmentService)
        {
			this.investmentService= investmentService;
			LoadData();
        }

		public async Task LoadData()
		{
			ListMyInvestment = await investmentService.getAllInvestmentAsync(Constant.USERID);
			ListTrendingStock = await investmentService.getAllStockAsync(Constant.USERID);
			SeriesCollectionLineSmooth = investmentService.SeriesCollectionLineSmooth();
			SeriesCollectionLineStraight = investmentService.SeriesCollectionLineStraight();
			TotalInvestAmount = await investmentService.GetTotalInvestAmount();
			NumberOfInvestments = await investmentService.GetNumberOfInvestments();
			RateOfReturn = await investmentService.GetRateOfReturn();
		}

		
	}
}

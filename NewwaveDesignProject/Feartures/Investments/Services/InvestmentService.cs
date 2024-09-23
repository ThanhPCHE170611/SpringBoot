using LiveCharts;
using LiveCharts.Wpf;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Repository;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Investments.Models;
using System.Collections.ObjectModel;
using System.Linq.Expressions;

namespace NewwaveDesignProject.Feartures.Investments.Services
{
	public class InvestmentService : IInvestmentService
	{
		private Repository<Investment> investmentRepository;
		private Repository<Stock> stocktRepository;
		public Func<double, string> Formatter { get; set; }

		public InvestmentService(Repository<Investment> investmentRepository, Repository<Stock> stocktRepository)
        {
            this.investmentRepository = investmentRepository;
			this.stocktRepository = stocktRepository;
        }

        public async Task<ObservableCollection<InvestmentDTO>> getAllInvestmentAsync(int userId)
		{
			var query = await investmentRepository.GetAllIncludeRelated(
				investment => investment.Amount > 0,
				investment => investment.Stock,
				investment => investment.Card);
			var Investments = query.Select(investment => new InvestmentDTO
			{
				Id = investment.Id,
				Icon = UserInterface.CreateBitmapImage("Investments", investment.Stock.Logo),
				Description = investment.Stock.Description,
				Name = investment.Stock.Name,
				Amount = investment.Amount.ToString("C0"),
				Unit = "InvestmentValue",
				Percentage = investment.Stock.ReturnValue.ToString() + "%",
				PercentageDescription = "Return Value"
			});

			return new ObservableCollection<InvestmentDTO>(Investments);
		}

		public async Task<ObservableCollection<StockDTO>> getAllStockAsync(int userId)
		{
			var query = await stocktRepository.GetAll();
			var Stocks = query.Select(stock => new StockDTO
			{
				NumbericalOrder = stock.Id,
				Name = stock.Name,
				Price = stock.Price.ToString("C0"),
				ReturnValue = stock.ReturnValue.ToString() + "%",
			});

			return new ObservableCollection<StockDTO>(Stocks);
		}

		public SeriesCollection SeriesCollectionLineSmooth()
		{
			return new SeriesCollection
			{
				new LineSeries
				{
					Values = new ChartValues<double> { 11000, 12000, 12500, 20000, 10500, 25000, 26000, 32000, 20000, 28000, 25000, 24500, 14500, 34000 },
					Fill = System.Windows.Media.Brushes.Transparent,
					StrokeThickness = 3,
					PointGeometrySize = 0,
					Stroke = new System.Windows.Media.LinearGradientBrush
					{
						GradientStops = new System.Windows.Media.GradientStopCollection
						{
							new System.Windows.Media.GradientStop(System.Windows.Media.Colors.Blue, 0.05),
							new System.Windows.Media.GradientStop(System.Windows.Media.Colors.Blue, 0.5),
							new System.Windows.Media.GradientStop(System.Windows.Media.Colors.Blue, 0.8),
						}
					}
				}

			};
		}

		public SeriesCollection SeriesCollectionLineStraight()
		{	
			Formatter = value => (2016 + value).ToString();
			return new SeriesCollection
			{
				new LineSeries
				{
					Values = new ChartValues<double> { 5000, 20000, 15000, 35000, 18000, 25000 },
					Fill = System.Windows.Media.Brushes.Transparent,
					StrokeThickness = 3,
					PointGeometrySize = 10,
					PointForeground = System.Windows.Media.Brushes.Orange,
					LineSmoothness = 0,
					Stroke = new System.Windows.Media.SolidColorBrush(System.Windows.Media.Colors.Orange)
				}
			};

			
		}

		public async Task<InvestmentStatisticalItem> GetTotalInvestAmount()
		{
			Expression<Func<Investment, bool>> filter = investment =>
				investment.Amount > 0 && investment.Card.User.Id == Constant.USERID;
			var totalInvestments = await investmentRepository.GetAll(filter);
			return new InvestmentStatisticalItem
			{
				Detail = totalInvestments.Sum(investment =>Convert.ToInt32(investment.Amount)).ToString("C0"),
				Title  = "Total Invested Amount",
				BackgroundColor = UserInterface.CreateSolidColorBrush("#DCFAF8"),
				Icon= UserInterface.CreateBitmapImage("Investments", "moneybag.png")
			};
		}

		public async Task<InvestmentStatisticalItem> GetNumberOfInvestments()
		{
			Expression<Func<Investment, bool>> filter = investment =>
				investment.Amount > 0 && investment.Card.User.Id == Constant.USERID;
			var totalInvestments = await investmentRepository.GetAllIncludeRelated(filter);
			return new InvestmentStatisticalItem
			{
				Detail = totalInvestments.Count().ToString(),
				Title = "Number of Investments",
				BackgroundColor = UserInterface.CreateSolidColorBrush("#FFE0EB"),
				Icon = UserInterface.CreateBitmapImage("Investments", "piechart.png")
			};
		}

		public async Task<InvestmentStatisticalItem> GetRateOfReturn()
		{
			
			var totalInvestments = await investmentRepository.GetAllIncludeRelated(
									investment => investment.Card.User.Id == Constant.USERID,
									investment=> investment.Card.User,
									investment => investment.Stock

			);
			var returnValue = totalInvestments.Sum(investment => investment.Stock.ReturnValue);
			return new InvestmentStatisticalItem
			{
				Detail = returnValue > 0 ? "+" +returnValue.ToString() : "-" + returnValue.ToString(),
				Title = "Rates Of Return",
				BackgroundColor = UserInterface.CreateSolidColorBrush("#E7EDFF"),
				Icon = UserInterface.CreateBitmapImage("Investments", "repeat.png")
			};
		}
	
	}
}

using LiveCharts;
using LiveCharts.Wpf;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Repository;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Accounts.Models;
using System.Collections.ObjectModel;
using System.Linq.Expressions;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Accounts.Services
{
	public class AccountService : IAccountService
	{
		private Repository<Cores.MVVM.Models.Transaction> transactionRepository;
		private Repository<Invoice> invoiceRepository;
		private Repository<Card> cardRepository;

		public Func<double, string>? FormatterColumn { get; set; }
		public List<string>? Labels { get; set; }
		public Func<double, string>? Formatter { get; set; }

		public AccountService(
			Repository<Cores.MVVM.Models.Transaction> transactionRepository,
			Repository<Invoice> invoiceRepository,
			Repository<Card> cardRepository
			)
        {
            this.transactionRepository = transactionRepository;
			this.invoiceRepository = invoiceRepository;
			this.cardRepository = cardRepository;
        }
        public async Task<ObservableCollection<InvoiceSent>> getAllInvoiceAsync(int userId)
		{
			Expression<Func<Invoice, bool>> filter = invoice =>
				   invoice.Card.Id == userId;

			var invoiceList = await invoiceRepository.GetAll(filter);

			var invoiceSentList = invoiceList.Select(invoice => new InvoiceSent
			{
				Id = invoice.Id,
				Image = UserInterface.CreateBitmapImage("Accounts", invoice.Icon),
				UserName = invoice.UserName,
				TimeVoice = FormatDateTime.GetRelativeTimeString(invoice.Date),
				Amount = invoice.Amount.ToString()
			});

			return new ObservableCollection<InvoiceSent>(invoiceSentList);
		}

		public async Task<ObservableCollection<TransactionDTO>> getAllTransactionAsync(int userId)
		{
			Expression<Func<Cores.MVVM.Models.Transaction, bool>> filter = transaction =>
			   transaction.Invoice.Card.User.Id == userId;

			var list = await transactionRepository.GetAllIncludeRelated(
				transaction => transaction.Invoice.Card.User.Id == userId,
				transaction => transaction.Invoice.Card,
				transaction => transaction.Invoice.Card.User,
				transaction => transaction.Invoice
				);

			var transactionDTOs = list.Select(transaction => new TransactionDTO
			{
				Id = transaction.Id,
				Image = UserInterface.CreateBitmapImage("Accounts", transaction.ImageType),
				Description = transaction.Description,
				Date = transaction.Date,
				Category = transaction.Type,
				CardNumber = transaction.Invoice?.Card?.Number?.Substring(0, 4) + " ****",
				Status = transaction.Status,
				Amount = (transaction.Amount >= 0) ? "+$" + transaction.Amount.ToString() : "-$" + Math.Abs(transaction.Amount).ToString()
			});

			return new ObservableCollection<TransactionDTO>(transactionDTOs);
		}

		public SeriesCollection RevenueStaticByColumn()
		{
			Formatter = value => (2016 + value).ToString();
			Labels = new List<string> { "Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri" };

			// Set default formatter
			FormatterColumn = value => value.ToString("N");

			return new SeriesCollection
			{
				new ColumnSeries
				{
					Title = "Debit",
					Values = new ChartValues<double> { 7560, 5000, 8000, 12000, 15000, 20000, 10000 },
					Fill = System.Windows.Media.Brushes.Blue,
					StrokeThickness = 1,
					Stroke = new System.Windows.Media.SolidColorBrush(System.Windows.Media.Colors.Blue),
					//Style = Application.Current.Resources["ColumnSeriesStyle"] as Style
				},

				new ColumnSeries
				{
					Title = "Credit",
					Values = new ChartValues<double> { 5420, 7000, 6000, 9000, 14000, 16000, 7000 },
					Fill = System.Windows.Media.Brushes.Orange,
					StrokeThickness = 1,
					Stroke = new System.Windows.Media.SolidColorBrush(System.Windows.Media.Colors.Orange)
				}
			};
		}

		public async Task<StatisticalItem> BalanceStatistic()
		{
			Expression<Func<Card, bool>> filter = card =>
			   card.User.Id == Constant.USERID;
			var card = await cardRepository.GetAll(filter);
			var balance = card.Sum(c => c.Balance);
			return new StatisticalItem() {
				BackgroundColor = UserInterface.CreateSolidColorBrush("#DCFAF8"),
				Icon = UserInterface.CreateBitmapImage("Accounts", "moneytag.png"),
				Title = "Balance",
				Detail = balance.ToString("C0") 
			};
		}

		public async Task<CardDTO> GetCardData()
		{
			var card = await cardRepository.Get(1);
			return new CardDTO
			{
				BorderBrushTopColor = UserInterface.CreateSolidColorBrush("#2D60FF"),
				BackgroundGradientEnd = (Color)ColorConverter.ConvertFromString("#539BFF"),
				BackgroundGradientStart = (Color)ColorConverter.ConvertFromString("#2D60FF"),
				BorderBackgroundBottom = UserInterface.CreateSolidColorBrush("#539BFF"),
				BorderBrushBottomColor = UserInterface.CreateSolidColorBrush("#2D60FF"),
				ChipSource = UserInterface.CreateBitmapImage("MyCard", card.ChipImage.ToString()),
				Circle = UserInterface.CreateBitmapImage("MyCard", "Ellipse.png"),
				ColorContent = UserInterface.CreateSolidColorBrush("#FFFF"),
				ColorTitle = UserInterface.CreateSolidColorBrush("#FFFF"),
				BlanceTitle = "Balance",
				BlanceAmount =card.Balance.ToString("C0"),
				HolderTitle = "CARD HOLDER",
				HolderName = card.Holder,
				ValidThruTitle = "VALID THRU",
				ValidThruValue = card.ValidThru.ToString("dd/MM/yyyy"),
				Number = card?.Number?.Replace(card.Number.Substring(4, 9), "********"),
			};
		}
	}
}

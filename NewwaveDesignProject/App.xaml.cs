using DryIoc;
using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Data;
using NewwaveDesignProject.Cores.MVVM.Repository;
using NewwaveDesignProject.Feartures.Accounts.Services;
using NewwaveDesignProject.Feartures.Accounts.ViewModels;
using NewwaveDesignProject.Feartures.Accounts.Views;
using NewwaveDesignProject.Feartures.CreditCards.Views;
using NewwaveDesignProject.Feartures.DashBoard.Viewmodels;
using NewwaveDesignProject.Feartures.DashBoard.Views;
using NewwaveDesignProject.Feartures.Investments.Services;
using NewwaveDesignProject.Feartures.Investments.ViewModels;
using NewwaveDesignProject.Feartures.Investments.Views;
using NewwaveDesignProject.Feartures.Navigations.ViewModels;
using NewwaveDesignProject.Feartures.Navigations.Views;
using NewwaveDesignProject.ViewModels;
using NewwaveDesignProject.Feartures.Transaction.Services;
using NewwaveDesignProject.Feartures.Transaction.ViewModels;
using NewwaveDesignProject.Feartures.Transaction.Views;
using NewwaveDesignProject.Services;
using NewwaveDesignProject.Views;
using System.Windows;
using System.Windows.Controls;
using Container = DryIoc.Container;
//using NewwaveDesignProject.Feartures.Loans.ViewModels;

namespace NewwaveDesignProject
{
    public partial class App : Application
	{
		public Container Container;

		public App()
		{
			Container = new Container(rules => rules.WithAutoConcreteTypeResolution()
								   .WithCaptureContainerDisposeStackTrace()
								   .WithTrackingDisposableTransients());
			SetupDI();
		}
		private void SetupDI()
		{
			RegisterFrame();
			RegisterServices();
			RegisterViewModels();
			RegisterRepositories();

		}
		private void RegisterFrame()
		{
			Container.RegisterDelegate<Frame>(_ => ((MainWindow)Application.Current.MainWindow).FrameWindow);

			Container.Register<MainWindow>();
			Container.Register<DashBoard>();
			Container.Register<Account>();
			Container.Register<Investment>();
			Container.Register<CreditCardPage>();
			Container.Register<LoanPage>();
			Container.Register<SettingPage>();
			Container.Register<Transaction>();
			Container.Register<Navigation>();
		}

		private void RegisterServices()
		{

			Container.Register<INavigationService, NavigationService>();
			Container.RegisterDelegate<NavigationService>(reuse => new NavigationService(reuse.Resolve<Frame>()));
			Container.Register<IAccountService, AccountService>();
			Container.Register<IInvestmentService, InvestmentService>();
			Container.Register<ICreditCardService, CreditCardServices>();
			Container.Register<TransactionService>(Reuse.Transient);
			Container.Register<PaginationService>(Reuse.Transient);
			Container.Register<FilterService>(Reuse.Transient);
			Container.Register<ILoanService, LoanServices>(Reuse.Transient);
			Container.Register<IBankServices, BankServices>(Reuse.Transient);
			Container.Register<IUserServices, UserServices>(Reuse.Transient);
		}

		private void RegisterViewModels()
		{
			Container.Register<MainWindowViewModel>();
			Container.Register<NavigationViewModel>();
			Container.Register<HeaderViewModel>();
			Container.Register<StatisticalItemViewModel>();
			Container.Register<InvestmentViewModel>();
			Container.Register<DashBoardViewModel>();
			Container.Register<CreaditCardsViewModel>(Reuse.Transient);
			Container.Register<LoanViewModel>(Reuse.Transient);
			Container.Register<AccountViewModel>();
			Container.Register<SettingViewModel>(Reuse.Transient);
		}

		private void RegisterRepositories()
		{
			Container.Register(typeof(IRepository<>), typeof(Repository<>));
			Container.Register<DashBankDbContext>();
		}
	}

}

using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.Navigations.ViewModels;
using NewwaveDesignProject.Feartures.Transaction.Models;
using NewwaveDesignProject.Feartures.Transaction.Services;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;
using NewwaveDesignProject.Feartures.Navigations.Models;

namespace NewwaveDesignProject.Feartures.Transaction.ViewModels
{
    public class TransactionViewModel : ViewModalBase
    {
        private readonly TransactionService transactionService;
        private readonly PaginationService paginationService;
        private readonly FilterService filterService;

        private NavigationViewModel navigationViewModel;

        public MyCardServices myCardViewModel { get; set; }
        public ICommand AllTransactions { get; set; }
        public ICommand Income { get; set; }
        public ICommand Expense { get; set; }
        public ICommand PreviousPage { get; set; }
        public ICommand NextPage { get; set; }
         
        public ICommand AddCard { get; set; }
        public MyExpenseServices myExpenseViewModel { get; set; }
        public ObservableCollection<RecentTransactionScreenTransaction>? transactionList { get; set; }

        public ObservableCollection<NewwaveDesignProject.Feartures.Transaction.Models.MenuItemModel>? menuItems { get; set; }

        public TransactionViewModel(
        TransactionService transactionService,
        PaginationService paginationService,
        FilterService filterService,
        MyCardServices myCardServices,
        MyExpenseServices myExpenseServices,
        NavigationViewModel NavigationViewModel)
        {
            this.transactionService = transactionService;
            this.paginationService = paginationService;
            this.filterService = filterService;
            this.navigationViewModel = NavigationViewModel;
            myCardViewModel = myCardServices;
            myExpenseViewModel = myExpenseServices;
            Income = new RelayCommand<object>(IncomeExecute);
            Expense = new RelayCommand<object>(ExpenseExecute);
            AllTransactions = new RelayCommand<object>(AllTransactionsExecute);
            PreviousPage = new RelayCommand<object>(PreviousPageExecute);
            NextPage = new RelayCommand<object>(NextPageExecute);
            AddCard = new RelayCommand<object>(NavigateToCreditCard);

            InitialTransactionList();
            InitialMenuItems();
            UpdateTransactionListForCurrentPage();
            UpdatePageCommands();
        }

        private void NavigateToCreditCard(object t)
        {
            Navigations.Models.MenuItemModel? menuItem = navigationViewModel.MenuItems[Constant.POSITIONCREDITCARD];
            navigationViewModel.MenuItemClickCommand?.Execute(menuItem);
        }

        private async void InitialTransactionList()
        {
            transactionList = await transactionService.GetAllTransactions();
            paginationService.CalculateNumberOfPages(transactionList.Count);
        }

        private void InitialMenuItems()
        {
            menuItems = new ObservableCollection<NewwaveDesignProject.Feartures.Transaction.Models.MenuItemModel>();
            var tempListForMenu = filterService.ApplyFilter(transactionService.GetAllTransactions().Result);
            paginationService.CalculateNumberOfPages(tempListForMenu.Count);
            for (int pageNumber = 1; pageNumber <= paginationService.NumberOfPages; pageNumber++)
            {
                menuItems.Add(new NewwaveDesignProject.Feartures.Transaction.Models.MenuItemModel
                {
                    Header = pageNumber.ToString(),
                    Background = new SolidColorBrush(Colors.White),
                    FontSize = 16,
                    FontWeight = FontWeights.Bold,
                    PageClick = new RelayCommand<object>(PageClickExecute)
                });
            }
        }

        private void PageClickExecute(object obj)
        {
            NewwaveDesignProject.Feartures.Transaction.Models.MenuItemModel menuItem = (NewwaveDesignProject.Feartures.Transaction.Models.MenuItemModel)obj;
            paginationService.SetPage(Convert.ToInt32(menuItem.Header));
            UpdateTransactionListForCurrentPage();
        }

        private void ExpenseExecute(object obj)
        {
            filterService.SetFilter("Expense");
            paginationService.SetPage(1);
            UpdateTransactionListForCurrentPage();
            InitialMenuItems();
        }

        private void AllTransactionsExecute(object obj)
        {
            filterService.SetFilter("All");
            paginationService.SetPage(1);
            UpdateTransactionListForCurrentPage();
            InitialMenuItems();
        }

        private void IncomeExecute(object obj)
        {
            filterService.SetFilter("Income");
            paginationService.SetPage(1);
            UpdateTransactionListForCurrentPage();
            InitialMenuItems();
        }

        private void NextPageExecute(object obj)
        {
            paginationService.NextPage();
            UpdateTransactionListForCurrentPage();
            UpdatePageCommands();
        }

        private void PreviousPageExecute(object obj)
        {
            paginationService.PreviousPage();
            UpdateTransactionListForCurrentPage();
            UpdatePageCommands();
        }

        private void UpdatePageCommands()
        {
            ((RelayCommand<object>)PreviousPage).RaiseCanExecuteChanged();
            ((RelayCommand<object>)NextPage).RaiseCanExecuteChanged();
        }

        private void UpdateTransactionListForCurrentPage()
        {
            transactionList = transactionService.GetAllTransactions().Result;
            var filteredTransactions = filterService.ApplyFilter(transactionList);
            transactionList = paginationService.GetPageTransactions(filteredTransactions);
        }
    }
}

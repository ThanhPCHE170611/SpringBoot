using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.Transaction.Models;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows.Media;
using System.Windows;

namespace NewwaveDesignProject.Feartures.Transaction.Services
{
    public class PaginationService : BaseService
    {
        public int CurrentPage { get; private set; } = 1;
        public int NumberOfTransactionsPerPage { get; } = 2;

        public int NumberOfPages;

        public void CalculateNumberOfPages(int totalTransactions)
        {
            NumberOfPages = Convert.ToInt32(Math.Ceiling((decimal)totalTransactions / NumberOfTransactionsPerPage));
        }

        public ObservableCollection<RecentTransactionScreenTransaction> GetPageTransactions(ObservableCollection<RecentTransactionScreenTransaction> allTransactions)
        {
            return new ObservableCollection<RecentTransactionScreenTransaction>(
                allTransactions
                    .Skip((CurrentPage - 1) * NumberOfTransactionsPerPage)
                    .Take(NumberOfTransactionsPerPage)
            );
        }

        public void NextPage()
        {
            if (CurrentPage < NumberOfPages)
            {
                CurrentPage++;
            }
        }

        public void PreviousPage()
        {
            if (CurrentPage > 1)
            {
                CurrentPage--;
            }
        }

        public void SetPage(int pageNumber)
        {
            if (pageNumber > 0 && pageNumber <= NumberOfPages)
            {
                CurrentPage = pageNumber;
            }
        }
    }
}
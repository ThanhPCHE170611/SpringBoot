using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Feartures.Transaction.Models;
using System;
using System.Collections.ObjectModel;
using System.Linq;

namespace NewwaveDesignProject.Feartures.Transaction.Services
{
    public class FilterService: BaseService
    {
        public string CurrentFilter { get; private set; } = "All";

        public ObservableCollection<RecentTransactionScreenTransaction> ApplyFilter(ObservableCollection<RecentTransactionScreenTransaction> transactions)
        {
            switch (CurrentFilter)
            {
                case "Income":
                    return new ObservableCollection<RecentTransactionScreenTransaction>(
                        transactions.Where(t => t.Amount.StartsWith('+'))
                    );
                case "Expense":
                    return new ObservableCollection<RecentTransactionScreenTransaction>(
                        transactions.Where(t => t.Amount.StartsWith('-'))
                    );
                default:
                    return transactions;
            }
        }

        public void SetFilter(string filter)
        {
            CurrentFilter = filter;
        }
    }
}
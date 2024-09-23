using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Data;
using NewwaveDesignProject.Feartures.Transaction.Models;
using NewwaveDesignProject.Repository;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Linq.Expressions;

namespace NewwaveDesignProject.Feartures.Transaction.Services
{
    public class TransactionService : BaseService
    {
        private readonly Repository<NewwaveDesignProject.Cores.MVVM.Models.Transaction> transactionRepository;

        public TransactionService(Repository<NewwaveDesignProject.Cores.MVVM.Models.Transaction> transactionRepository)
        {
            this.transactionRepository = transactionRepository;
        }

        public async Task<ObservableCollection<RecentTransactionScreenTransaction>> GetAllTransactions(string filter = null)
        {
            var transactions = await transactionRepository.GetAll();

            if (transactions == null)
            {
                return new ObservableCollection<RecentTransactionScreenTransaction>();
            }

            var tempList = transactions
                .Where(t => t != null)
                .Select(t => new RecentTransactionScreenTransaction
                {
                    Description = t.Description,
                    Amount = CreateAmount(t.Amount),
                    Date = t.Date,
                    ImagePath = t.ImageType,
                    Type = t.Type,
                    Card = t.Invoice?.Card?.Number,
                    TransactionID = t.Id.ToString()
                });

            return new ObservableCollection<RecentTransactionScreenTransaction>(tempList);
        }

        private static string CreateAmount(decimal amount)
        {
            if (amount < 0)
            {
                return "-$" + Math.Abs(amount).ToString();
            }
            return "+$" + amount.ToString();
        }
    }
}
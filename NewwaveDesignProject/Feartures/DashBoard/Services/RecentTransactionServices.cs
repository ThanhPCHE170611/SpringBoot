using NewwaveDesignProject.Cores;
using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Data;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.DashBoard.Models;
using NewwaveDesignProject.Repository;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.DashBoard.Services
{
    public class RecentTransactionServices : ViewModalBase
    {
        private readonly Repository<Cores.MVVM.Models.Transaction> transactionRepository;
        public ObservableCollection<RecentTransaction>? recentTransactions { get; set; }

        public RecentTransactionServices(Repository<Cores.MVVM.Models.Transaction> transactionRepository)
        {
            this.transactionRepository = transactionRepository;

            InitTransactionList();
        }

        private async void InitTransactionList()
        {
            var transactionDBList = await transactionRepository.GetAll(t => t.Id < 4);
            var trasactionList = transactionDBList.Select(t => new RecentTransaction
            {
                Name = t.Description,
                Amount = CreateAmount(t.Amount),
                Date = t.Date.ToString("dd MMMM yyyy"),
                ImagePath = CreateBitmapImageSafe(t.ImageType)
            }).ToList();
            recentTransactions = new ObservableCollection<RecentTransaction>(trasactionList);
        }

        private static string CreateAmount(decimal amount)
        {
            if (amount < 0)
            {
                return "-$" + Math.Abs(amount).ToString();
            }
            return "+$" + amount.ToString();
        }

        public static ImageSource CreateBitmapImageSafe(string imageType)
        {
            return UserInterface.CreateBitmapImage("Accounts", imageType);
        }
    }
}

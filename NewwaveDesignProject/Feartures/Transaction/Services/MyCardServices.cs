using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Repository;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Transaction.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Transaction.Services
{
    public class MyCardServices : ViewModalBase
    {
        private readonly Repository<Card>? cardRepository;
        public MasterCard masterCard
        {
            get;set;
        }

        public MasterCard masterCard2
        {
            get;set;
        }
        public MyCardServices(Repository<Card> repository)
        {
            this.cardRepository = repository;
            InitCard();
        }

        private async void InitCard()
        {
            var masterCardInDb = await cardRepository.Get(1);
            masterCard = new MasterCard()
            {
                Balance = "$" + Convert.ToString(masterCardInDb.Balance),
                CardColorBorder = UserInterface.CreateSolidColorBrush("#4C49ED"),
                CardHolder = masterCardInDb.Holder,
                CardNumber = masterCardInDb.Number,
                ChipSource = UserInterface.CreateBitmapImage("MyCard", masterCardInDb.ChipImage),
                ContentColor = UserInterface.CreateSolidColorBrush("#FFFFFF"),
                EndBColor = UserInterface.CreateSolidColorBrush("#0A06F4"),
                LaberColor = UserInterface.CreateSolidColorBrush("#FFFF"),
                MasterLogo = UserInterface.CreateBitmapImage("MyCard", masterCardInDb.Logo),
                StartBColor = UserInterface.CreateSolidColorBrush("#4C49ED"),
                ValidThru = masterCardInDb.ValidThru.ToString("MM/yy")
            };
            var masterCardInDb2 = await cardRepository.Get(2);
            masterCard2 = new MasterCard()
            {
                Balance = "$" + Convert.ToString(masterCardInDb2.Balance),
                CardColorBorder = UserInterface.CreateSolidColorBrush("#F5F7FA"),
                CardHolder = masterCardInDb2.Holder,
                CardNumber = masterCardInDb2.Number,
                ChipSource = UserInterface.CreateBitmapImage("MyCard", masterCardInDb2.ChipImage),
                ContentColor = UserInterface.CreateSolidColorBrush("#343C6A"),
                EndBColor = UserInterface.CreateSolidColorBrush("#DFEAF2"),
                LaberColor = UserInterface.CreateSolidColorBrush("#718EBF"),
                MasterLogo = UserInterface.CreateBitmapImage("MyCard", masterCardInDb2.Logo),
                StartBColor = UserInterface.CreateSolidColorBrush("#DFEAF2"),
                ValidThru = masterCardInDb2.ValidThru.ToString("MM/yy")
            };
        }
    }
}

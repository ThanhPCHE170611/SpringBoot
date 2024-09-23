using NewwaveDesignProject.ViewModels;
using System.Windows.Controls;

namespace NewwaveDesignProject.Feartures.CreditCards.Views
{
    public partial class CreditCardPage : Page
    {
        public CreditCardPage(CreaditCardsViewModel creaditCardsViewModel)
        {

            InitializeComponent();
            DataContext = creaditCardsViewModel;
        }
    }
}

using NewwaveDesignProject.Feartures.CreditCards.Models;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.UI.UserControls
{

    public partial class MyCardListItems : UserControl
    {
        public ObservableCollection<CardDTO> ListMyCardItems
        {
            get { return (ObservableCollection<CardDTO>)GetValue(ListCardsProperty); }
            set { SetValue(ListCardsProperty, value); }
        }

        public static readonly DependencyProperty ListCardsProperty =
            DependencyProperty.Register("ListMyCardItems", typeof(ObservableCollection<CardListDTO>), typeof(CardListUC), new PropertyMetadata(new ObservableCollection<CardDTO>()));
        public MyCardListItems()
        {
            InitializeComponent();
           // ListMyCardItems = new CreaditCardsViewModel().ListMyCardItemData;
        }
    }
}

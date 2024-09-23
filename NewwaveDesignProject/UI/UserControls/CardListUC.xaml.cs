using NewwaveDesignProject.Feartures.CreditCards.Models;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.UI.UserControls
{
    public partial class CardListUC : UserControl
    {
        public static readonly DependencyProperty CardListProperty =
            DependencyProperty.Register("CardList", typeof(ObservableCollection<CardListDTO>), typeof(CardListUC), new PropertyMetadata(null));

        public ObservableCollection<CardListDTO> CardList
        {
            get { return (ObservableCollection<CardListDTO>)GetValue(CardListProperty); }
            set { SetValue(CardListProperty, value); }
        }

        public CardListUC()
        {
            InitializeComponent();
        }
    }
}

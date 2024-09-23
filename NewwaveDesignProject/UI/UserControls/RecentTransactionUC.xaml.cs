using NewwaveDesignProject.Feartures.DashBoard.Models;
using NewwaveDesignProject.Feartures.Transaction.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace NewwaveDesignProject.UI.UserControls
{
    /// <summary>
    /// Interaction logic for RecentTransactionUC.xaml
    /// </summary>
    public partial class RecentTransactionUC : UserControl
    {
        public ObservableCollection<RecentTransaction> TransactionList
        {
            get { return (ObservableCollection<RecentTransaction>)GetValue(TransactionListProperty); }
            set { SetValue(TransactionListProperty, value); }
        }
        public static readonly DependencyProperty TransactionListProperty =
            DependencyProperty.Register("TransactionList", typeof(ObservableCollection<RecentTransaction>), typeof(RecentTransactionUC), new PropertyMetadata(null));
        public RecentTransactionUC()
        {
            InitializeComponent();
        }
    }
}

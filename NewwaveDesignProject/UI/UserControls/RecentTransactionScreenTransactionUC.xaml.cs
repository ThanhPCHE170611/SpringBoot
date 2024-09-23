using NewwaveDesignProject.Feartures.Transaction.Models;
using NewwaveDesignProject.Feartures.Transaction.ViewModels;
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
    /// Interaction logic for RecentTransactionScreenTransactionUC.xaml
    /// </summary>
    public partial class RecentTransactionScreenTransactionUC : UserControl
    {
        public ObservableCollection<RecentTransactionScreenTransaction> TransactionList
        {
            get { return (ObservableCollection<RecentTransactionScreenTransaction>)GetValue(TransactionListProperty); }
            set { SetValue(TransactionListProperty, value); }
        }
        public static readonly DependencyProperty TransactionListProperty =
            DependencyProperty.Register("TransactionList", typeof(ObservableCollection<RecentTransactionScreenTransaction>), typeof(RecentTransactionScreenTransactionUC), new PropertyMetadata(null));

        public RecentTransactionScreenTransactionUC()
        {
            InitializeComponent();
        }
    }
}

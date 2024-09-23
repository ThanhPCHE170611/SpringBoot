using NewwaveDesignProject.Feartures.Accounts.Models;
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
    /// Interaction logic for TransactionUC.xaml
    /// </summary>
    public partial class TransactionUC : UserControl
    {

        public ObservableCollection<TransactionDTO> TransactionList
		{
            get { return (ObservableCollection<TransactionDTO>)GetValue(TransactionListProperty); }
            set { SetValue(TransactionListProperty, value); }
        }

        // Using a DependencyProperty as the backing store for MyProperty.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty TransactionListProperty =
            DependencyProperty.Register("TransactionList", typeof(ObservableCollection<TransactionDTO>), typeof(TransactionUC), new PropertyMetadata(null));


        public TransactionUC()
        {
            InitializeComponent();
        }
    }
}

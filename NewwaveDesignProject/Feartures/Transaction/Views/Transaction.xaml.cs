using DryIoc;
using NewwaveDesignProject.Cores.MVVM.Data;
using NewwaveDesignProject.Feartures.Transaction.ViewModels;
using NewwaveDesignProject.Repository;
using System;
using System.Collections.Generic;
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

namespace NewwaveDesignProject.Feartures.Transaction.Views
{
    /// <summary>
    /// Interaction logic for Transaction.xaml
    /// </summary>
    public partial class Transaction : UserControl
    {
        public Transaction(TransactionViewModel transactionViewModel)
        {
            
            InitializeComponent();
            DataContext = transactionViewModel;
        }
    }
}

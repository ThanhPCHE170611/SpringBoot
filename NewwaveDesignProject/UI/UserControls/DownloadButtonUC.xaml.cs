using NewwaveDesignProject.Feartures.Transaction.Models;
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

namespace NewwaveDesignProject.UI.UserControls
{
    /// <summary>
    /// Interaction logic for DownloadButtonUC.xaml
    /// </summary>
    public partial class DownloadButtonUC : UserControl
    {
        public DownloadButtonUC()
        {
            InitializeComponent();
        }

        private void btnDowload_Click(object sender, RoutedEventArgs e)
        {
            Button downloadButton = sender as Button;
            if (downloadButton != null)
            {
                RecentTransactionScreenTransaction transaction = downloadButton.DataContext as RecentTransactionScreenTransaction;
                if (transaction != null)
                {
                    MessageBox.Show($"Downloading transaction: {transaction.Description}");
                }
            }
        }
    }
}

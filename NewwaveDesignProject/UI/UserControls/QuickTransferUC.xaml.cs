using NewwaveDesignProject.Feartures.DashBoard.Models;
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
    /// Interaction logic for QuickTransferUC.xaml
    /// </summary>
    public partial class QuickTransferUC : UserControl
    {
        public static readonly DependencyProperty QuickTransfersProperty =
            DependencyProperty.Register("QuickTransfers", typeof(ObservableCollection<AccountInfo>), typeof(QuickTransferUC), new PropertyMetadata(null));

        public ObservableCollection<AccountInfo> QuickTransfers { 
            get { return (ObservableCollection<AccountInfo>)GetValue(QuickTransfersProperty); }
            set { SetValue(QuickTransfersProperty, value); }
        }
        public QuickTransferUC()
        {
            InitializeComponent();
        }
    }
}

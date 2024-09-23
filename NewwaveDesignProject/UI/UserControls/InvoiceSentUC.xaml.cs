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
    /// Interaction logic for InvoiceSentUC.xaml
    /// </summary>
    public partial class InvoiceSentUC : UserControl
    {
        public InvoiceSentUC()
        {
            InitializeComponent();
        }


        public ObservableCollection<InvoiceSent> ListInvoiceSent
		{
            get { return (ObservableCollection<InvoiceSent>)GetValue(ListInvoiceSentProperty); }
            set { SetValue(ListInvoiceSentProperty, value); }
        }

        // Using a DependencyProperty as the backing store for MyProperty.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty ListInvoiceSentProperty =
            DependencyProperty.Register("ListInvoiceSent", typeof(ObservableCollection<InvoiceSent>), typeof(InvoiceSentUC), new PropertyMetadata(null));


    }
}

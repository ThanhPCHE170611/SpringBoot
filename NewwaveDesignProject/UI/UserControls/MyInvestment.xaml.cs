using NewwaveDesignProject.Feartures.Investments.Models;
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
    /// Interaction logic for MyInvestment.xaml
    /// </summary>
    public partial class MyInvestment : UserControl
    {
        public MyInvestment()
        {
            InitializeComponent();
        }

        public ObservableCollection<Feartures.Investments.Models.InvestmentDTO> ListInvestment
		{
            get { return (ObservableCollection<Feartures.Investments.Models.InvestmentDTO>)GetValue(ListInvestmentProperty); }
            set { SetValue(ListInvestmentProperty, value); }
        }

        // Using a DependencyProperty as the backing store for MyProperty.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty ListInvestmentProperty =
			DependencyProperty.Register("ListInvestment", typeof(ObservableCollection<Feartures.Investments.Models.InvestmentDTO>), typeof(MyInvestment), new PropertyMetadata(null));


    }
}

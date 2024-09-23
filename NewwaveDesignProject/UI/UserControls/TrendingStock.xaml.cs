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
    /// Interaction logic for TrendingStock.xaml
    /// </summary>
    public partial class TrendingStock : UserControl
    {
        public TrendingStock()
        {
            InitializeComponent();
        }


        public ObservableCollection<StockDTO> List
		{
            get { return (ObservableCollection<StockDTO>)GetValue(ListProperty); }
            set { SetValue(ListProperty, value); }
        }

        // Using a DependencyProperty as the backing store for MyProperty.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty ListProperty =
            DependencyProperty.Register("List", typeof(ObservableCollection<StockDTO>), typeof(TrendingStock), new PropertyMetadata(null));


    }
}

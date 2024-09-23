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
    public partial class PaginationBarUC : UserControl
    {
        public PaginationBarUC()
        {
            InitializeComponent();
        }
        public ObservableCollection<MenuItemModel> MenuItems
        {
            get { return (ObservableCollection<MenuItemModel>)GetValue(MenuItemsProperty); }
            set { SetValue(MenuItemsProperty, value); }
        }
        public static readonly DependencyProperty MenuItemsProperty =
            DependencyProperty.Register("MenuItems", typeof(ObservableCollection<MenuItemModel>), typeof(PaginationBarUC), new PropertyMetadata(null));

    }
}

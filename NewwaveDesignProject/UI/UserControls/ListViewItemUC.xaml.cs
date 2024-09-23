using NewwaveDesignProject.Feartures.ServicesFeature.Models;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.UI.UserControls
{
    /// <summary>
    /// Interaction logic for ListViewItemUC.xaml
    /// </summary>
    public partial class ListViewItemUC : UserControl
    {


        public ObservableCollection<ServiceListItemDTO> ListItems
        {
            get { return (ObservableCollection<ServiceListItemDTO>)GetValue(ListItemsProperty); }
            set { SetValue(ListItemsProperty, value); }
        }

        // Using a DependencyProperty as the backing store for MyProperty.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty ListItemsProperty =
            DependencyProperty.Register("ListItems", typeof(ObservableCollection<ServiceListItemDTO>), typeof(ListViewItemUC), new PropertyMetadata(null));


        public ListViewItemUC()
        {
            InitializeComponent();
        }
    }
}

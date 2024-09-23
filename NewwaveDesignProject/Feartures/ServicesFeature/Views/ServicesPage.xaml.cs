using NewwaveDesignProject.Feartures.ServicesFeature.ViewModels;
using System.Windows.Controls;
namespace NewwaveDesignProject.Views
{
    /// <summary>
    /// Interaction logic for ServicesUC.xaml
    /// </summary>
    public partial class ServicesPage : Page
    {

        public ServicesPage(ServicesViewModel servicesViewModel)
        {
            InitializeComponent();
            DataContext = servicesViewModel;
        }
    }
}

using DryIoc;
using NewwaveDesignProject.Feartures.Navigations.ViewModels;
using System.Windows;

namespace NewwaveDesignProject
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
			DataContext = ((App)Application.Current).Container.Resolve<MainWindowViewModel>();
		}
    }
		
}

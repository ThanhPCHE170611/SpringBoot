using NewwaveDesignProject.ViewModels;
using System.Windows.Controls;

namespace NewwaveDesignProject.Views
{
    public partial class SettingPage : Page
    {
        public SettingPage(SettingViewModel settingViewModel)
        {
            InitializeComponent();
            DataContext = settingViewModel;
        }
    }
}

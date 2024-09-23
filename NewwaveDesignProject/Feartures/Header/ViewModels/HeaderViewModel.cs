using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Header.Command;
using NewwaveDesignProject.Feartures.Header.Models;
using System.ComponentModel;
using System.Windows.Input;

namespace NewwaveDesignProject.Feartures.Header.ViewModels
{
    public class HeaderViewModel : ViewModalBase
    {
        private readonly SharedDataService _sharedDataService;
        public string CurrentUserControlName => _sharedDataService.CurrentHeader ?? "Dashboard";
        public HeaderSourceModel? headerSourceModel { get; set; }
        public ICommand? SettingCommand { get; set; }
        public ICommand? NotificationCommand { get; set; }
        public ICommand? UserProfileCommand { get; set; }
        private void SharedDataService_PropertyChanged(object? sender, PropertyChangedEventArgs eventArgs)
        {
            if (eventArgs.PropertyName == nameof(SharedDataService.CurrentHeader))
            {
               
            }
        }
        public HeaderViewModel(SharedDataService sharedDataService)
        {
            _sharedDataService = sharedDataService;
            _sharedDataService.PropertyChanged += SharedDataService_PropertyChanged;
            InitializeHeaderData();

        }
        public void InitializeHeaderData()
        {
            headerSourceModel = new HeaderSourceModel
            {
                SettingImageSource = UserInterface.CreateBitmapImage("Icons/Header", "settings.png"),
                NotifycationImageSource = UserInterface.CreateBitmapImage("Icons/Header", "belling.png"),
                UserThumbImageSource = UserInterface.CreateBitmapImage("Icons/Header", "user.png")
            };

            SettingCommand = new SettingCommand();
            NotificationCommand = new NotificationCommand();
            UserProfileCommand = new UserProfileCommand();
        }
    }
}

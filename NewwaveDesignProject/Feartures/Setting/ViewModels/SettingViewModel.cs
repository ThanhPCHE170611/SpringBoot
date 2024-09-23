using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Setting.Models;
using NewwaveDesignProject.Services;
using System.Windows;
using System.Windows.Input;

namespace NewwaveDesignProject.ViewModels
{
    public partial class SettingViewModel : ViewModalBase
    {
        private readonly IUserServices userServices;
        public ICommand UpdateUserInfoCommand { get; }
        public ICommand ChooseAvatarCommand { get; }
        public string? NewPassword { get; set; }
        public string? CurrentPassword { get; set; }
        public UserDTO? User { get; set; }

        public SettingViewModel(IUserServices userServices)
        {
            this.userServices = userServices;
            UpdateUserInfoCommand = new RelayCommand<object>(async _ => await UpdateUserInfoAsync());
            ChooseAvatarCommand = new RelayCommand<object>(_ => ChooseAvatar());
            GetUserToEdit(1);
        }

        public async Task GetUserToEdit(int id)
        {
            User = await userServices.GetUserAsync(id);
            OnPropertyChanged(nameof(User));
        }

        private async Task UpdateUserInfoAsync()
        {
            (UserDTO? updatedUser, string message) = await userServices.UpdateUserAsync(User, CurrentPassword, NewPassword);

            MessageBox.Show(message);

            if (updatedUser != null)
            {
                User = updatedUser;
                OnPropertyChanged(nameof(User));
                NewPassword = null;
                CurrentPassword = null;
            }
        }

        private void ChooseAvatar()
        {
            (string? avatar, string message) = userServices.ChooseAvatar();

            if (avatar != null && User != null)
            {
                User.Avatar = UserInterface.CreateBitmap(avatar);
                OnPropertyChanged(nameof(User));
            }

            MessageBox.Show(message);
        }
    }
}
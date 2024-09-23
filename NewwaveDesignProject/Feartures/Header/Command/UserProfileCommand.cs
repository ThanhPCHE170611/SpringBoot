using NewwaveDesignProject.Cores.MVVM.Command;
using System.Windows;

namespace NewwaveDesignProject.Feartures.Header.Command
{
    public class UserProfileCommand : BaseCommand<object>
    {
        public override void Execute(object parameter)
        {
            UserProfileExecute(parameter);
        }
        private void UserProfileExecute(object obj) => MessageBox.Show("Đây là tôi ");
    }
}

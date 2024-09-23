using NewwaveDesignProject.Cores.MVVM.Command;
using System.Windows;

namespace NewwaveDesignProject.Feartures.Header.Command
{
    public class NotificationCommand : BaseCommand<object>
    {
        public override void Execute(object parameter)
        {
            NotificationExecute(parameter);
        }
        private void NotificationExecute(object obj) => MessageBox.Show("Bạn không có thông báo nào cả!Oke!");
    }
}

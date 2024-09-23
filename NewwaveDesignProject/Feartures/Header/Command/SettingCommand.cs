using NewwaveDesignProject.Cores.MVVM.Command;
using System.Windows;

namespace NewwaveDesignProject.Feartures.Header.Command
{
    public class SettingCommand : BaseCommand<object>
    {
        public override void Execute(object parameter)
        {
            SettingExecute(parameter);
        }
        private void SettingExecute(object obj) => MessageBox.Show("Hãy cài đặt chúng!");
    }
}

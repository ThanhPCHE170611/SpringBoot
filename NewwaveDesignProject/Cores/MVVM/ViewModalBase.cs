using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace NewwaveDesignProject.Cores.MVVM
{
    public class ViewModalBase : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler? PropertyChanged;
        public void OnPropertyChanged([CallerMemberName] string property = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(property));
        }
    }
}

using NewwaveDesignProject.Cores.MVVM;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Header.Models
{
    public class HeaderSourceModel : ModelBase
    {
        public ImageSource? SettingImageSource { get; set; }
        public ImageSource? NotifycationImageSource { get; set; }
        public ImageSource? UserThumbImageSource { get; set; }
    }
}

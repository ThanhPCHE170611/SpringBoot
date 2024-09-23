using NewwaveDesignProject.Cores.MVVM;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.ServicesFeature.Models
{
    public class CardServicesDTO : ModelBase
    {
        public ImageSource? ServiceImage { get; set; }
        public string? ServiceName { get; set; }
        public string? Slogan { get; set; }
        
    }
}

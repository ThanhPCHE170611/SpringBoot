using NewwaveDesignProject.Cores.MVVM;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.ServicesFeature.Models
{
    public class ServiceListItemDTO : ModelBase
    {
        public ImageSource? ServiceImage { get; set; }
        public string? ServiceName { get; set; }
        public string? Description { get; set; }
        public string? FirstText { get; set; }
        public string? SecondText { get; set; }
        public string? ThirdText { get; set; }
        public string? FourthText { get; set; }
        public string? FifthText { get; set; }
        public string? SixthText { get; set; }
    }
}

using System.Windows.Media;
using System.Windows;
using NewwaveDesignProject.Cores.MVVM;

namespace NewwaveDesignProject.Feartures.CreditCards.Models
{
    public class CardDTO : ModelBase
    {
        public int Id { get; set; }
        public int CardTypeId { get; set; }
        public Brush? BorderBackgroundTop { get; set; }
        public Color? BackgroundGradientStart { get; set; }
        public Color? BackgroundGradientEnd { get; set; }
        public Brush? BorderBrushTopColor { get; set; }
        public Brush? BorderBackgroundBottom { get; set; }
        public Brush? BorderBrushBottomColor { get; set; }
        public Thickness? BorderBottomThickness { get; set; }
        public Brush? ColorTitle { get; set; }
        public Brush? ColorContent { get; set; }
        public string? BlanceTitle { get; set; }
        public string? BlanceAmount { get; set; }
        public string? HolderTitle { get; set; }
        public string? HolderName { get; set; }
        public string? ValidThruTitle { get; set; }
        public string? ValidThruValue { get; set; }
        public string? Number { get; set; }
        public ImageSource? ChipSource { get; set; }
        public ImageSource? Circle { get; set; }
        public ImageSource? Icon { get; set; }
        public CardDTO(string? blanceTitle, string? blanceAmount, string? holderTitle, string? holderName, string? validThruTitle, string? validThruValue, string? number, ImageSource? chipSource, ImageSource? circle)
        {
            BlanceTitle = blanceTitle;
            BlanceAmount = blanceAmount;
            HolderTitle = holderTitle;
            HolderName = holderName;
            ValidThruTitle = validThruTitle;
            ValidThruValue = validThruValue;
            Number = number;
            ChipSource = chipSource;
            Circle = circle;
        }
    }
}

using NewwaveDesignProject.Cores.MVVM;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.CreditCards.Models
{
    public class CardSettingDTO : ModelBase
    {
        public CardSettingDTO(int id, int cardId, ImageSource? iconCard, string? cardSettingTitle, string? cardSettingContent, Brush? iconBackground, CardDTO? card)
        {
            Id = id;
            CardId = cardId;
            IconCard = iconCard;
            CardSettingTitle = cardSettingTitle;
            CardSettingContent = cardSettingContent;
            IconBackground = iconBackground;
            Card = card;
        }

        public int Id { get; set; }
        public int CardId { get; set; }
        public ImageSource? IconCard { get; set; }
        public string? CardSettingTitle { get; set; }
        public string? CardSettingContent { get; set; }
        public Brush? IconBackground { get; set; }
        public virtual CardDTO? Card { get; set; }
    }
}

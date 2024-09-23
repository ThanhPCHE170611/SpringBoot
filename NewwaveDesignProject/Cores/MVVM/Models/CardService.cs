using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class CardService : Entity
    {
        public CardService(int id, string? icon, string? title, string? content, int cardId)
        {
            Id = id;
            Icon = icon;
            Title = title;
            Content = content;
            CardId = cardId;
        }

        [Key]
        public int Id { get; set; }
        public string? Icon { get; set; }
        public string? Title { get; set; }
        public string? Content { get; set; }

        [ForeignKey("Card")]
        public int CardId { get; set; }

        public virtual Card? Card { get; set; }
        
    }
}

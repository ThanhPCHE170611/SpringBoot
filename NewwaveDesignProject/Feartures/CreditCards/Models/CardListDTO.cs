using NewwaveDesignProject.Cores.MVVM;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.CreditCards.Models
{
    public class CardListDTO : ModelBase
    {
        public int Id { get; set; }
        public Brush? ImageBackground { get; set; }
        public ImageSource? ImageSource { get; set; }
        public string? TypeTitle { get; set; }
        public string? TypeContent { get; set; }
        public string? BankTitle { get; set; }
        public string? BankContent { get; set; }
        public string? NumberTitle { get; set; }
        public string? NumberContent { get; set; }
        public string? NamainTitle { get; set; }
        public string? NamainContent { get; set; }
        public string? Detail { get; set; }

        public CardListDTO(int id, ImageSource? imageSource, string? typeTitle, string? typeContent, string? bankTitle, string? bankContent, string? numberTitle, string? numberContent, string? namainTitle, string? namainContent, string? detail)
        {
            Id = id;
            ImageSource = imageSource;
            TypeTitle = typeTitle;
            TypeContent = typeContent;
            BankTitle = bankTitle;
            BankContent = bankContent;
            NumberTitle = numberTitle;
            NumberContent = numberContent;
            NamainTitle = namainTitle;
            NamainContent = namainContent;
            Detail = detail;
        }
        public CardListDTO()
        {

        }
    }
}

using NewwaveDesignProject.Cores.MVVM;

namespace NewwaveDesignProject.Feartures.CreditCards.Models
{
    public class CardServiceDTO : ModelBase
    {
        public int Id { get; set; }
        public string? Icon { get; set; }
        public string? Title { get; set; }
        public string? Content { get; set; }
        public int CardId { get; set; }
    }
}

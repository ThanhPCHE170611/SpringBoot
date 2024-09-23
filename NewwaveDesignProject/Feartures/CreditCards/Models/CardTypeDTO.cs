namespace NewwaveDesignProject.Feartures.CreditCards.Models
{
    public class CardTypeDTO
    {
        public int? Id { get; set; }
        public string? Name { get; set; }
        public virtual List<CardDTO>? Cards { get; set; }
    }
}

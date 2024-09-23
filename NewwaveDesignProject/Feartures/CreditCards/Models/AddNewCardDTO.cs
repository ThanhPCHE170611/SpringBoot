namespace NewwaveDesignProject.Feartures.CreditCards.Models
{
    public  class AddNewCardDTO
    {
        public int CardTypeId { get; set; }
        public string? HolderName { get; set; }
        public string? Number { get; set; }
        public string? ValidThruValue { get; set; }
        public AddNewCardDTO(int cardTypeId, string? holderName, string? number,DateTime? validThruValue)
        {
            CardTypeId = cardTypeId;
            HolderName = holderName;
            Number = number;
            ValidThruValue = validThruValue.ToString();
        }

    }
}

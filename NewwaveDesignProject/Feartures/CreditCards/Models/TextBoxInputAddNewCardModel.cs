using NewwaveDesignProject.Cores.MVVM;

namespace NewwaveDesignProject.Feartures.CreditCards.Models
{
    public class TextBoxInputAddNewCardModel : ModelBase
    {
        public string Label { get; set; }
        public string Placeholder { get; set; }
        public string? InputValue { get; set; }
        public DateTime? DateValue { get; set; }
        public TextBoxInputAddNewCardModel(string label, string placeholder, string inputValue, DateTime? curentDateTime)
        {
            Label = label;
            Placeholder = placeholder;
            InputValue = inputValue;
            DateValue = curentDateTime;
        }
    }
}

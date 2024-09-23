using NewwaveDesignProject.Feartures.CreditCards.Models;
using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Services
{
    public interface ICreditCardService
    {
        Task<ObservableCollection<CardDTO>> GetCreditCardListAsync();
        Task<ObservableCollection<CardListDTO>> GetCardListAsync();
        Task<ObservableCollection<CardSettingDTO>> GetCardSettingAsync();
        Task<ObservableCollection<CardTypeDTO>> GetCardTypeAsync();
        Task<ObservableCollection<BankExpenseStatisticsDTO>> GetCardExpenseStatisticsAsync();
        Task CreateOrUpdateCardServiceAsync(CardServiceDTO cardService);
        Task CreateOrUpdateCardTypeAsync(CardTypeDTO cardType);
        Task CreateOrCreditCardAsync(AddNewCardDTO creditCard);
        Task DeleteCreditCardAsync(int cardId);
        Task DeleteCardTypeAsync(int cardTypeId);
    }
}

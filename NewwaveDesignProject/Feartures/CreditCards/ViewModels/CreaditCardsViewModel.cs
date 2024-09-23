using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.CreditCards.Models;
using NewwaveDesignProject.Services;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;

namespace NewwaveDesignProject.ViewModels
{
    public class CreaditCardsViewModel : ViewModalBase
    {
        public CardDTO? MyCardData1 { get; set; }
        public CardDTO? MyCardData2 { get; set; }
        public CardDTO? MyCardData3 { get; set; }
        public ICreditCardService creditCardServices { get; }
        public ObservableCollection<CardSettingDTO>? CardSettingListData { get; set; }
        public ObservableCollection<CardTypeDTO>? CardTypeData { get; set; }
        public ObservableCollection<BankExpenseStatisticsDTO> listExpenseStatistics { get; set; }
        public ObservableCollection<CardListDTO> CardListData { get; set; }
        public CardTypeDTO CardTypeSelected { get; set; }
        public string? Content { get; set; }
        public string? ButtonContent { get; set; }
        public TextBoxInputAddNewCardModel? CardType { get; set; }
        public TextBoxInputAddNewCardModel? NameOnCard { get; set; }
        public TextBoxInputAddNewCardModel? CardNumber { get; set; }
        public TextBoxInputAddNewCardModel? ExpirationDate { get; set; }
        public ICommand? AddNewCardCommand { get; set; }
        public ICommand? ViewDetailCommand { get; set; }
        public CreaditCardsViewModel(CreditCardServices creditCardServices)
        {
            this.creditCardServices = creditCardServices;
            CardListData = new ObservableCollection<CardListDTO>();
            InitialDataAsync();
        }
        public async Task InitialDataAsync()
        {
            await InitialCrediCarDataAsync();
            CardListData = await creditCardServices.GetCardListAsync();
            CardSettingListData = await creditCardServices.GetCardSettingAsync();
            InitializeAddNewCardData();
            CardTypeData = await creditCardServices.GetCardTypeAsync();
            listExpenseStatistics = await creditCardServices.GetCardExpenseStatisticsAsync();
            InitialCommand();
        }
        public async Task InitialCrediCarDataAsync()
        {
            var cardList = await creditCardServices.GetCreditCardListAsync();
            MyCardData1 = cardList[0];
            MyCardData2 = cardList[1];
            MyCardData3 = cardList[2];
        }
        private void InitializeAddNewCardData()
        {
            Content = "Credit Card generally means a plastic card issued by Scheduled Commercial Banks assigned to a Cardholder, with a credit limit, " +
                       "that can be used to purchase goods and services on credit or obtain cash advances.";
            ButtonContent = "Add";

            NameOnCard = new TextBoxInputAddNewCardModel("Name On Card", "My Cards", "", DateTime.Now);
            CardNumber = new TextBoxInputAddNewCardModel("Card Number", "**** **** **** ****", "", DateTime.Now);
            ExpirationDate = new TextBoxInputAddNewCardModel("Expiration Date", "", "",DateTime.Now);
        }
        public void InitialCommand()
        {
            AddNewCardCommand = new RelayCommand<object>(AddNewCreditCardAsync, CanAddNewCreaditCard);
            ViewDetailCommand = new RelayCommand<object>(CanViewDetail);
        }
        public void CanViewDetail(object parameter)
        {
            var currentCaedListItem = parameter as CardListDTO;
            OnViewDetailClick(currentCaedListItem ?? new CardListDTO());
        }
        private void OnViewDetailClick(CardListDTO model)
        {
            MessageBox.Show($"Curent Bank is: {model.NamainContent}");
        }
        public bool CanAddNewCreaditCard(object parameter)
        {
            return CheckInputValue();
        }
        public bool CheckInputValue()
        {
            if (string.IsNullOrEmpty(ExpirationDate?.DateValue.ToString())) return false;
            if (string.IsNullOrEmpty(CardNumber?.InputValue)) return false;
            if (string.IsNullOrEmpty(NameOnCard?.InputValue)) return false;

            return true;
        }
        public async void AddNewCreditCardAsync(object parameter)
        {
            var newCreditCard = new AddNewCardDTO(
                CardTypeSelected.Id ?? 1, NameOnCard?.InputValue,
                CardNumber?.InputValue,
                ExpirationDate?.DateValue);
            await creditCardServices.CreateOrCreditCardAsync(newCreditCard);
            CardListData = await creditCardServices.GetCardListAsync();
        }
    }
}

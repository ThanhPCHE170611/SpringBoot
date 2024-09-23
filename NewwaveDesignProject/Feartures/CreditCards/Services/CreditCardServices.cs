using Microsoft.EntityFrameworkCore;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Repository;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.CreditCards.Models;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Windows;

namespace NewwaveDesignProject.Services
{
    public class CreditCardServices : ICreditCardService
    {
        private readonly IRepository<Card> _cardRepository;
        private readonly IRepository<Bank> _bankRepository;
        private readonly IRepository<CardService> _cardServiceRepository;
        private readonly IRepository<CardType> _cardTypeRepository;
        public CreditCardServices(IRepository<Bank> bankRepository, 
            IRepository<Card> cardRepository, 
            IRepository<CardService> cardServiceRepository,
            IRepository<CardType> cardTypeRepository)
        {
            _cardRepository = cardRepository;
            _cardServiceRepository = cardServiceRepository;
            _cardTypeRepository = cardTypeRepository;
            _bankRepository = bankRepository;
        }
        //Get Data
        public async Task<ObservableCollection<CardListDTO>> GetCardListAsync()
        {
            var creaditCards = (await _cardRepository.GetAllIncludeProperty(i => i.User.Id == 1, "CardType,Bank"))
                .Select(carditem => new CardListDTO(carditem.Id,
                UserInterface.CreateBitmapImage("CardList", carditem.Icon ?? "CreditCardBlue.png"),
                "Card Type", carditem?.CardType?.Name, "Bank", carditem?.Bank?.Name,
                "Card Number", MaskingNumber(carditem.Number ?? "0000000000000"), "Namain Card", carditem?.Holder, "View Detail"));
            return new ObservableCollection<CardListDTO>(creaditCards);
        }
        //Get Card Settinga
        public async Task<ObservableCollection<CardSettingDTO>> GetCardSettingAsync()
        {
            var cardList = await _cardServiceRepository.GetAll(cardItem => cardItem.Card.User.Id == 1);
            var cardSettings = cardList
            .Select(carditem => new CardSettingDTO(
             id: carditem.Id,
             cardId: carditem.CardId,
             iconCard: UserInterface.CreateBitmapImage("CardSetting", carditem.Icon ?? "AppleIcon.png"),
             cardSettingTitle: carditem.Title,
             cardSettingContent: carditem.Content,
             iconBackground: null,
             card: null)).ToList();
            return new ObservableCollection<CardSettingDTO>(cardSettings);
        }
        //Get Credit Card Take 3
        public async Task<ObservableCollection<CardDTO>> GetCreditCardListAsync()
        {
            var cardListDTO = (await _cardRepository.GetAll(cardItem => cardItem.UserId == 1))
                              .Select(carditem => new CardDTO(
                                   "Blance",
                                    carditem.Balance.ToString("C0",CultureInfo.CreateSpecificCulture("en-US")),
                                    "Holder",
                                    carditem.Holder,
                                    "Valid Thru",
                                    carditem.ValidThru.ToString("MM/dd") ?? "12/22",
                                    MaskingNumber(carditem.Number ?? "0000000000000"),
                                    UserInterface.CreateBitmapImage("MyCard", carditem.ChipImage),
                                    UserInterface.CreateBitmapImage("MyCard", carditem.Logo)
                               
                               )).Take(3);
            return new ObservableCollection<CardDTO>(cardListDTO);
        }
        public async Task<ObservableCollection<Bank>> GetBanksAsync()
        {
            var bankList = await _bankRepository.GetAll();

            return new ObservableCollection<Bank>(bankList);
        }
        public async Task<ObservableCollection<BankExpenseStatisticsDTO>> GetCardExpenseStatisticsAsync()
        {
            IQueryable<Bank> query = _bankRepository.GetContext().Set<Bank>().AsNoTracking();

            query = query.Include(bank => bank.Cards)
                         .ThenInclude(card => card.Invoices);

            var banksWithCardsAndInvoices = await query.ToListAsync();

            var listCardExpenseStatistics = banksWithCardsAndInvoices
                .GroupBy(bank => bank.Id)
                .Select(group => new BankExpenseStatisticsDTO
                {
                    BankId = group.Key,
                    TotalExpense = group
                        .SelectMany(bank => bank.Cards)
                        .Select(card => card.Invoices.Sum(invoice => invoice.Amount))
                        .Sum()
                })
                .ToList();

            return new ObservableCollection<BankExpenseStatisticsDTO>(listCardExpenseStatistics);
        }
        //GetCardType
        public async Task<ObservableCollection<CardTypeDTO>> GetCardTypeAsync()
        {
            var cardTypeList = await _cardTypeRepository.GetAll();
            var cardTypeDTO = cardTypeList.Select(cardType => new CardTypeDTO
            {
                Id = cardType.Id,
                Name = cardType.Name,
            });
            return new ObservableCollection<CardTypeDTO>(cardTypeDTO);
        }
        //Create Card Service
        public async Task CreateOrUpdateCardServiceAsync(CardServiceDTO cardService)
        {
            try
            {
                if (_cardServiceRepository.GetFirstItem(i => i.Id == cardService.Id) != null)
                {
                    var currentCardService = 
                        await _cardServiceRepository.GetFirstItem(i => i.Id == cardService.Id);
                    currentCardService.Icon = cardService.Icon;
                    currentCardService.Title = cardService.Title;
                    currentCardService.Content = cardService.Content;
                    currentCardService.CardId = cardService.CardId;
                    await _cardServiceRepository.UpdateAsync(currentCardService);
                    MessageBox.Show("Card Service updated successfully");

                    return;
                }

                var newCardService = new CardService(1, cardService.Icon, cardService.Title, cardService.Content, 1);
                await _cardServiceRepository.InsertAsync(newCardService);
                MessageBox.Show("Card Service created successfully");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error in processing add new creadit card ");
            }
        }
        //Create Or Card Type
        public async Task CreateOrUpdateCardTypeAsync(CardTypeDTO cardType)
        {
            try
            {
                var currentCardType = await _cardTypeRepository.GetFirstItem(cardType => cardType.Name.Equals(cardType.Name));
                if (currentCardType != null)
                {
                    currentCardType.Name = cardType.Name;
                    await _cardTypeRepository.UpdateAsync(currentCardType);
                    MessageBox.Show("Card Type Updated Successfully", "Success");

                    return;
                }

                var newCardType = new CardType
                {
                    Name = cardType.Name
                };
                await _cardTypeRepository.InsertAsync(newCardType);
                MessageBox.Show("Card Type Created Successfully", "Success");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error in processing create new card type: ");
            }
        }
        //Create CreaditCard
        public async Task CreateOrCreditCardAsync(AddNewCardDTO creditCard)
        {
            try
            {
                var currentCard = await _cardRepository.GetFirstItem(card => card.User.Id == 1 && card.Number.Equals(creditCard.Number));
                if (currentCard != null)
                {
                    currentCard.Holder = creditCard.HolderName;
                    currentCard.Number = creditCard.Number;
                    currentCard.ValidThru = DateTime.Parse(creditCard.ValidThruValue);
                    MessageBox.Show("Card Updated Successfully", "Success");

                    return;
                }

                var newCard = new Card
                {
                    UserId = 1,
                    CardTypeId = creditCard.CardTypeId,
                    BankId = 1,
                    Holder = creditCard.HolderName,
                    Number = creditCard.Number,
                    ValidThru = DateTime.Parse(creditCard.ValidThruValue ?? "2023/09/10"),
                    Balance = 0
                };
                var check = await _cardRepository.InsertAsync(newCard);

                if (check != null)
                {
                    MessageBox.Show("Card created successfully");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error in processing add new creadit card");
            }
        }
        //Delete credit card
        public async Task DeleteCreditCardAsync(int cardId)
        {
            try
            {
                if (await _cardServiceRepository.DeleteAsync(cardId))
                {
                    MessageBox.Show("Card deleted successfully");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error in processing delete card");
            }
        }

        //Delete card service
        public async Task DeleteCardTypeAsync(int cardTypeId)
        {
            try
            {
                if (await _cardTypeRepository.DeleteAsync(cardTypeId))
                {
                    MessageBox.Show("Card Type deleted successfully");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error in processing delete card type " + ex.Message);
            }
        }

        //method format Number Card
        public string MaskingNumber(string number)
        {
            var length = number.Length;
            if (length < 8) return number;
            return number.Substring(0,4) + " **** **** " + number.Substring(length - 4);
        }
    }
}

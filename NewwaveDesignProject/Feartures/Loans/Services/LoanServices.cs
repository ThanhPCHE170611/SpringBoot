using Design_WPF.Feature.Loans.Models;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Repository;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Loans.Models;
using System.Collections.ObjectModel;
using System.Globalization;

namespace NewwaveDesignProject.Services
{
    public class LoanServices : ILoanService
    {
        private readonly IRepository<Loan> _loanRepository;
        private readonly IRepository<LoanType> _loanTypeRepository;

        public LoanServices(IRepository<Loan>? loanRepository, IRepository<LoanType>? loanTypeRepository)
        {
            _loanRepository = loanRepository;
            _loanTypeRepository = loanTypeRepository;
        }
        //Get Loan List
        public async Task<ObservableCollection<LoanDTO>> GetLoanListAsync()
        {
            var loans = (await _loanRepository.GetAll()).Select(loanItem => new LoanDTO(loanItem.Id, FormatMoney(loanItem.LoanMoney),
                                                             FormatMoney(loanItem.RepayMoney),$"{loanItem.Duration} Months", FormatPercentage(loanItem.Interest),
                                                            FormatInstallment(loanItem.Instalment), "Repay"));
            
            return new ObservableCollection<LoanDTO>(loans);
        }
        //method get total loan
        public async Task<LoanTotalDTO> GetLoanTotalAsync()
        {
            var loans = await _loanRepository.GetAll();
            var totalLoanMoney = loans.Sum(loan => loan.LoanMoney);
            var totalLeftToRepay = loans.Sum(loan => loan.RepayMoney);
            var installment = loans.Sum(loan => loan.Instalment);

            return new LoanTotalDTO
            {
                TotalLoanMoney = FormatMoney(totalLoanMoney),
                TotalLeftToRepay = FormatMoney(totalLeftToRepay),
                Installment =FormatInstallment(installment)
            };
        }

        //method get loan type list
        public async Task<ObservableCollection<LoanTypeDTO>> GetLoanTypeListAsync()
        {
            var loanTypes = (await _loanTypeRepository.GetAll()).Select(_loanTypeRepository => new LoanTypeDTO
            {
                Title = _loanTypeRepository.Name,
                Cost = _loanTypeRepository.Description,
                Icon = UserInterface.CreateBitmapImage("ImageLoan/Statistical", _loanTypeRepository.Icon??"Bag.png")
            });

            return new ObservableCollection<LoanTypeDTO>(loanTypes);
        }
        //method format money
        public string FormatMoney(decimal money)
        {
            return money.ToString("C0", CultureInfo.CreateSpecificCulture("en-US"));
        }

        //method format percentage
        public string FormatPercentage(decimal percentage)
        {
            return percentage.ToString("P2", CultureInfo.InvariantCulture);
        }

        //method format Installment
        public string FormatInstallment(decimal installment)
        {
            return $"{installment.ToString("C0", CultureInfo.CreateSpecificCulture("en-US"))} / month";
        }
    }
}

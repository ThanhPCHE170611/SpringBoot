using Design_WPF.Feature.Loans.Models;
using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.Loans.Models;
using NewwaveDesignProject.Services;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;

namespace NewwaveDesignProject.ViewModels
{
    public class LoanViewModel :ViewModalBase
    {
        public ILoanService? loanService;
        public ICommand? RepayCommand { get; set; }
        public LoanTypeDTO? StatisticalItem1 { get; set; }
        public LoanTypeDTO? StatisticalItem2 { get; set; }
        public LoanTypeDTO? StatisticalItem3 { get; set; }
        public LoanTypeDTO? StatisticalItem4 { get; set; }
        public ObservableCollection<LoanDTO>? ListActiveLoans { get; set; }
        public LoanTotalDTO? LoanTotal { get; set; }
        public LoanViewModel(ILoanService loanService)
        {
            this.loanService = loanService;
            InitialDataAsync();
            InitialCommand();
        }
        public async Task InitialDataAsync()
        {
            await InitialStaticCalDataAsync();
            ListActiveLoans = await loanService.GetLoanListAsync();
            LoanTotal = await loanService.GetLoanTotalAsync();
        }

        public async Task InitialStaticCalDataAsync()
        {
            var loanTypes = await loanService.GetLoanTypeListAsync();
            StatisticalItem1 = loanTypes[0];
            StatisticalItem2 = loanTypes[1];
            StatisticalItem3 = loanTypes[2];
            StatisticalItem4 = loanTypes[3];
        }
        public void InitialCommand()
        {
            RepayCommand = new RelayCommand<object>(Repay);
        }

        public void Repay(object parameter)
        {
            var currentActiveLoanItem = parameter as LoanDTO;
            OnRepay(currentActiveLoanItem ?? new LoanDTO());
        }
        private void OnRepay(LoanDTO model)
        {
            foreach (var item in ListActiveLoans)
            {
                item.isCheck = false;
            }

            model.isCheck = true;

            MessageBox.Show($"Đang thanh toán khoản vay {model.Money}...");
        }
    }
}

using Design_WPF.Feature.Loans.Models;
using NewwaveDesignProject.Feartures.Loans.Models;
using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Services
{
    public interface ILoanService
    {
        Task<ObservableCollection<LoanDTO>> GetLoanListAsync();
        Task<LoanTotalDTO> GetLoanTotalAsync();
        Task<ObservableCollection<LoanTypeDTO>> GetLoanTypeListAsync();
    }
}

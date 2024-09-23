using NewwaveDesignProject.Cores.MVVM;

namespace Design_WPF.Feature.Loans.Models
{
    public class LoanTotalDTO : ModelBase
	{
        public string? TotalLoanMoney { get; set; }
        public string? TotalLeftToRepay { get; set; }
        public string? Installment { get; set; }
        public string Empty => string.Empty;
    }
}

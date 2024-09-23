using NewwaveDesignProject.Cores.MVVM;

namespace Design_WPF.Feature.Loans.Models
{
    public class LoanDTO : ModelBase
    {
        public int Id { get; set; }
        public bool isCheck { get; set; }
        public string? Money { get; set; }
        public string? Repay { get; set; }
        public string? Durations { get; set; }
        public string? InterestRate { get; set; }
        public string? Installment { get; set; }
        public string? RepayContent { get; set; }

        public LoanDTO(int id, string? money, string? repay, string? durations, string? interestRate, string? installment, string? repayContent)
        {
            Id = id;
            Money = money;
            Repay = repay;
            Durations = durations;
            InterestRate = interestRate;
            Installment = installment;
            RepayContent = repayContent;
        }
        public LoanDTO()
        {

        }
    }
}

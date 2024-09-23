using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class Loan : Entity
    {
        public decimal LoanMoney { get; set; }
        public decimal RepayMoney { get; set; }
        public int Duration { get; set; }
        public decimal Interest { get; set; }
        public decimal Instalment { get; set; }

        [ForeignKey("Card")]
        public int CardId { get; set; }

        [ForeignKey("LoanType")]
        public int LoanTypeId { get; set; }

        public Loan(int id, decimal loanMoney, decimal repayMoney, int duration, decimal interest, decimal instalment, int cardId, int loanTypeId)
        {
            Id = id;
            LoanMoney = loanMoney;
            RepayMoney = repayMoney;
            Duration = duration;
            Interest = interest;
            Instalment = instalment;
            CardId = cardId;
            LoanTypeId = loanTypeId;
        }

        public virtual Card Card { get; set; }
        public virtual LoanType LoanType { get; set; }
    }
}

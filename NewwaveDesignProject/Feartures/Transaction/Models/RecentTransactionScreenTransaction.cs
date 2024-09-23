using NewwaveDesignProject.Cores.MVVM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NewwaveDesignProject.Feartures.Transaction.Models
{
    public class RecentTransactionScreenTransaction : ModelBase
    {
        public string? ImagePath
        {
            get; set;
        }
        public string? Description { get; set; }
        public string? TransactionID { get; set; }
        public string? Type { get; set; }

        public string? Card { get; set; }

        public DateTime Date { get; set; }
        public string? Amount { get; set; }
    }
}

using NewwaveDesignProject.Cores.MVVM;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Loans.Models
{
    public class LoanTypeDTO : ModelBase
    {
        public string? Title {get; set; }
        public string? Cost { get; set; }
        public ImageSource? Icon { get; set; }
    }
}

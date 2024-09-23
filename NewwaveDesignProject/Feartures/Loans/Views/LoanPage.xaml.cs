using NewwaveDesignProject.ViewModels;
using System.Windows.Controls;

namespace NewwaveDesignProject.Views
{
    public partial class LoanPage : Page
    {
        public LoanPage(LoanViewModel loanViewModel)
        {
            InitializeComponent();
            DataContext = loanViewModel;
        }
    }
}

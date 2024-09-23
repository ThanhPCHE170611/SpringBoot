using Design_WPF.Feature.Loans.Models;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.UI.UserControls
{
    public partial class listUserActive : UserControl
    {
        public static readonly DependencyProperty LoansProperty =
         DependencyProperty.Register("Loans", typeof(ObservableCollection<LoanDTO>), typeof(listUserActive), new PropertyMetadata(null));

        public ObservableCollection<LoanDTO> Loans
        {
            get { return (ObservableCollection<LoanDTO>)GetValue(LoansProperty); }
            set { SetValue(LoansProperty, value); }
        }
        public static readonly DependencyProperty LoanTotalProperty =
         DependencyProperty.Register("LoanTotal", typeof(LoanTotalDTO), typeof(listUserActive), new PropertyMetadata(null));

        public LoanTotalDTO LoanTotal
        {
            get { return (LoanTotalDTO)GetValue(LoanTotalProperty); }
            set { SetValue(LoansProperty, value); }
        }


        public listUserActive()
        {
            InitializeComponent();
        }
    }

}

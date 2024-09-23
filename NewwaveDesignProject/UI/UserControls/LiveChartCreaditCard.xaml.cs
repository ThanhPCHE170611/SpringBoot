using LiveChartsCore;
using System.Windows.Controls;

namespace NewwaveDesignProject.UI.UserControls
{
    public partial class LiveChartCreaditCard : UserControl
    {
        public IEnumerable<ISeries> Series { get; set; }
        public LiveChartCreaditCard()
        {
            InitializeComponent();
            //this.DataContext = new LiveChartCreditCardViewModel();
        }
    }
}

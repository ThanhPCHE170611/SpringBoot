using NewwaveDesignProject.Feartures.Investments.ViewModels;
using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.Feartures.Investments.Views
{
	/// <summary>
	/// Interaction logic for Investment.xaml
	/// </summary>
	public partial class Investment : UserControl
    {
        public Investment(InvestmentViewModel investmentViewModel)
        {
            InitializeComponent();
            DataContext = investmentViewModel;
        }

		private void TextBlockUC_Loaded(object sender, RoutedEventArgs e)
		{

		}
	}
}

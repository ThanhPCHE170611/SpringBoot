using DryIoc;
using NewwaveDesignProject.Feartures.Accounts.ViewModels;
using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.Feartures.Accounts.Views
{
	/// <summary>
	/// Interaction logic for Account.xaml
	/// </summary>
	public partial class Account : UserControl
    {
        public Account(AccountViewModel accountViewModel)
        {
            InitializeComponent();
			this.DataContext = accountViewModel;
		}
    }
}

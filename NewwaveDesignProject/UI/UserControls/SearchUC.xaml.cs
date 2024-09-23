using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.UI.UserControls
{

	public partial class SearchUC : UserControl
	{
		public SearchUC()
		{
			InitializeComponent();
			ShowPlaceholder();
		}

		private void ShowPlaceholder()
		{
			PlaceholderText.Visibility = Visibility.Visible;
		}

		private void HidePlaceholder()
		{
			PlaceholderText.Visibility = Visibility.Collapsed;
		}

		private void SearchBox_GotFocus(object sender, RoutedEventArgs eventArgs)
		{
			HidePlaceholder();
		}

		private void SearchBox_LostKeyboardFocus(object sender, System.Windows.Input.KeyboardFocusChangedEventArgs eventArgs)
		{
			if (string.IsNullOrWhiteSpace(SearchBox.Text))
			{
				ShowPlaceholder();
			}
		}

		private void UserControl_PreviewMouseDown(object sender, System.Windows.Input.MouseButtonEventArgs eventArgs)
		{
			if (!SearchBox.IsKeyboardFocusWithin)
			{
				if (string.IsNullOrWhiteSpace(SearchBox.Text))
				{
					ShowPlaceholder();
				}
				else
				{
					HidePlaceholder();
				}
			}
		}
	}
}


using System.Windows;
using System.Windows.Controls;


namespace NewwaveDesignProject.UI.UserControls
{
    public partial class FieldTextInput : UserControl
    {
        public string Label
        {
            get { return (string)GetValue(LabelProperty); }
            set { SetValue(LabelProperty, value); }
        }

        public static readonly DependencyProperty LabelProperty =
            DependencyProperty.Register("Label", typeof(string), typeof(FieldTextInput), new PropertyMetadata(default(string)));
        public string Placeholder
        {
            get { return (string)GetValue(PlaceholderProperty); }
            set { SetValue(PlaceholderProperty, value); }
        }

        public static readonly DependencyProperty PlaceholderProperty =
            DependencyProperty.Register("Placeholder", typeof(string), typeof(FieldTextInput), new PropertyMetadata(default(string)));


        public FieldTextInput()
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

        private void SearchBox_GotFocus(object sender, RoutedEventArgs e)
        {
            HidePlaceholder();
        }

        private void SearchBox_LostKeyboardFocus(object sender, System.Windows.Input.KeyboardFocusChangedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(SearchBox.Text))
            {
                ShowPlaceholder();
            }
        }

        private void UserControl_PreviewMouseDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
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

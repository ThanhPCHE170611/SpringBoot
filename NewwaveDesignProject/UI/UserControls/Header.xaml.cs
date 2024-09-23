using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.UI.UserControls
{
    public partial class Header : UserControl
    {
        public string Title
        {
            get { return (string)GetValue(TitleProperty); }
            set { SetValue(TitleProperty, value); }
        }

        // Using a DependencyProperty as the backing store for HeaderText.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty TitleProperty =
            DependencyProperty.Register("Title", typeof(string), typeof(Header), new PropertyMetadata(null));
        public Header()
        {
            InitializeComponent();
        }
    }
}

using NewwaveDesignProject.Cores.MVVM.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace NewwaveDesignProject.UI.UserControls
{
    /// <summary>
    /// Interaction logic for PasswordUC.xaml
    /// </summary>
    public partial class PasswordUC : UserControl
    {



        public string Content
        {
            get { return (string)GetValue(ContentProperty); }
            set { SetValue(ContentProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Content.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty ContentProperty =
            DependencyProperty.Register("Content", typeof(string), typeof(PasswordUC), new PropertyMetadata(default(string)));



        public PasswordUC()
        {
            InitializeComponent();
        }
        private void TogglePasswordVisibilityButton_Click(object sender, RoutedEventArgs e)
        {
            if (HiddenPasswordBox.Visibility == Visibility.Visible)
            {
                VisiblePasswordBox.Visibility = Visibility.Visible;
                HiddenPasswordBox.Visibility = Visibility.Collapsed;
                VisiblePasswordBox.Text = HiddenPasswordBox.Password;
            }
            else
            {
                HiddenPasswordBox.Visibility = Visibility.Visible;
                VisiblePasswordBox.Visibility = Visibility.Collapsed;
                HiddenPasswordBox.Password = VisiblePasswordBox.Text;
            }
        }
    }
}

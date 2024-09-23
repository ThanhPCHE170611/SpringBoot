using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
namespace NewwaveDesignProject.UI.UserControls
{
    /// <summary>
    /// Interaction logic for ServicesCards.xaml
    /// </summary>
    public partial class ServicesCardsUC : UserControl
    {
        public ServicesCardsUC()
        {
            InitializeComponent();
        }
      
        public static readonly DependencyProperty CardImageSourceProperty =
            DependencyProperty.Register("CardImageSource", typeof(ImageSource), typeof(ServicesCardsUC), new PropertyMetadata(null));

        public ImageSource CardImageSource
        {
            get { return (ImageSource)GetValue(CardImageSourceProperty); }
            set { SetValue(CardImageSourceProperty, value); }
        }

        public string ServiceName
        {
            get { return (string)GetValue(ServiceNameProperty); }
            set { SetValue(ServiceNameProperty, value); }
        }

        // Using a DependencyProperty as the backing store for ServiceName.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty ServiceNameProperty =
            DependencyProperty.Register("ServiceName", typeof(string), typeof(ServicesCardsUC), new PropertyMetadata(default(string)));



        public static readonly DependencyProperty SloganProperty =
            DependencyProperty.Register("Slogan", typeof(string), typeof(ServicesCardsUC), new PropertyMetadata(string.Empty));

        public string Slogan
        {
            get { return (string)GetValue(SloganProperty); }
            set { SetValue(SloganProperty, value); }
        }
    }
}

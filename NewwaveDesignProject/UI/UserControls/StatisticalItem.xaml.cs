using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace NewwaveDesignProject.UI.UserControls
{
    public partial class StatisticalItem : UserControl
    {
        public Brush BackgroundColoeEllipse
        {
            get { return (Brush)GetValue(BackgroundColoeEllipseProperty); }
            set { SetValue(BackgroundColoeEllipseProperty, value); }
        }

        // Using a DependencyProperty as the backing store for MyProperty.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty BackgroundColoeEllipseProperty =
            DependencyProperty.Register("BackgroundColoeEllipse", typeof(Brush), typeof(StatisticalItem), new PropertyMetadata(Brushes.Gray));



            public ImageSource Icon
            {
                get { return (ImageSource)GetValue(IconProperty); }
                set { SetValue(IconProperty, value); }
            }

            // Using a DependencyProperty as the backing store for Icon.  This enables animation, styling, binding, etc...
            public static readonly DependencyProperty IconProperty =
                DependencyProperty.Register("Icon", typeof(ImageSource), typeof(StatisticalItem), new PropertyMetadata(null));



        public string Title
        {
            get { return (string)GetValue(TitleProperty); }
            set { SetValue(TitleProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Title.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty TitleProperty =
            DependencyProperty.Register("Title", typeof(string), typeof(StatisticalItem), new PropertyMetadata(default(string)));
        
        public string Cost
        {
            get { return (string)GetValue(CostProperty); }
            set { SetValue(CostProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Cost.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty CostProperty =
            DependencyProperty.Register("Cost", typeof(string), typeof(StatisticalItem), new PropertyMetadata(default(string)));



        public int FontSizeCost
        {
            get { return (int)GetValue(FontSizeCostProperty); }
            set { SetValue(FontSizeCostProperty, value); }
        }

        // Using a DependencyProperty as the backing store for FontSizeCost.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty FontSizeCostProperty =
            DependencyProperty.Register("FontSizeCost", typeof(int), typeof(StatisticalItem), new PropertyMetadata(20));


        public StatisticalItem()
        {
            InitializeComponent();
            this.DataContext = this;
        }
    }
}

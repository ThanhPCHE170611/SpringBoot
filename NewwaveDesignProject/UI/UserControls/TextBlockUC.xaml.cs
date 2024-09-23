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
    /// Interaction logic for TextBlockUC.xaml
    /// </summary>
    public partial class TextBlockUC : UserControl
    {
        public TextBlockUC()
        {
            InitializeComponent();
        }

		public static readonly DependencyProperty BackgroundColorProperty =
		   DependencyProperty.Register("BackgroundColor", typeof(Brush), typeof(TextBlockUC), new PropertyMetadata(null));

		public Brush BackgroundColor
		{
			get { return (Brush)GetValue(BackgroundColorProperty); }
			set { SetValue(BackgroundColorProperty, value); }
		}

		public static readonly DependencyProperty IconProperty =
			DependencyProperty.Register("Icon", typeof(ImageSource), typeof(TextBlockUC), new PropertyMetadata(null));

		public ImageSource Icon
		{
			get { return (ImageSource)GetValue(IconProperty); }
			set { SetValue(IconProperty, value); }
		}

		public static readonly DependencyProperty TitleProperty =
			DependencyProperty.Register("Title", typeof(string), typeof(TextBlockUC), new PropertyMetadata(null));

		public string Title
		{
			get { return (string)GetValue(TitleProperty); }
			set { SetValue(TitleProperty, value); }
		}

		public static readonly DependencyProperty DetailProperty =
			DependencyProperty.Register("Detail", typeof(string), typeof(TextBlockUC), new PropertyMetadata(string.Empty));

		public string Detail
		{
			get { return (string)GetValue(DetailProperty); }
			set { SetValue(DetailProperty, value); }
		}

		public static readonly DependencyProperty WidthTextBlockProperty =
			DependencyProperty.Register("WidthTextBlock", typeof(int), typeof(TextBlockUC), new PropertyMetadata(0));

		public int WidthTextBlock
		{
			get { return (int)GetValue(WidthTextBlockProperty); }
			set { SetValue(WidthTextBlockProperty, value); }
		}

		public static readonly DependencyProperty HeightTextBlockProperty =
			DependencyProperty.Register("HeightTextBlock", typeof(int), typeof(TextBlockUC), new PropertyMetadata(0));

		public int HeightTextBlock
		{
			get { return (int)GetValue(HeightTextBlockProperty); }
			set { SetValue(HeightTextBlockProperty, value); }
		}
	}
}

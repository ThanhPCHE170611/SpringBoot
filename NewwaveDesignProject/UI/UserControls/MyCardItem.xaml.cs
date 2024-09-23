using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace NewwaveDesignProject.UI.UserControls
{
    public partial class MyCardItem : UserControl
    {
		public static readonly DependencyProperty BorderBackgroundTopProperty =
		  DependencyProperty.Register("BorderBackgroundTop", typeof(Brush), typeof(MyCardItem), new PropertyMetadata(null));

		public Brush BorderBackgroundTop
		{
			get { return (Brush)GetValue(BorderBackgroundTopProperty); }
			set { SetValue(BorderBackgroundTopProperty, value); }
		}
		public static readonly DependencyProperty BackgroundGradientStartProperty =
	DependencyProperty.Register("BackgroundGradientStart", typeof(Color), typeof(MyCardItem), new PropertyMetadata(null));

		public Color BackgroundGradientStart
		{
			get { return (Color)GetValue(BackgroundGradientStartProperty); }
			set { SetValue(BackgroundGradientStartProperty, value); }
		}

		public static readonly DependencyProperty BackgroundGradientEndProperty =
			DependencyProperty.Register("BackgroundGradientEnd", typeof(Color), typeof(MyCardItem), new PropertyMetadata(null));

		public Color BackgroundGradientEnd
		{
			get { return (Color)GetValue(BackgroundGradientEndProperty); }
			set { SetValue(BackgroundGradientEndProperty, value); }
		}

		public static readonly DependencyProperty BorderBrushTopColorProperty =
	  DependencyProperty.Register("BorderBrushTopColor", typeof(Brush), typeof(MyCardItem), new PropertyMetadata(Brushes.Transparent));

		public Brush BorderBrushTopColor
		{
			get { return (Brush)GetValue(BorderBrushTopColorProperty); }
			set { SetValue(BorderBrushTopColorProperty, value); }
		}

		public static readonly DependencyProperty BorderBackgroundBottomProperty =
		  DependencyProperty.Register("BorderBackgroundBottom", typeof(Brush), typeof(MyCardItem), new PropertyMetadata(Brushes.Transparent));

		public Brush BorderBackgroundBottom
		{
			get { return (Brush)GetValue(BorderBackgroundBottomProperty); }
			set { SetValue(BorderBackgroundBottomProperty, value); }
		}

		public static readonly DependencyProperty BorderBrushBottomColorProperty =
			DependencyProperty.Register("BorderBrushBottomColor", typeof(Brush), typeof(MyCardItem), new PropertyMetadata(Brushes.Transparent));

		public Brush BorderBrushBottomColor
		{
			get { return (Brush)GetValue(BorderBrushBottomColorProperty); }
			set { SetValue(BorderBrushBottomColorProperty, value); }
		}

		public static readonly DependencyProperty BorderBottomThicknessProperty =
			DependencyProperty.Register("BorderBottomThickness", typeof(Thickness), typeof(MyCardItem), new PropertyMetadata(new Thickness(1)));

		public Thickness BorderBottomThickness
		{
			get { return (Thickness)GetValue(BorderBottomThicknessProperty); }
			set { SetValue(BorderBottomThicknessProperty, value); }
		}
		public static readonly DependencyProperty ColorTitleProperty =
					DependencyProperty.Register("ColorTitle", typeof(Brush), typeof(MyCardItem), new PropertyMetadata(Brushes.White));

		public Brush ColorTitle
		{
			get { return (Brush)GetValue(ColorTitleProperty); }
			set { SetValue(ColorTitleProperty, value); }
		}

		public static readonly DependencyProperty ColorContentProperty =
			DependencyProperty.Register("ColorContent", typeof(Brush), typeof(MyCardItem), new PropertyMetadata(Brushes.White));

		public Brush ColorContent
		{
			get { return (Brush)GetValue(ColorContentProperty); }
			set { SetValue(ColorContentProperty, value); }
		}

		public string TextBlock1
		{
			get { return (string)GetValue(TextBlock1Property); }
			set { SetValue(TextBlock1Property, value); }
		}
		public static readonly DependencyProperty TextBlock1Property =
			DependencyProperty.Register("TextBlock1", typeof(string), typeof(MyCardItem), new PropertyMetadata(default(string)));
		public string TextBlock2
		{
			get { return (string)GetValue(TextBlock2Property); }
			set { SetValue(TextBlock2Property, value); }
		}
		public static readonly DependencyProperty TextBlock2Property =
			DependencyProperty.Register("TextBlock2", typeof(string), typeof(MyCardItem), new PropertyMetadata(default(string)));
		public string TextBlock3
		{
			get { return (string)GetValue(TextBlock3Property); }
			set { SetValue(TextBlock3Property, value); }
		}
		public static readonly DependencyProperty TextBlock3Property =
			DependencyProperty.Register("TextBlock3", typeof(string), typeof(MyCardItem), new PropertyMetadata(default(string)));
		public string TextBlock4
		{
			get { return (string)GetValue(TextBlock4Property); }
			set { SetValue(TextBlock4Property, value); }
		}
		public static readonly DependencyProperty TextBlock4Property =
			DependencyProperty.Register("TextBlock4", typeof(string), typeof(MyCardItem), new PropertyMetadata(default(string)));
		public string TextBlock5
		{
			get { return (string)GetValue(TextBlock5Property); }
			set { SetValue(TextBlock5Property, value); }
		}
		public static readonly DependencyProperty TextBlock5Property =
			DependencyProperty.Register("TextBlock5", typeof(string), typeof(MyCardItem), new PropertyMetadata(default(string)));
		public string TextBlock6
		{
			get { return (string)GetValue(TextBlock6Property); }
			set { SetValue(TextBlock6Property, value); }
		}
		public static readonly DependencyProperty TextBlock6Property = DependencyProperty.Register("TextBlock6", typeof(string), typeof(MyCardItem), new PropertyMetadata(default(string)));
		public string TextBlock7
		{
			get { return (string)GetValue(TextBlock7Property); }
			set { SetValue(TextBlock7Property, value); }
		}
		public static readonly DependencyProperty TextBlock7Property =
			DependencyProperty.Register("TextBlock7", typeof(string), typeof(MyCardItem), new PropertyMetadata(default(string)));
		public ImageSource ChipCardSource
		{
			get { return (ImageSource)GetValue(ChipCardSourceProperty); }
			set { SetValue(ChipCardSourceProperty, value); }
		}
		public static readonly DependencyProperty ChipCardSourceProperty =
			DependencyProperty.Register("ChipCardSource", typeof(ImageSource), typeof(MyCardItem), new PropertyMetadata(null));

		public ImageSource Circle
		{
			get { return (ImageSource)GetValue(CircleProperty); }
			set { SetValue(CircleProperty, value); }
		}
		public static readonly DependencyProperty CircleProperty =
			DependencyProperty.Register("Circle", typeof(ImageSource), typeof(MyCardItem), new PropertyMetadata(null));

        public MyCardItem()
        {
            InitializeComponent();
        }

    }
}

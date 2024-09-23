using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.UI.UserControls
{
    public partial class MasterCardUC : UserControl
    {
        public static readonly DependencyProperty StartBColorProperty =
           DependencyProperty.Register("StartBColor", typeof(string), typeof(MasterCardUC));

        public string StartBColor
        {
            get { return (string)GetValue(StartBColorProperty); }
            set { SetValue(StartBColorProperty, value); }
        }
        public static readonly DependencyProperty EndBColorProperty =
           DependencyProperty.Register("EndBColor", typeof(string), typeof(MasterCardUC));

        public string EndBColor
        {
            get { return (string)GetValue(EndBColorProperty); }
            set { SetValue(EndBColorProperty, value); }
        }
        public static readonly DependencyProperty BalanceProperty =
           DependencyProperty.Register("Balance", typeof(string), typeof(MasterCardUC));

        public string Balance
        {
            get { return (string)GetValue(BalanceProperty); }
            set { SetValue(BalanceProperty, value); }
        }
        public static readonly DependencyProperty ChipSourceProperty =
           DependencyProperty.Register("ChipSource", typeof(string), typeof(MasterCardUC));

        public string ChipSource
        {
            get { return (string)GetValue(ChipSourceProperty); }
            set { SetValue(ChipSourceProperty, value); }
        }
        public static readonly DependencyProperty CardHolderProperty =
           DependencyProperty.Register("CardHolder", typeof(string), typeof(MasterCardUC));

        public string CardHolder
        {
            get { return (string)GetValue(CardHolderProperty); }
            set { SetValue(CardHolderProperty, value); }
        }

        public static readonly DependencyProperty ValidThruProperty =
           DependencyProperty.Register("ValidThru", typeof(string), typeof(MasterCardUC));

        public string ValidThru
        {
            get { return (string)GetValue(ValidThruProperty); }
            set { SetValue(ValidThruProperty, value); }
        }

        public static readonly DependencyProperty CardNumberProperty =
           DependencyProperty.Register("CardNumber", typeof(string), typeof(MasterCardUC));

        public string CardNumber
        {
            get { return (string)GetValue(CardNumberProperty); }
            set { SetValue(CardNumberProperty, value); }
        }

        public static readonly DependencyProperty MasterCardLogoProperty =
           DependencyProperty.Register("MasterCardLogo", typeof(string), typeof(MasterCardUC));

        public string MasterCardLogo
        {
            get { return (string)GetValue(MasterCardLogoProperty); }
            set { SetValue(MasterCardLogoProperty, value); }
        }

        public static readonly DependencyProperty LaberColorProperty =
           DependencyProperty.Register("LaberColor", typeof(string), typeof(MasterCardUC));

        public string LaberColor
        {
            get { return (string)GetValue(LaberColorProperty); }
            set { SetValue(LaberColorProperty, value); }
        }
        public static readonly DependencyProperty ContentColorProperty =
           DependencyProperty.Register("ContentColor", typeof(string), typeof(MasterCardUC));

        public string ContentColor
        {
            get { return (string)GetValue(ContentColorProperty); }
            set { SetValue(ContentColorProperty, value); }
        }
        public static readonly DependencyProperty CardColorBorderProperty =
           DependencyProperty.Register("CardColorBorder", typeof(string), typeof(MasterCardUC));

        public string CardColorBorder
        {
            get { return (string)GetValue(CardColorBorderProperty); }
            set { SetValue(CardColorBorderProperty, value); }
        }
        public MasterCardUC()
        {
            InitializeComponent();
        }
    }
}

using NewwaveDesignProject.Cores.MVVM.Utils;
using System.Globalization;
using System.Windows.Data;

namespace NewwaveDesignProject.Cores.Converters
{
	public class AmountColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string? amount = value as string;
            if (!string.IsNullOrEmpty(amount))
            {
                return amount[0].CompareTo('-') == 0 ? UserInterface.CreateSolidColorBrush("#FE5C73") : UserInterface.CreateSolidColorBrush("#16DBAA");
            }
            return 0;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}

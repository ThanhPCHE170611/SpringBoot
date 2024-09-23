using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Data;

namespace NewwaveDesignProject.Cores.Converters
{
    public class GridColumnWithConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is double gridWidth
                && parameter is string columnIndexStr
                && int.TryParse(columnIndexStr, out int columnIndex))
            {
                // Adjust these ratios according to the ColumnDefinition.Width
                double[] columnRatios = { 2, 1, 1, 1, 1.5, 1, 1.5 };
                double totalRatio = columnRatios.Sum();
                return gridWidth * (columnRatios[columnIndex] / totalRatio);
            }
            return DependencyProperty.UnsetValue;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}

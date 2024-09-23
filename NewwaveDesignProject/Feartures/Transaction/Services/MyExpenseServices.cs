using LiveCharts;
using LiveCharts.Wpf;
using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Feartures.Transaction.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Transaction.Services
{
    public class MyExpenseServices : ViewModalBase
    {
        private Expense _expense = new Expense();
        public Expense Expense
        {
            get => _expense; set
            {
                _expense = value;
                ;
            }
        }

        public MyExpenseServices()
        {
            Expense = new Expense
            {
                SeriesCollection = new SeriesCollection
                {
                    new ColumnSeries
                    {
                        Values = new ChartValues<double> { 10000, 14000, 10000, 8000, 12500, 9500 }
                    }
                },
                Labels = new[] { "Aug", "Sep", "Oct", "Nov", "Dec", "Jan" },
                YFormatter = value => value.ToString("N")
            };
        }
    }
}

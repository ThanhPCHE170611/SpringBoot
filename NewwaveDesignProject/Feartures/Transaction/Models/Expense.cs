using LiveCharts;
using LiveCharts.Wpf;
using NewwaveDesignProject.Cores;
using NewwaveDesignProject.Cores.MVVM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NewwaveDesignProject.Feartures.Transaction.Models
{
    public class Expense : ModelBase
    {
        public SeriesCollection SeriesCollection { get; set; } = new SeriesCollection();

        public string[] Labels
        {
            get; set;

        } = new string[] { };

        public Func<double, string>? YFormatter
        {
            get;
            set;
        }
    }
}
 

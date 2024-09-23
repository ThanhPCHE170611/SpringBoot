using NewwaveDesignProject.Cores;
using NewwaveDesignProject.Cores.MVVM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.DashBoard.Models
{
    public class RecentTransaction : ModelBase
    {
        public ImageSource? ImagePath { get; set; }
        public string? Name { get; set; }
        public string? Date { get; set; }
        public string? Amount { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Transaction.Models
{
    public class MenuItemModel
    {
        public string? Header { get; set; }
        public Brush? Background { get; set; }
        public double FontSize { get; set; }
        public FontWeight FontWeight { get; set; }

        public ICommand? PageClick { get; set; }
    }
}

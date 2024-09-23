using NewwaveDesignProject.Cores.MVVM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;

namespace NewwaveDesignProject.Feartures.Transaction.Models
{
    public class MasterCard : ModelBase
    {
        public Brush? StartBColor { get; set; }
        public Brush? EndBColor { get; set
            ;
        }
        public string? Balance { get; set; }
        public ImageSource? ChipSource { get; set
            ;
        }
        public string? CardHolder { get; set
           ;
        }
        public string? ValidThru { get ; set
            ;
        }
        public string? CardNumber { get; set
            ;
        }
        public ImageSource? MasterLogo { get ; set
            ;
        }
        public Brush? LaberColor { get; set
            ;
        }
        public Brush? ContentColor { get ; set
           ;
        }
        public Brush? CardColorBorder { get ; set
           ;
        }

    }
}

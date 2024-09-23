using NewwaveDesignProject.Feartures.DashBoard.Viewmodels;
using System.Windows.Controls;

namespace NewwaveDesignProject.Feartures.DashBoard.Views
{
    public partial class DashBoard : UserControl
    {

        public  DashBoard(DashBoardViewModel dashBoardViewModel)
        {
            InitializeComponent();
            DataContext = dashBoardViewModel;
        }
    }
}

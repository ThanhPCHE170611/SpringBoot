using NewwaveDesignProject.Cores.MVVM;

namespace NewwaveDesignProject.Feartures.SideBar.ViewModels
{
	public class MenuItemViewModel : ViewModalBase
	{
		public string? Header { get; set; }

		public bool IsSelected { get; set; }

		public string? ImageSource { get; set; }

		public Type? ViewType { get; set; }
	}
}

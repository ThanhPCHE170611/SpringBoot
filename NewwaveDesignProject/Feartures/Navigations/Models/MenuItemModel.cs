using NewwaveDesignProject.Cores.MVVM;

namespace NewwaveDesignProject.Feartures.Navigations.Models
{
    public class MenuItemModel : ModelBase
	{
		public string? Header { get; set; }

		public Type? ViewType { get; set; }

		public bool IsSelected { get; set; }

		public string? ImageSource { get; set; }

		private void UpdateImageSource()
		{
			ImageSource = $"../Images/LeftSideBar/{Header?.Replace(" ", "")}{(IsSelected ? "change" : "Default")}.png";
		}
	}
}

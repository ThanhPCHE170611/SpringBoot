using System.Windows.Navigation;

namespace NewwaveDesignProject.Cores.MVVM
{
	public interface INavigationService
	{
		void NavigateTo(Type viewType);
		event Action<string> OnNavigated;

	}
}

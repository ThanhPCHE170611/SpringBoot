using DryIoc;
using NewwaveDesignProject.Cores.MVVM;
using System.Windows;
using System.Windows.Controls;

namespace NewwaveDesignProject.Feartures.Navigations.ViewModels
{
	public class NavigationService : INavigationService
	{
		private readonly Frame _frame;

        public event Action<string>? OnNavigated;

        public NavigationService(Frame frame)
        {
            _frame = frame;
        }

        public void NavigateTo(Type viewType)
        {
            if (viewType == null) return;

            var view = CreateView(viewType);
            if (view == null) return;

            NavigateToView(view);
            NotifyNavigated(viewType);
        }

        private object CreateView(Type viewType)
        {
            return ((App)Application.Current).Container.Resolve(viewType);
        }

        private void NavigateToView(object view)
        {
            _frame.Navigate(view);
        }

        private void NotifyNavigated(Type viewType)
        {
            var viewName = GetViewName(viewType);
            OnNavigated?.Invoke(viewName);
        }

        public string GetViewName(Type viewType)
        {
            return viewType.Name.Replace("View", "");
        }
	}
}

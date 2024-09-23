using NewwaveDesignProject.Cores.MVVM;

namespace NewwaveDesignProject.Feartures.Navigations.ViewModels
{
	public class MainWindowViewModel: ViewModalBase
    {
        //private ICommand _backCommand;
        //public ICommand OnBack => _backCommand ??= new RelayCommand<object>(
        //	param => frame.GoBack(),
        //	param => frame.CanGoBack
        //);

        //private ICommand _forwardCommand;
        //public ICommand OnNext => _forwardCommand ??= new RelayCommand<object>(
        //	param => frame.GoForward()
        //	param => frame.CanGoForward
        //);

        public NavigationViewModel NavigationViewModel { get;  set; }
        public INavigationService NavigationService { get;  set; }
        public HeaderViewModel HeaderViewModel { get;  set; }

        public MainWindowViewModel(NavigationViewModel navigationViewModel, INavigationService navigationService)
        {
            NavigationViewModel = navigationViewModel;
            NavigationService = navigationService;
        }


    }
}

using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Feartures.Example.Commands;
using System.Windows.Input;

namespace NewwaveDesignProject.Feartures.Navigations.ViewModels
{
	public class HeaderViewModel : ViewModalBase
	{
		
		public string HeaderText
		{
			get; set;
		}
		private NavigationService navigationService;
		private NavigationViewModel navigationViewModel;
		public ICommand SettingCommand { get; set; }
		public ICommand NotificationCommand { get; set; }
		public ICommand UserProfileCommand { get; set; }
		public HeaderViewModel(NavigationService navigationService, NavigationViewModel navigationViewModel)
		{
			this.navigationService = navigationService;
			this.navigationViewModel = navigationViewModel;
			//navigationService.OnNavigated += UpdateHeaderText();
			SettingCommand = new SettingCommand();
			NotificationCommand = new NotificationCommand();
			UserProfileCommand = new UserProfileCommand();
		}
        public string RemovePageFromString(string input)
        {
            const string keyword = "Page";
            if (input.Contains(keyword))
            {
                return input.Replace(keyword, string.Empty).Trim();
            }
            return input;
        }

        public void UpdateHeaderText()
		{
			HeaderText = navigationViewModel.GetType().Name;
		}
		
	}
}

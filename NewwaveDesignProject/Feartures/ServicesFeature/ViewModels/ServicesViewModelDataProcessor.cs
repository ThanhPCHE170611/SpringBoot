using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Feartures.ServicesFeature.Models;
using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Feartures.ServicesFeature.ViewModels
{
    public partial class ServicesViewModel : ViewModalBase
    {
        private async void GetTopServices()
        {
            ObservableCollection<CardServicesDTO> listCards = await bankServices.GetTopThreeMostUsedServicesAsync();
            if (listCards != null && listCards.Count > 0)
            {
                MostUsedService = listCards[0];
                SecondUsedService = listCards[1];
                ThirdUsedService = listCards[2];
            }
        }
        private async void GetListServicesItem()
        {
            ListServicesItem = await bankServices.GetNonTopServicesAsync();
        }
    }
}

using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Feartures.ServicesFeature.Models;
using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Services
{
    public interface IBankServices
    {
        Task<IEnumerable<BankService>> GetAllBankServicesAsync();
        Task<ObservableCollection<CardServicesDTO>> GetTopThreeMostUsedServicesAsync();
        Task<ObservableCollection<ServiceListItemDTO>> GetNonTopServicesAsync();
    }
}

using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Repository;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.ServicesFeature.Models;
using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Services
{
    public class BankServices : IBankServices
    {


        private readonly IRepository<BankService> repository;

        public BankServices(IRepository<BankService> repository)
        {
            this.repository = repository;
        }

        public async Task<IEnumerable<BankService>> GetAllBankServicesAsync()
        {
            IEnumerable<BankService> listBankServices = await repository.GetAll();

            return listBankServices;

        }

        public async Task<ObservableCollection<ServiceListItemDTO>> GetNonTopServicesAsync()
        {
            IEnumerable<BankService> listBankServices = await GetAllBankServicesAsync();

            IEnumerable<ServiceListItemDTO> topThreeServices = listBankServices
                                        .OrderByDescending(service => service.UsageCount)
                                        .Skip(3)
                                        .Select(service => service.ToListServiceDTO());

            return new ObservableCollection<ServiceListItemDTO>(topThreeServices);

        }

        public async Task<ObservableCollection<CardServicesDTO>> GetTopThreeMostUsedServicesAsync()
        {
            IEnumerable<BankService> listBankServices = await GetAllBankServicesAsync();

            IEnumerable<CardServicesDTO> topThreeServices = listBankServices
                                        .OrderByDescending(service => service.UsageCount)
                                        .Take(3)
                                        .Select(service => service.ToCardServicesDTO());

            return new ObservableCollection<CardServicesDTO>(topThreeServices);
        }

    }
}

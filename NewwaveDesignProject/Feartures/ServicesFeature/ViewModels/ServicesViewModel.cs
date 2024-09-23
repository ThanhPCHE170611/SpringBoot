using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Command;
using NewwaveDesignProject.Feartures.ServicesFeature.Models;
using NewwaveDesignProject.Services;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;

namespace NewwaveDesignProject.Feartures.ServicesFeature.ViewModels
{
    public partial class ServicesViewModel : ViewModalBase

    {
        private readonly IBankServices bankServices;
        public CardServicesDTO? MostUsedService { get; set; }
        public CardServicesDTO? SecondUsedService { get; set; }
        public CardServicesDTO? ThirdUsedService { get; set; }
        public ObservableCollection<ServiceListItemDTO> ListServicesItem { get; set; }

        public ICommand ViewDetailCommand { get; private set; }
        private void ExecuteViewDetail(object parameter)
        {
            MessageBox.Show("This is detail information");
        }
        public ServicesViewModel(IBankServices bankServices)
        {
            this.bankServices = bankServices;
            GetTopServices();
            GetListServicesItem();
            ViewDetailCommand = new RelayCommand<object>(ExecuteViewDetail);
        }
    }

}

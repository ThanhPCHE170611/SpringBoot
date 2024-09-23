using NewwaveDesignProject.Cores.MVVM;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Repository;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.DashBoard.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NewwaveDesignProject.Feartures.DashBoard.Services
{  
    public class QuickTransferService : ViewModalBase
    {
        private readonly Repository<User> userRepository;
        public ObservableCollection<AccountInfo>? quickTransfers { get; set; }
        public QuickTransferService(Repository<User> userRepository)
        {
            this.userRepository = userRepository;
            InitUserList();
        }

        private async void InitUserList()
        {

            var quickTransferDBList = await userRepository.GetAll(u => u.Id < 4);
            var quickTransferList = quickTransferDBList.Select(u => new AccountInfo
            {
                Name = u.FullName,
                ImagePath = UserInterface.CreateBitmap(u.Avatar),
                Position = u.UserName,
            }).ToList();

            quickTransfers = new ObservableCollection<AccountInfo>(quickTransferList);
        }
    }
}

using NewwaveDesignProject.Cores.MVVM.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NewwaveDesignProject.Cores.MVVM.Utils
{
	public class DataProvider
	{
		private static DataProvider _instance;
		public static DataProvider Instance
		{
			get
			{
				if (_instance == null)
				{
					_instance = new DataProvider();
				}
				return _instance;
			}
			set
			{
				_instance = value;
			}
		}

        public DashBankDbContext db { get; private set; }
        public void Initialize(DashBankDbContext dashbankDB)
        {
            db = dashbankDB;
        }
    }
}

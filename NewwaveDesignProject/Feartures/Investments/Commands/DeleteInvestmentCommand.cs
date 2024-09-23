using NewwaveDesignProject.Cores.MVVM.Commands;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Utils;

namespace NewwaveDesignProject.Feartures.Investments.Commands
{
	public class DeleteInvestmentCommand : IDeleteCommand<int>
	{
		public async Task Execute(int id)
		{
			Investment? investment = DataProvider.Instance.db.Investments.Find(id);
			if (investment != null)
			{
				DataProvider.Instance.db.Remove(investment);
				await DataProvider.Instance.db.SaveChangesAsync();
			}
		}
	}
}

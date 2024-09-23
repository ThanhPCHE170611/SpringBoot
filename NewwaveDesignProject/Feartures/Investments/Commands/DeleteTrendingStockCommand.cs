using NewwaveDesignProject.Cores.MVVM.Commands;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Utils;

namespace NewwaveDesignProject.Feartures.Investments.Commands
{
	public class DeleteTrendingStockCommand : IDeleteCommand<int>
	{
		public async Task Execute(int id)
		{
			Stock? stock = DataProvider.Instance.db.Stocks.Find(id);
			if (stock != null)
			{

				var investments = DataProvider.Instance.db.Investments
					.Where(investment => investment.StockId == id).ToList();

				if (investments.Any())
				{
					DataProvider.Instance.db.Investments.RemoveRange(investments);
				}

				DataProvider.Instance.db.Remove(stock);
				await DataProvider.Instance.db.SaveChangesAsync();

			}
		}
	}
}

using NewwaveDesignProject.Cores.MVVM.Commands;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Investments.Models;

namespace NewwaveDesignProject.Feartures.Investments.Commands
{
	public class CreateTrendingStockCommand : ICreateCommand<StockDTO>
	{
		public async Task Execute(StockDTO stockDTO)
		{
			Stock stock = new Stock()
			{
				Id = stockDTO.NumbericalOrder,
				Description = stockDTO.Description,
				Logo = stockDTO.Logo.ToString(),
				Name = stockDTO.Name,
				Price = Convert.ToDecimal(stockDTO.Price),
				ReturnValue = Convert.ToDecimal(stockDTO.ReturnValue),
			};
			DataProvider.Instance.db.Add(stock);
			await DataProvider.Instance.db.SaveChangesAsync();
		}
	}
}

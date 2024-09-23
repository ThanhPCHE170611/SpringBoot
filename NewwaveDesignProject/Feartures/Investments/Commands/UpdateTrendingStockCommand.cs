using NewwaveDesignProject.Cores.MVVM.Commands;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Investments.Models;

namespace NewwaveDesignProject.Feartures.Investments.Commands
{
	public class UpdateTrendingStockCommand : IUpdateCommand<StockDTO>
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
			DataProvider.Instance.db.Stocks.Update(stock);
			await DataProvider.Instance.db.SaveChangesAsync();
		}
	}
	
}

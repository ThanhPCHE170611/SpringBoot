using NewwaveDesignProject.Cores.MVVM.Commands;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Investments.Models;

namespace NewwaveDesignProject.Feartures.Investments.Commands
{
	public class UpdateInvestmentCommand : IUpdateCommand<InvestmentDTO>
	{
		public async Task Execute(InvestmentDTO investmentDTO)
		{

			Investment investment = new Investment()
			{
				Id = investmentDTO.Id,
				CardId = investmentDTO.CardId,
				StockId = investmentDTO.StockId,
				Amount = Convert.ToDecimal(investmentDTO.Amount)

			};

			DataProvider.Instance.db.Investments.Update(investment);
			await DataProvider.Instance.db.SaveChangesAsync();

		}
	}
}

using NewwaveDesignProject.Cores.MVVM.Commands;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Accounts.Models;

namespace NewwaveDesignProject.Feartures.Accounts.Commands
{
	public class CreateTransactionCommand : ICreateCommand<TransactionDTO>
	{
		public async Task Execute(TransactionDTO transactionDTO)
		{
			
			var transaction = new Cores.MVVM.Models.Transaction()
			{
				Id = transactionDTO.Id,
				InvoiceId = transactionDTO.InvoiceId,
				Date = transactionDTO.Date,
				Description = transactionDTO.Description,
				Amount = Convert.ToDecimal(transactionDTO.Amount),
				Status = transactionDTO.Status,
				ImageType = transactionDTO.Image.ToString(),
				Type= transactionDTO.Category
			};

			DataProvider.Instance.db.Transactions.Add(transaction);
			await DataProvider.Instance.db.SaveChangesAsync();

		}
	}
}

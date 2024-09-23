using NewwaveDesignProject.Cores.MVVM.Commands;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Accounts.Models;

namespace NewwaveDesignProject.Feartures.Accounts.Commands
{
	public class UpdateTransactionCommand : IUpdateCommand<TransactionDTO>
	{
		public async Task Execute(TransactionDTO transactionDTO)
		{
			Cores.MVVM.Models.Transaction transaction = new Cores.MVVM.Models.Transaction()
			{
				Id = transactionDTO.Id,
				InvoiceId =transactionDTO.InvoiceId,
				Date = transactionDTO.Date,
				Description = transactionDTO.Description,
				Amount = Convert.ToDecimal(transactionDTO.Amount),
				Type = transactionDTO.Category,
				Status = transactionDTO.Status,
				ImageType = transactionDTO.Image.ToString(), 
			};

			DataProvider.Instance.db.Transactions.Update(transaction);
			await DataProvider.Instance.db.SaveChangesAsync();

		}
	}
}

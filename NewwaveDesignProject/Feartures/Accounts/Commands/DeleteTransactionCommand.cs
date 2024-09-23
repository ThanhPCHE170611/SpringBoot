using NewwaveDesignProject.Cores.MVVM.Commands;
using NewwaveDesignProject.Cores.MVVM.Utils;

namespace NewwaveDesignProject.Feartures.Accounts.Commands
{
	public class DeleteTransactionCommand : IDeleteCommand<int>
	{
		public async Task Execute(int id)
		{
			var transaction = DataProvider.Instance.db.Transactions.Find(id);
			if(transaction != null)
			{
				DataProvider.Instance.db.Transactions.Remove(transaction);
				await DataProvider.Instance.db.SaveChangesAsync();
			}
		}
	}
}

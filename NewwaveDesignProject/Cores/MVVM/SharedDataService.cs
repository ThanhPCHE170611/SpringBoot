namespace NewwaveDesignProject.Cores.MVVM
{
    public class SharedDataService : ViewModalBase
    {
        private string _currentHeader;
        public string CurrentHeader
        {
            get => _currentHeader;
            set
            {
                if (_currentHeader != value)
                {
                    _currentHeader = value;
                    ;
                }
            }
        }
    }
}

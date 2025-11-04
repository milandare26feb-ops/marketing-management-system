namespace MarketTrackAdmin.Services
{
    /// <summary>
    /// Monitoring Service - User activity monitoring
    /// </summary>
    public class MonitoringService
    {
        private readonly AppwriteService _appwriteService;

        public MonitoringService(AppwriteService appwriteService)
        {
            _appwriteService = appwriteService;
        }

        public async Task<List<object>> GetActiveUsers()
        {
            try
            {
                var users = await _appwriteService.GetApprovedUsers();
                return users.Documents.Cast<object>().ToList();
            }
            catch
            {
                return new List<object>();
            }
        }

        public async Task<List<object>> GetRecentAlerts()
        {
            try
            {
                var alerts = await _appwriteService.GetMonitoringAlerts();
                return alerts.Documents.Cast<object>().ToList();
            }
            catch
            {
                return new List<object>();
            }
        }
    }
}

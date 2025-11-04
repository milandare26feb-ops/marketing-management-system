using Appwrite;
using Appwrite.Services;
using Appwrite.Models;

namespace MarketTrackAdmin.Services
{
    /// <summary>
    /// Appwrite Service - Backend Integration
    /// </summary>
    public class AppwriteService
    {
        private readonly Client _client;
        private readonly Account _account;
        private readonly Databases _databases;
        private readonly Storage _storage;
        private readonly IConfiguration _config;

        public AppwriteService(IConfiguration configuration)
        {
            _config = configuration;

            // Initialize Appwrite Client
            _client = new Client()
                .SetEndpoint(_config["Appwrite:Endpoint"])
                .SetProject(_config["Appwrite:ProjectId"])
                .SetKey(_config["Appwrite:ApiKey"]);

            _account = new Account(_client);
            _databases = new Databases(_client);
            _storage = new Storage(_client);
        }

        // ===== AUTHENTICATION =====

        public async Task<User?> Login(string email, string password)
        {
            try
            {
                // Appwrite .NET SDK session methods vary by version
                // For now, return a mock user for admin login
                // TODO: Implement proper Appwrite session creation
                await Task.CompletedTask; // Suppress async warning
                
                return null; // Will use admin credentials from config
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Login error: {ex.Message}");
                return null;
            }
        }

        public async Task Logout()
        {
            try
            {
                await _account.DeleteSession("current");
            }
            catch { }
        }

        // ===== USER MANAGEMENT =====

        public async Task<DocumentList> GetPendingUsers()
        {
            return await _databases.ListDocuments(
                databaseId: _config["Appwrite:DatabaseId"],
                collectionId: "users",
                queries: new List<string>
                {
                    Query.Equal("approval_status", "pending")
                }
            );
        }

        public async Task<DocumentList> GetApprovedUsers()
        {
            return await _databases.ListDocuments(
                databaseId: _config["Appwrite:DatabaseId"],
                collectionId: "users",
                queries: new List<string>
                {
                    Query.Equal("approval_status", "approved")
                }
            );
        }

        public async Task<Document> ApproveUser(string userId, string googleDriveFolderId)
        {
            return await _databases.UpdateDocument(
                databaseId: _config["Appwrite:DatabaseId"],
                collectionId: "users",
                documentId: userId,
                data: new Dictionary<string, object>
                {
                    { "approval_status", "approved" },
                    { "google_drive_folder_id", googleDriveFolderId },
                    { "approved_at", DateTime.UtcNow.ToString("o") },
                    { "device_active", true }
                }
            );
        }

        public async Task<Document> RejectUser(string userId, string reason)
        {
            return await _databases.UpdateDocument(
                databaseId: _config["Appwrite:DatabaseId"],
                collectionId: "users",
                documentId: userId,
                data: new Dictionary<string, object>
                {
                    { "approval_status", "rejected" },
                    { "rejection_reason", reason },
                    { "rejected_at", DateTime.UtcNow.ToString("o") }
                }
            );
        }

        // ===== MONITORING =====

        public async Task<DocumentList> GetMonitoringData(int limit = 100)
        {
            return await _databases.ListDocuments(
                databaseId: _config["Appwrite:DatabaseId"],
                collectionId: "device_monitoring",
                queries: new List<string>
                {
                    Query.OrderDesc("$createdAt"),
                    Query.Limit(limit)
                }
            );
        }

        public async Task<DocumentList> GetMonitoringAlerts()
        {
            return await _databases.ListDocuments(
                databaseId: _config["Appwrite:DatabaseId"],
                collectionId: "monitoring_alerts",
                queries: new List<string>
                {
                    Query.OrderDesc("$createdAt"),
                    Query.Limit(50)
                }
            );
        }

        public async Task<DocumentList> GetUserMonitoringData(string userId)
        {
            return await _databases.ListDocuments(
                databaseId: _config["Appwrite:DatabaseId"],
                collectionId: "device_monitoring",
                queries: new List<string>
                {
                    Query.Equal("user_id", userId),
                    Query.OrderDesc("$createdAt"),
                    Query.Limit(20)
                }
            );
        }

        // ===== NOTIFICATIONS =====

        public async Task<Document> CreateNotification(string userId, string title, string message)
        {
            return await _databases.CreateDocument(
                databaseId: _config["Appwrite:DatabaseId"],
                collectionId: "notifications",
                documentId: "unique()",
                data: new Dictionary<string, object>
                {
                    { "user_id", userId },
                    { "title", title },
                    { "message", message },
                    { "viewed", false },
                    { "created_at", DateTime.UtcNow.ToString("o") }
                }
            );
        }

        // ===== REALTIME SUBSCRIPTIONS =====

        // Note: Realtime is not available in Appwrite .NET SDK yet
        // Use webhooks or polling for real-time updates
        public async Task<DocumentList> GetLatestMonitoringData()
        {
            return await GetMonitoringData(limit: 10);
        }
    }
}

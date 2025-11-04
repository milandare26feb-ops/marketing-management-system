using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MarketTrackAdmin.Services;

namespace MarketTrackAdmin.Controllers
{
    [Authorize]
    public class DashboardController : Controller
    {
        private readonly AppwriteService _appwriteService;

        public DashboardController(AppwriteService appwriteService)
        {
            _appwriteService = appwriteService;
        }

        public async Task<IActionResult> Index()
        {
            try
            {
                // Get statistics
                var pendingUsers = await _appwriteService.GetPendingUsers();
                var approvedUsers = await _appwriteService.GetApprovedUsers();
                var alerts = await _appwriteService.GetMonitoringAlerts();

                ViewBag.PendingCount = pendingUsers.Total;
                ViewBag.ApprovedCount = approvedUsers.Total;
                ViewBag.AlertCount = alerts.Total;

                return View();
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }

        public async Task<IActionResult> Monitoring()
        {
            try
            {
                var monitoringData = await _appwriteService.GetMonitoringData(limit: 100);
                return View(monitoringData.Documents);
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }

        public async Task<IActionResult> Alerts()
        {
            try
            {
                var alerts = await _appwriteService.GetMonitoringAlerts();
                return View(alerts.Documents);
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }
    }
}

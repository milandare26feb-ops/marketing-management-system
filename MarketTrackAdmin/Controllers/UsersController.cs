using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MarketTrackAdmin.Services;

namespace MarketTrackAdmin.Controllers
{
    [Authorize]
    public class UsersController : Controller
    {
        private readonly AppwriteService _appwriteService;

        public UsersController(AppwriteService appwriteService)
        {
            _appwriteService = appwriteService;
        }

        // GET: /Users/Pending
        public async Task<IActionResult> Pending()
        {
            try
            {
                var users = await _appwriteService.GetPendingUsers();
                return View(users.Documents);
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }

        // GET: /Users/Approved
        public async Task<IActionResult> Approved()
        {
            try
            {
                var users = await _appwriteService.GetApprovedUsers();
                return View(users.Documents);
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }

        // POST: /Users/Approve
        [HttpPost]
        public async Task<IActionResult> Approve(string userId, string userName)
        {
            try
            {
                // 1. Update user status in Appwrite (no Google Drive folder needed)
                await _appwriteService.ApproveUser(userId, "");

                // 2. Send notification to user
                await _appwriteService.CreateNotification(
                    userId,
                    "অ্যাকাউন্ট অনুমোদিত ✅",
                    "আপনার অ্যাকাউন্ট অনুমোদিত হয়েছে। এখন আপনি অ্যাপ ব্যবহার করতে পারবেন।"
                );

                TempData["Success"] = $"ব্যবহারকারী '{userName}' অনুমোদিত হয়েছে ✅";
                return RedirectToAction("Pending");
            }
            catch (Exception ex)
            {
                TempData["Error"] = $"ত্রুটি: {ex.Message}";
                return RedirectToAction("Pending");
            }
        }

        // POST: /Users/Reject
        [HttpPost]
        public async Task<IActionResult> Reject(string userId, string userName, string reason)
        {
            try
            {
                // 1. Update user status
                await _appwriteService.RejectUser(userId, reason);

                // 2. Send notification
                await _appwriteService.CreateNotification(
                    userId,
                    "অ্যাকাউন্ট প্রত্যাখ্যাত ❌",
                    $"কারণ: {reason}"
                );

                TempData["Success"] = $"ব্যবহারকারী '{userName}' প্রত্যাখ্যাত হয়েছে";
                return RedirectToAction("Pending");
            }
            catch (Exception ex)
            {
                TempData["Error"] = $"ত্রুটি: {ex.Message}";
                return RedirectToAction("Pending");
            }
        }

        // GET: /Users/Details/{id}
        public async Task<IActionResult> Details(string id)
        {
            try
            {
                var monitoringData = await _appwriteService.GetUserMonitoringData(id);
                ViewBag.UserId = id;
                return View(monitoringData.Documents);
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }
    }
}

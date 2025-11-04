using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using MarketTrackAdmin.Services;

namespace MarketTrackAdmin.Controllers
{
    public class AuthController : Controller
    {
        private readonly AppwriteService _appwriteService;
        private readonly IConfiguration _config;

        public AuthController(AppwriteService appwriteService, IConfiguration configuration)
        {
            _appwriteService = appwriteService;
            _config = configuration;
        }

        [HttpGet]
        public IActionResult Login()
        {
            // Check if already logged in
            if (User.Identity?.IsAuthenticated ?? false)
            {
                return RedirectToAction("Index", "Dashboard");
            }

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(string email, string password)
        {
            try
            {
                // Check against main admin credentials
                var adminEmail = _config["AdminCredentials:Email"];
                var adminPassword = _config["AdminCredentials:Password"];

                if (email == adminEmail && password == adminPassword)
                {
                    // Create claims
                    var claims = new List<Claim>
                    {
                        new Claim(ClaimTypes.Email, email),
                        new Claim(ClaimTypes.Name, _config["AdminCredentials:Name"]),
                        new Claim(ClaimTypes.Role, "Admin")
                    };

                    var claimsIdentity = new ClaimsIdentity(claims, "AdminAuth");
                    var authProperties = new AuthenticationProperties
                    {
                        IsPersistent = true,
                        ExpiresUtc = DateTimeOffset.UtcNow.AddDays(7)
                    };

                    await HttpContext.SignInAsync(
                        "AdminAuth",
                        new ClaimsPrincipal(claimsIdentity),
                        authProperties
                    );

                    return RedirectToAction("Index", "Dashboard");
                }
                else
                {
                    // Try Appwrite login
                    var user = await _appwriteService.Login(email, password);
                    if (user != null)
                    {
                        var claims = new List<Claim>
                        {
                            new Claim(ClaimTypes.Email, user.Email),
                            new Claim(ClaimTypes.Name, user.Name),
                            new Claim("UserId", user.Id)
                        };

                        var claimsIdentity = new ClaimsIdentity(claims, "AdminAuth");
                        await HttpContext.SignInAsync(
                            "AdminAuth",
                            new ClaimsPrincipal(claimsIdentity),
                            new AuthenticationProperties { IsPersistent = true }
                        );

                        return RedirectToAction("Index", "Dashboard");
                    }
                }

                ViewBag.Error = "ইমেইল বা পাসওয়ার্ড ভুল";
                return View();
            }
            catch (Exception ex)
            {
                ViewBag.Error = $"লগইন ত্রুটি: {ex.Message}";
                return View();
            }
        }

        [HttpPost]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync("AdminAuth");
            await _appwriteService.Logout();
            return RedirectToAction("Login");
        }
    }
}

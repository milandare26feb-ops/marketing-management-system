# 🎯 ASP.NET Core 8 MVC Admin Panel - Complete Setup Guide

## 📋 Overview
এই গাইড আপনাকে **ASP.NET Core 8 MVC** দিয়ে **MarketTrack Admin Panel** তৈরি করতে সাহায্য করবে।

**Features:**
- ✅ ASP.NET Core 8 MVC
- ✅ Bootstrap 5 (Dark/Light Theme)
- ✅ Appwrite Backend Integration
- ✅ Google Drive API Integration
- ✅ User Approval System
- ✅ Real-time Monitoring Dashboard
- ✅ Bengali + English UI
- ✅ Responsive Design

---

## 🛠️ Prerequisites

### Required Software:
```bash
# 1. .NET 8 SDK
https://dotnet.microsoft.com/download/dotnet/8.0

# 2. Visual Studio 2022 / VS Code
https://visualstudio.microsoft.com/

# 3. PostgreSQL (optional, if using PostgreSQL)
https://www.postgresql.org/download/

# 4. Node.js (for npm packages)
https://nodejs.org/
```

### Check Installation:
```powershell
dotnet --version  # Should show 8.0.x
node --version    # Should show v18+
```

---

## 📁 Step 1: Create ASP.NET Core MVC Project

### Option A: Using Visual Studio 2022
1. Open Visual Studio 2022
2. Click "Create a new project"
3. Select "ASP.NET Core Web App (Model-View-Controller)"
4. Name: `MarketTrackAdmin`
5. Framework: `.NET 8.0`
6. Authentication: `None` (আমরা Appwrite ব্যবহার করব)
7. Click "Create"

### Option B: Using CLI (PowerShell)
```powershell
# Navigate to project directory
cd D:\MARKET_MANAGEMENT

# Create new MVC project
dotnet new mvc -n MarketTrackAdmin -f net8.0

# Navigate into project
cd MarketTrackAdmin

# Open in VS Code
code .
```

---

## 📦 Step 2: Install Required NuGet Packages

```powershell
# Navigate to project directory
cd D:\MARKET_MANAGEMENT\MarketTrackAdmin

# Appwrite SDK
dotnet add package Appwrite --version 0.7.0

# Google Drive API
dotnet add package Google.Apis.Drive.v3 --version 1.64.0.3095
dotnet add package Google.Apis.Auth --version 1.64.0

# Session & Authentication
dotnet add package Microsoft.AspNetCore.Session
dotnet add package Microsoft.AspNetCore.Authentication.Cookies

# JSON & HTTP
dotnet add package Newtonsoft.Json --version 13.0.3

# Localization (for Bengali)
dotnet add package Microsoft.Extensions.Localization
```

### Verify Installation:
```powershell
dotnet restore
dotnet build
```

---

## 🗂️ Step 3: Project Structure

```
MarketTrackAdmin/
├── Controllers/
│   ├── HomeController.cs
│   ├── AuthController.cs
│   ├── UsersController.cs
│   ├── DashboardController.cs
│   └── MonitoringController.cs
├── Models/
│   ├── User.cs
│   ├── MonitoringData.cs
│   ├── LoginViewModel.cs
│   └── UserApprovalViewModel.cs
├── Services/
│   ├── AppwriteService.cs
│   ├── GoogleDriveService.cs
│   └── MonitoringService.cs
├── Views/
│   ├── Shared/
│   │   ├── _Layout.cshtml
│   │   └── _LoginLayout.cshtml
│   ├── Home/
│   │   └── Index.cshtml
│   ├── Dashboard/
│   │   ├── Index.cshtml
│   │   └── Monitoring.cshtml
│   └── Users/
│       ├── Pending.cshtml
│       └── Approved.cshtml
├── wwwroot/
│   ├── css/
│   │   ├── site.css
│   │   └── dark-theme.css
│   ├── js/
│   │   └── site.js
│   └── lib/
├── appsettings.json
└── Program.cs
```

আমি এখন সব files create করব...


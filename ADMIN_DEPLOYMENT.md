# MarketTrack Admin Panel - Deployment Guide

## ⚠️ Important: Appwrite Deployment Domain

The Appwrite deployment domain `https://marketm-anagement.appwrite.network/` is **ONLY** for Appwrite Functions, not for hosting ASP.NET Core applications.

## 🚀 Deployment Options for Admin Panel

### Option 1: Local Development (Recommended for Testing)
```bash
cd D:\MARKET_MANAGEMENT\MarketTrackAdmin
dotnet run --urls "http://localhost:5000"
```
Access at: http://localhost:5000

### Option 2: Cloud Hosting Services

#### A. **Render.com** (Free Tier Available)
1. Create account at https://render.com
2. Connect GitHub repository
3. Create new Web Service
4. Configure:
   - **Build Command**: `cd MarketTrackAdmin && dotnet publish -c Release -o out`
   - **Start Command**: `cd MarketTrackAdmin/out && dotnet MarketTrackAdmin.dll`
   - **Environment**: .NET

#### B. **Railway.app** (Free $5 credit)
1. Create account at https://railway.app
2. New Project → Deploy from GitHub
3. Select repository: `marketing-management-system`
4. Configure:
   - **Root Directory**: `MarketTrackAdmin`
   - **Build Command**: `dotnet publish -c Release -o out`
   - **Start Command**: `dotnet out/MarketTrackAdmin.dll`

#### C. **Fly.io** (Free tier available)
```bash
# Install flyctl
powershell -Command "iwr https://fly.io/install.ps1 -useb | iex"

# Login
fly auth login

# Deploy
cd D:\MARKET_MANAGEMENT\MarketTrackAdmin
fly launch
fly deploy
```

#### D. **Azure App Service** (Paid - Best for production)
```bash
# Install Azure CLI
# Deploy
az webapp up --name markettrack-admin --runtime "DOTNETCORE:9.0"
```

### Option 3: Containerized Deployment (Docker)

Create `Dockerfile` in MarketTrackAdmin folder:
```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["MarketTrackAdmin.csproj", "."]
RUN dotnet restore
COPY . .
RUN dotnet build -c Release -o /app/build

FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MarketTrackAdmin.dll"]
```

Deploy to:
- Docker Hub
- Google Cloud Run
- AWS ECS
- Azure Container Instances

### Option 4: Expose Local with Tunnel (Quick Testing)

#### Using ngrok (Free):
```bash
# Install ngrok from https://ngrok.com/download

# Start admin panel
cd D:\MARKET_MANAGEMENT\MarketTrackAdmin
dotnet run --urls "http://localhost:5000"

# In another terminal, expose it
ngrok http 5000
# Copy the ngrok URL (e.g., https://abc123.ngrok.io)
```

#### Using Cloudflare Tunnel (Free):
```bash
# Install cloudflared
# Download from: https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation/

# Start tunnel
cloudflared tunnel --url http://localhost:5000
```

## 📝 Configuration for Public Access

### Update appsettings.json for production:
```json
{
  "AllowedHosts": "*",
  "Appwrite": {
    "Endpoint": "https://sgp.cloud.appwrite.io/v1",
    "ProjectId": "690911f10028fa64956b",
    "ApiKey": "standard_57c934ee8bf3f80f6aaf1c6db2ed7e5c935b3400309426f01a48780b18668040bbcc20b98219f11751a1eeaed98bea8bb5acd9724b3700fb65a09265f5da8fb16de36afab300f6abf55076ce68b7c63003c70fe8f1b842ab49cd805f11418ae9e238dd3211083dd371b347a29c9c5620206cf68bc185122df393a0bab4fe2008",
    "DatabaseId": "markettrack_db"
  }
}
```

### Update Program.cs for CORS (if needed):
```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        policy => policy
            .AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader());
});

// After app is built
app.UseCors("AllowAll");
```

## 🎯 Recommended Approach

**For Development/Testing:**
- Use Local + ngrok/cloudflare tunnel
- Quick and free
- Easy to debug

**For Production:**
- Use **Render.com** or **Railway.app** (easiest)
- Or **Azure App Service** (enterprise-grade)
- Proper SSL, monitoring, scaling

## 🔐 Security Notes

1. **Change default admin password** after first deployment
2. **Enable HTTPS** (automatic on most platforms)
3. **Set up firewall rules** (if self-hosting)
4. **Use environment variables** for secrets (not appsettings.json in production)
5. **Enable authentication logs**

## 📊 Current Status

- ✅ Admin panel built: `deploy/admin/`
- ✅ Appwrite backend configured
- ✅ Database & Storage ready
- ⏳ Need to choose hosting platform
- ⏳ Deploy admin panel

## 🚀 Quick Start (Development)

```powershell
# Terminal 1: Start admin panel
cd D:\MARKET_MANAGEMENT\MarketTrackAdmin
dotnet run --urls "http://localhost:5000"

# Terminal 2: Expose publicly (ngrok)
ngrok http 5000
```

Access your admin panel at the ngrok URL!

## 📞 Support

For deployment issues:
1. Check hosting platform documentation
2. Verify Appwrite connectivity
3. Check application logs
4. Ensure correct PORT configuration

---

**Note**: The Appwrite deployment domain is for Appwrite's internal services only. Your admin panel needs separate hosting.

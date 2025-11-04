# 🚀 MarketTrack - Complete Setup & Deployment Guide

## 📋 Table of Contents
1. [Admin Panel Setup (ASP.NET Core)](#admin-panel-setup)
2. [Google Drive Integration](#google-drive-integration)
3. [Appwrite Database Setup](#appwrite-database-setup)
4. [Mobile App Build (Android APK)](#android-apk-build)
5. [Mobile App Build (iOS IPA)](#ios-ipa-build)
6. [Deployment Guide](#deployment-guide)
7. [Troubleshooting](#troubleshooting)

---

## ✅ Admin Panel Setup (COMPLETED)

### Current Status:
- ✅ ASP.NET Core 9.0 project created
- ✅ NuGet packages installed (Appwrite, Google Drive API)
- ✅ Build successful
- ✅ Running on http://localhost:5000
- ✅ Login page created (kawsarHossain31de@gmail.com / 12345678)
- ✅ Dashboard created
- ✅ User approval system created

### Test Login:
```bash
# Open browser
http://localhost:5000

# Login credentials:
Email: kawsarHossain31de@gmail.com
Password: 12345678
```

---

## 🔐 Google Drive Integration Setup

### Step 1: Create Google Cloud Project

1. **Go to Google Cloud Console:**
   ```
   https://console.cloud.google.com/
   ```

2. **Create New Project:**
   - Click "Select a project" → "New Project"
   - Project Name: `MarketTrack Backend`
   - Click "Create"

3. **Enable Google Drive API:**
   ```bash
   # Navigate to:
   APIs & Services → Library → Search "Google Drive API" → Enable
   ```

### Step 2: Create Service Account

1. **Go to Service Accounts:**
   ```
   APIs & Services → Credentials → Create Credentials → Service Account
   ```

2. **Fill Details:**
   - Service account name: `markettrack-drive-service`
   - Service account ID: `markettrack-drive`
   - Description: `MarketTrack Google Drive Access`
   - Click "Create and Continue"

3. **Grant Permissions:**
   - Role: `Editor`
   - Click "Continue" → "Done"

### Step 3: Create Service Account Key

1. **Click on created service account**
2. **Go to "Keys" tab**
3. **Add Key → Create new key**
4. **Key type: JSON**
5. **Click "Create"** (downloads `credentials.json`)

### Step 4: Configure Admin Panel

```bash
# Copy credentials.json to project root
cp ~/Downloads/credentials.json D:\MARKET_MANAGEMENT\MarketTrackAdmin\

# Update appsettings.json
```

Edit `appsettings.json`:
```json
{
  "GoogleDrive": {
    "ServiceAccountFile": "credentials.json",
    "ApplicationName": "MarketTrack Admin"
  }
}
```

### Step 5: Update GoogleDriveService.cs

Replace `GetCredential()` method:
```csharp
private GoogleCredential GetCredential()
{
    var serviceAccountFile = Path.Combine(
        Directory.GetCurrentDirectory(), 
        _config["GoogleDrive:ServiceAccountFile"]
    );
    
    return GoogleCredential.FromFile(serviceAccountFile)
        .CreateScoped(DriveService.ScopeConstants.Drive);
}
```

---

## 📊 Appwrite Database Setup

### Collections to Create:

#### 1. Users Collection

```bash
# Run in Appwrite Console
Collection Name: users
Collection ID: users
```

**Attributes:**
| Name | Type | Size | Required | Default |
|------|------|------|----------|---------|
| name | String | 255 | Yes | - |
| email | String | 255 | Yes | - |
| phone | String | 20 | Yes | - |
| address | String | 500 | Yes | - |
| home_latitude | Float | - | No | null |
| home_longitude | Float | - | No | null |
| home_set_at | DateTime | - | No | null |
| nid_url | String | 500 | No | null |
| approval_status | String | 50 | Yes | pending |
| google_drive_folder_id | String | 255 | No | null |
| fcm_token | String | 500 | No | null |
| last_seen | DateTime | - | No | null |
| device_active | Boolean | - | Yes | false |

**Indexes:**
- email (unique)
- approval_status
- last_seen

#### 2. Device Monitoring Collection

```bash
Collection Name: device_monitoring
Collection ID: device_monitoring
```

**Attributes:**
| Name | Type | Required |
|------|------|----------|
| user_id | String | Yes |
| timestamp | DateTime | Yes |
| battery_level | Integer | No |
| battery_state | String | No |
| gps_enabled | Boolean | No |
| latitude | Float | No |
| longitude | Float | No |
| network_type | String | No |
| is_vpn | Boolean | No |
| device_platform | String | No |

#### 3. Monitoring Alerts Collection

```bash
Collection Name: monitoring_alerts
Collection ID: monitoring_alerts
```

**Attributes:**
| Name | Type | Required |
|------|------|----------|
| user_id | String | Yes |
| severity | String | Yes |
| alerts | String[] | Yes |
| timestamp | DateTime | Yes |

#### 4. Notifications Collection

```bash
Collection Name: notifications
Collection ID: notifications
```

**Attributes:**
| Name | Type | Required |
|------|------|----------|
| user_id | String | Yes |
| title | String | Yes |
| message | String | Yes |
| viewed | Boolean | Yes |
| viewed_at | DateTime | No |
| created_at | DateTime | Yes |

### Storage Buckets:

```bash
# Create these buckets in Appwrite Storage

1. nid_cards
   - Max file size: 10MB
   - Allowed extensions: jpg, jpeg, png
   - Encryption: Yes

2. profile_videos
   - Max file size: 50MB
   - Allowed extensions: mp4, mov
   - Encryption: Yes

3. check_in_selfies
   - Max file size: 5MB
   - Allowed extensions: jpg, jpeg, png
   - Encryption: No

4. reports
   - Max file size: 20MB
   - Allowed extensions: pdf, jpg, png
   - Encryption: Yes

5. audio_notes
   - Max file size: 10MB
   - Allowed extensions: mp3, m4a, wav
   - Encryption: Yes
```

---

## 📱 Android APK Build Guide

### Prerequisites:
```powershell
# Install Flutter SDK
# Already installed at: C:\src\flutter

# Check Flutter
flutter doctor

# Install Android Studio
# Download from: https://developer.android.com/studio
```

### Step 1: Create Keystore

```powershell
# Navigate to mobile app
cd D:\MARKET_MANAGEMENT\mobile_app

# Create keystore (Run in PowerShell)
keytool -genkey -v -keystore markettrack-release-key.jks `
  -keyalg RSA -keysize 2048 -validity 10000 `
  -alias markettrack

# You will be asked:
# Password: [CREATE STRONG PASSWORD]
# First and Last Name: MarketTrack
# Organizational Unit: Development
# Organization: Confidence Feed
# City: Dhaka
# State: Dhaka
# Country Code: BD
```

### Step 2: Create key.properties

```powershell
# Create file: android/key.properties
New-Item -Path "android" -Name "key.properties" -ItemType "file"
```

Edit `android/key.properties`:
```properties
storePassword=[YOUR_KEYSTORE_PASSWORD]
keyPassword=[YOUR_KEY_PASSWORD]
keyAlias=markettrack
storeFile=../markettrack-release-key.jks
```

### Step 3: Configure build.gradle

Edit `android/app/build.gradle`:

```gradle
// Add before android { }
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    // ... existing config

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

### Step 4: Build APK

```powershell
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Build APK (Release)
flutter build apk --release

# Build APK (Split by ABI for smaller size)
flutter build apk --split-per-abi --release

# APK location:
# build/app/outputs/flutter-apk/app-release.apk
```

### Step 5: Test APK

```powershell
# Install on connected device
flutter install

# Or manually:
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## 🍎 iOS IPA Build Guide

### Prerequisites:
```bash
# Required:
# - Mac computer
# - Xcode (from App Store)
# - Apple Developer Account ($99/year)
```

### Step 1: Apple Developer Setup

1. **Join Apple Developer Program:**
   ```
   https://developer.apple.com/programs/
   ```

2. **Create App ID:**
   - Go to Certificates, IDs & Profiles
   - Identifiers → Register an App ID
   - Description: MarketTrack
   - Bundle ID: com.confidencefeed.markettrack
   - Capabilities: Push Notifications, Background Modes

### Step 2: Create Certificates

1. **Development Certificate:**
   - Certificates → + → iOS Development
   - Generate CSR from Keychain Access
   - Download & Install

2. **Distribution Certificate:**
   - Certificates → + → iOS Distribution
   - Generate CSR from Keychain Access
   - Download & Install

### Step 3: Create Provisioning Profiles

1. **Development Profile:**
   - Provisioning Profiles → + → iOS App Development
   - Select App ID → Select Certificate → Select Devices
   - Download & Install

2. **Distribution Profile:**
   - Provisioning Profiles → + → App Store
   - Select App ID → Select Certificate
   - Download & Install

### Step 4: Configure Xcode

```bash
# Open iOS project
open ios/Runner.xcworkspace

# In Xcode:
# 1. Select Runner → Signing & Capabilities
# 2. Team: Select your Apple Developer team
# 3. Bundle Identifier: com.confidencefeed.markettrack
# 4. Automatically manage signing: Checked
```

### Step 5: Build IPA

```bash
# Clean
flutter clean
flutter pub get

# Build for iOS
flutter build ios --release

# Archive in Xcode:
# Product → Archive

# Upload to App Store Connect:
# Window → Organizer → Distribute App
```

---

## 🚀 Deployment Guide

### Admin Panel Deployment (Render.com)

#### Step 1: Prepare for Deployment

1. **Add Dockerfile:**

Create `Dockerfile`:
```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["MarketTrackAdmin.csproj", "./"]
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

#### Step 2: Deploy to Render

1. **Push to GitHub:**
   ```powershell
   cd D:\MARKET_MANAGEMENT\MarketTrackAdmin
   git init
   git add .
   git commit -m "Initial admin panel"
   git remote add origin [YOUR_GITHUB_REPO]
   git push -u origin main
   ```

2. **Create Render Account:**
   ```
   https://render.com/
   ```

3. **New Web Service:**
   - Connect GitHub repository
   - Name: markettrack-admin
   - Environment: Docker
   - Instance Type: Free (or Starter $7/month)

4. **Environment Variables:**
   ```
   Appwrite__Endpoint=https://sgp.cloud.appwrite.io/v1
   Appwrite__ProjectId=690911f10028fa64956b
   Appwrite__ApiKey=[YOUR_APPWRITE_API_KEY]
   Appwrite__DatabaseId=markettrack_db
   ```

5. **Deploy!**

#### Step 3: Custom Domain

1. **Go to Render Dashboard → Settings**
2. **Custom Domain:** `admin.confidencefeed.c0m.in`
3. **Add CNAME record in your domain DNS:**
   ```
   Type: CNAME
   Name: admin
   Value: markettrack-admin.onrender.com
   ```

---

## 🛠️ Troubleshooting

### Common Issues:

#### 1. Admin Panel won't start
```powershell
# Check .NET SDK
dotnet --version

# Restore packages
dotnet restore

# Clean and rebuild
dotnet clean
dotnet build
```

#### 2. Google Drive API errors
```
# Verify credentials.json exists
# Check service account permissions
# Ensure Drive API is enabled
```

#### 3. Appwrite connection fails
```
# Verify endpoint URL
# Check API key validity
# Ensure collections exist
```

#### 4. APK build fails
```powershell
# Clean Flutter
flutter clean
flutter pub get

# Check Java version
java -version  # Should be 11 or higher

# Update Flutter
flutter upgrade
```

---

## ✅ Setup Checklist

- [ ] Admin panel running locally
- [ ] Google Drive service account created
- [ ] Appwrite collections created
- [ ] Storage buckets configured
- [ ] Android keystore generated
- [ ] APK built successfully
- [ ] Admin panel deployed to Render
- [ ] Custom domain configured
- [ ] Mobile app tested on device

---

## 📞 Support

**Email:** kawsarHossain31de@gmail.com  
**Domain:** admin.confidencefeed.c0m.in

---

**Last Updated:** November 4, 2025  
**Version:** 1.0.0

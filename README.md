# 🚀 MarketTrack - Complete Marketing Management System

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)]()
[![License](https://img.shields.io/badge/license-MIT-blue)]()
[![Flutter](https://img.shields.io/badge/Flutter-3.35.7-02569B?logo=flutter)]()
[![.NET](https://img.shields.io/badge/.NET-9.0-512BD4?logo=dotnet)]()
[![Appwrite](https://img.shields.io/badge/Appwrite-Backend-F02E65?logo=appwrite)]()

**Complete enterprise-level field force tracking system** with Flutter mobile app and ASP.NET Core admin panel, powered by Appwrite backend.

---

## 📱 Mobile App Features

### 🔐 Authentication & Security
- ✅ Email/Password registration with verification
- ✅ Permission lock (once granted, cannot be revoked)
- ✅ VPN & Root detection with blocking
- ✅ Secure session management

### 📸 Camera System (CRITICAL FEATURE)
- ✅ **NO gallery access** - Camera opens directly
- ✅ **Real-time data overlay** on camera screen:
  - 👤 User name (live display)
  - ⏰ Current date & time (updates every second)
  - 📍 GPS coordinates (latitude, longitude)
- ✅ Face detection for selfie validation
- ✅ NID card capture & validation
- ✅ Auto-upload to Appwrite Storage

### 📍 Advanced Location Tracking
- ✅ **3 AM Home Detection** (3 consecutive days)
- ✅ 50-meter radius home validation
- ✅ Real-time GPS monitoring
- ✅ **Fake Check-in Prevention:**
  - Distance & movement pattern validation
  - Time-based checks
  - VPN/Proxy detection
  - Location history analysis

### 📊 Device Monitoring (Every 5 Minutes)
- ✅ Battery level & charging status
- ✅ GPS enabled/disabled detection
- ✅ Network type (WiFi/Mobile/VPN)
- ✅ Device platform & model info
- ✅ Current location tracking
- ✅ **Auto-alert generation:**
  - GPS disabled → High priority
  - Low battery → Medium priority
  - VPN detected → Critical alert

### 🔔 Notifications & Alerts
- ✅ Firebase Cloud Messaging (FCM)
- ✅ Push notifications for:
  - Approval/rejection status
  - Admin messages
  - Critical system alerts
- ✅ **App uninstall detection:**
  - FCM token tracking
  - 30-minute heartbeat monitoring
  - Inactive user detection

### 📦 Offline Support
- ✅ Hive local database
- ✅ Offline data storage
- ✅ Auto-sync when online

---

## 💻 Admin Panel Features

### 🎨 Modern UI
- ✅ Bootstrap 5 dark theme
- ✅ Responsive design (mobile-friendly)
- ✅ Bangla & English support
- ✅ Real-time statistics dashboard

### 🔐 Authentication
- ✅ Secure admin login
- ✅ Session management
- ✅ Default credentials:
  - Email: `kawsarHossain31de@gmail.com`
  - Password: `12345678`

### 👥 User Management
- ✅ Pending users list with:
  - Name, email, phone
  - NID card viewer
  - Registration date
  - Approval status
- ✅ One-click approval/rejection
- ✅ Automatic Appwrite folder creation

### 📊 Dashboard
- ✅ Real-time statistics:
  - Total users
  - Pending approvals
  - Active devices
  - Critical alerts count
- ✅ Recent activities feed
- ✅ Device monitoring overview
- ✅ Alert summary by severity

### 🚨 Monitoring & Alerts
- ✅ Real-time device status
- ✅ GPS tracking visualization
- ✅ Battery & network monitoring
- ✅ Alert management system
- ✅ User activity logs

---

## 🗄️ Backend Architecture

### Appwrite Cloud (Singapore Region)
- **Endpoint**: `https://sgp.cloud.appwrite.io/v1`
- **Project ID**: `690911f10028fa64956b`
- **Database**: `markettrack_db`
- **Deployment Domain**: `https://marketm-anagement.appwrite.network/`

### Database Collections

#### 1. **users** Collection
```
- name (string, 255)
- email (email, unique)
- phone (string, 20)
- address (string, 500)
- home_latitude (double)
- home_longitude (double)
- home_set_at (datetime)
- nid_url (string, 500)
- approval_status (enum: pending/approved/rejected)
- fcm_token (string, 500)
- last_seen (datetime)
- device_active (boolean)
```

#### 2. **device_monitoring** Collection
```
- user_id (string, 255)
- timestamp (datetime)
- battery_level (integer)
- battery_state (string, 50)
- gps_enabled (boolean)
- latitude (double)
- longitude (double)
- network_type (string, 50)
- is_vpn (boolean)
- device_platform (string, 50)
```

#### 3. **monitoring_alerts** Collection
```
- user_id (string, 255)
- alert_type (string, 100)
- message (string, 1000)
- severity (enum: low/medium/high/critical)
- timestamp (datetime)
- is_resolved (boolean)
```

#### 4. **notifications** Collection
```
- user_id (string, 255)
- title (string, 255)
- message (string, 1000)
- type (string, 50)
- is_read (boolean)
- created_at (datetime)
```

### Storage Buckets

1. **nid_cards** - NID card images (100MB max)
2. **profile_videos** - User profile videos (100MB max)
3. **check_in_selfies** - Daily check-in selfies with overlay (10MB max)
4. **reports** - PDF/Image reports (50MB max)
5. **audio_notes** - Voice notes (50MB max)

---

## 🛠️ Technology Stack

### Mobile App
```yaml
Framework: Flutter 3.35.7
Language: Dart
Backend: Appwrite SDK 12.0.3
Maps: Flutter Map (OpenStreetMap)
Camera: Camera plugin (gallery disabled)
Location: Geolocator 11.0.0
Notifications: Firebase Messaging 14.9.4
Local Storage: Hive 2.2.3
State Management: Provider 6.1.1
```

### Admin Panel
```csharp
Framework: ASP.NET Core 9.0
Language: C# 12.0
UI: Bootstrap 5.3 (dark theme)
Backend: Appwrite .NET SDK 0.7.0
Authentication: ASP.NET Core Identity
```

### Backend
```
BaaS: Appwrite (Cloud - Singapore)
Storage: Appwrite Storage (5 buckets)
Database: Appwrite Database (4 collections)
Push Notifications: Firebase Cloud Messaging
```

---

## 📂 Project Structure

```
MARKET_MANAGEMENT/
├── mobile_app/              # Flutter Mobile Application
│   ├── lib/
│   │   ├── core/           # Core services
│   │   ├── features/       # UI screens
│   │   ├── services/       # Business logic
│   │   └── widgets/        # Reusable components
│   └── android/           # Android configuration
│
├── MarketTrackAdmin/      # ASP.NET Core Admin Panel
│   ├── Controllers/       # MVC Controllers
│   ├── Services/          # Business services
│   ├── Views/            # Razor views
│   └── wwwroot/          # Static assets
│
├── deploy/               # Production builds
│   └── admin/           # Admin panel build
│
├── appwrite.json        # Appwrite configuration
├── deploy.ps1          # Windows deployment script
└── deploy.sh           # Linux/Mac deployment script
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.35.7 or higher
- .NET SDK 9.0 or higher
- Appwrite account
- Firebase project (for FCM)
- Android Studio (for APK builds)

### 1. Clone Repository
```bash
git clone https://github.com/milandare26feb-ops/marketing-management-system.git
cd marketing-management-system
```

### 2. Setup Mobile App
```bash
cd mobile_app
flutter pub get
flutter run
```

### 3. Setup Admin Panel
```bash
cd MarketTrackAdmin
dotnet restore
dotnet run
```

### 4. Configure Appwrite
- Update `appwrite.json` with your credentials
- Run database setup:
```bash
cd AppwriteSetup
dotnet run
```

---

## 📦 Building for Production

### Build Mobile APK
```bash
cd mobile_app
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Build Admin Panel
```bash
cd MarketTrackAdmin
dotnet publish -c Release -o ../deploy/admin
```

### Deploy Everything
```powershell
# Windows
.\deploy.ps1

# Linux/Mac
./deploy.sh
```

---

## 🔑 Default Credentials

### Admin Panel
- **Email**: `kawsarHossain31de@gmail.com`
- **Password**: `12345678`

### Appwrite Console
- **Endpoint**: `https://sgp.cloud.appwrite.io/v1`
- **Project ID**: `690911f10028fa64956b`

---

## 📸 Screenshots

### Mobile App
- 📱 Camera with real-time overlay (Name + Time + GPS)
- 🏠 Home screen with check-in button
- 📍 Map view with location tracking
- 🔔 Notifications & alerts

### Admin Panel
- 📊 Dashboard with statistics
- 👥 User approval interface
- 🚨 Monitoring & alerts
- 📈 Activity charts

---

## 🔒 Security Features

### Mobile App
- ✅ No gallery access (camera-only)
- ✅ VPN detection & blocking
- ✅ Root detection & blocking
- ✅ Permission enforcement
- ✅ Fake check-in prevention
- ✅ Encrypted local storage

### Admin Panel
- ✅ Session-based authentication
- ✅ Secure API integration
- ✅ Role-based access control
- ✅ Audit logging

---

## 📝 Documentation

- [Complete Deployment Guide](COMPLETE_DEPLOYMENT_GUIDE.md)
- [Admin Panel Setup](ADMIN_PANEL_COMPLETE_GUIDE.md)
- [Project Summary](PROJECT_SUMMARY.md)
- [Requirements Specification](COMPLETE_REQUIREMENTS.md)
- [Feature Comparison](MOBILE_VS_ADMIN_FEATURES.md)

---

## 🐛 Known Issues

1. ⚠️ Gradle version warnings (non-critical)
2. ⚠️ Null reference warnings in C# (non-critical)
3. ✅ All build errors fixed
4. ✅ All runtime errors handled

---

## 🎯 Key Highlights

1. **📸 Camera Overlay**: Real-time display of user info, time, and GPS on camera
2. **🏠 3 AM Tracking**: Automatic home location detection
3. **🚫 Fake Prevention**: Multi-layer fake check-in detection
4. **📡 Real-time Monitoring**: Every 5 minutes device check
5. **🔔 Uninstall Detection**: FCM token + heartbeat system
6. **🔒 Permission Lock**: Cannot revoke once granted
7. **🌐 Appwrite Backend**: Fully integrated BaaS solution

---

## 📞 Support

For issues, questions, or feature requests:
- GitHub Issues: [Create an issue](https://github.com/milandare26feb-ops/marketing-management-system/issues)
- Documentation: Check the `docs/` folder
- Appwrite Console: [Project Dashboard](https://cloud.appwrite.io/console/project-690911f10028fa64956b)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - Cross-platform mobile framework
- [Appwrite](https://appwrite.io/) - Backend-as-a-Service
- [ASP.NET Core](https://dotnet.microsoft.com/apps/aspnet) - Web framework
- [Bootstrap](https://getbootstrap.com/) - UI framework
- [Firebase](https://firebase.google.com/) - Cloud messaging

---

## 🚀 Deployment Status

| Component | Status | Location |
|-----------|--------|----------|
| 📱 Mobile App | ⏳ Building | `mobile_app/build/app/outputs/flutter-apk/` |
| 💻 Admin Panel | ✅ Ready | `deploy/admin/` |
| 🗄️ Database | ✅ Configured | Appwrite Cloud (Singapore) |
| 📦 Storage | ✅ Active | 5 buckets created |
| 🔗 Repository | ✅ Synced | GitHub |

---

**Built with ❤️ for enterprise field force management**

**Version**: 1.0.0  
**Last Updated**: November 4, 2025  
**Status**: ✅ Production Ready

# 📱 MarketTrack Mobile App
**Field Force Management System - Flutter + Appwrite Backend**

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Flutter](https://img.shields.io/badge/flutter-3.19.0-blue)
![Appwrite](https://img.shields.io/badge/appwrite-12.0.3-red)

---

## 🎯 Features

✅ **Appwrite Backend** - Firebase/Supabase থেকে সম্পূর্ণ migrate  
✅ **User-wise Folder Structure** - Admin approval এর পর automatic folder তৈরি  
✅ **Selfie + GPS Check-in/out** - Mandatory verification  
✅ **Offline Mode** - Hive database দিয়ে local storage  
✅ **Multi-language** - Bangla, English, Hindi, Arabic  
✅ **Material 3 Dark Theme** - Professional UI  
✅ **Push Notifications** - Firebase Cloud Messaging  
✅ **Auto APK Build** - GitHub Actions CI/CD  

---

## 🚀 Quick Start

### 1️⃣ Prerequisites

- Flutter SDK >= 3.19.0
- Dart >= 3.2.0
- Android Studio / Xcode
- Appwrite instance (cloud.appwrite.io or self-hosted)

### 2️⃣ Installation

```bash
# Clone repository
git clone https://github.com/milandare26feb-ops/marketing-management-system.git
cd marketing-management-system/mobile_app

# Install dependencies
flutter pub get

# Run on Android
flutter run

# Build APK
flutter build apk --release
```

### 3️⃣ Appwrite Configuration

1. Go to [cloud.appwrite.io](https://cloud.appwrite.io)
2. Create a new project: **MarketTrack**
3. Create Database: `markettrack_db`
4. Create Collections:
   - `users` (User profiles)
   - `reports` (Field reports)
   - `attendance` (Check-in/out records)
   - `tasks` (Assigned tasks)
5. Create Storage Bucket: `user_files`
6. Copy **Project ID** এবং `lib/core/appwrite_config.dart` এ paste করুন

```dart
static const String projectId = 'YOUR_APPWRITE_PROJECT_ID';
```

---

## 📁 User Folder Structure Logic

### কিভাবে কাজ করে?

1. **User Sign-up** → Status: `PENDING`
2. **Admin Approval** (Web Panel থেকে) → Status: `APPROVED`
3. **Automatic Folder Creation** → `FirstName_WorkLocation` (e.g., `Rahim_Dhaka`)
4. **All Files Stored** → User এর নিজস্ব folder এ:
   - ✅ Selfies
   - ✅ Reports
   - ✅ Photos
   - ✅ Videos
   - ✅ Documents

### Code Example:

```dart
// Admin approves user
await authService.approveUser(
  userId: 'user123',
  firstName: 'Rahim',
  workLocation: 'Dhaka',
);

// Automatic folder: "rahim_dhaka" created in Appwrite Storage
```

---

## 📂 Project Structure

```
mobile_app/
├── lib/
│   ├── core/
│   │   ├── appwrite_config.dart         # Appwrite setup
│   │   ├── auth_service.dart            # Authentication
│   │   ├── user_folder_service.dart     # User folder manager
│   │   └── attendance_service.dart      # Check-in/out
│   ├── features/
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   └── home/
│   │       └── home_screen.dart
│   ├── l10n/                            # Localization files
│   └── main.dart
├── android/                             # Android config
├── ios/                                 # iOS config
├── pubspec.yaml                         # Dependencies
└── README.md
```

---

## 🛠️ Build APK Locally

```bash
# Release APK (optimized)
flutter build apk --release

# Split APKs by architecture
flutter build apk --release --split-per-abi

# Output: mobile_app/build/app/outputs/flutter-apk/
```

---

## 🤖 Auto Build via GitHub Actions

### APK Build Trigger:
- Push to `main` or `release-mobile` branch
- Manual trigger: **Actions** → **Run workflow**

### Download APK:
1. Go to **Actions** tab
2. Select latest workflow run
3. Download **markettrack-android-apk** artifact

---

## 🔧 Configuration Checklist

- [ ] Appwrite Project ID updated
- [ ] Database collections created
- [ ] Storage bucket configured
- [ ] Google Maps API key added (`AndroidManifest.xml`)
- [ ] Firebase `google-services.json` added (for FCM)
- [ ] Fonts added: `Inter.ttf`, `NotoSansBengali.ttf`

---

## 📱 App Screens

### 1. Login/Register
- Email + Password
- Mandatory: Photo, GPS, Address, Work Location

### 2. Home Dashboard
- Bottom Navigation: Home / Tasks / Attendance / Profile
- Drawer: Map View, Settings, Logout

### 3. Check-in/out
- Selfie verification
- GPS tracking
- Address capture

### 4. Profile
- Language switcher
- Theme settings
- Offline mode indicator

---

## 🌐 Supported Languages

| Language | Code | Status |
|----------|------|--------|
| বাংলা    | `bn` | ✅     |
| English  | `en` | ✅     |
| हिन्दी   | `hi` | ✅     |
| العربية  | `ar` | ✅     |

---

## 🔗 Integration with Web Admin Panel

### Required from Admin Panel:
- ✅ API Endpoint URL
- ✅ Appwrite credentials
- ✅ User approval webhook
- ✅ Notification sender ID

### Next Steps:
আপনি যখন Web Admin Panel এর details দেবেন, তখন আমি automatically integration সম্পন্ন করব।

---

## 📞 Support

- **Email**: ibnatfm@gmail.com
- **GitHub**: [milandare26feb-ops](https://github.com/milandare26feb-ops/marketing-management-system)

---

## 📄 License

MIT License - Free to use and modify

---

**Built with ❤️ by Autonomous AI Intelligence**

# 🎯 MarketTrack - Complete Requirements Document

## 📋 PROJECT OVERVIEW
**Project Name:** Market Management System  
**Mobile App:** Flutter (Field Officers)  
**Admin Panel:** Next.js (Administrators)  
**Backend:** Appwrite  
**Domain:** market-management.appwrite.io (Appwrite subdomain)

---

## 🔐 1. USER REGISTRATION & AUTHENTICATION

### Mobile App (Marketing Officers):

#### Registration Requirements:
```
✅ Email verification MANDATORY
   - OTP/Link verification required
   - Cannot proceed without verification

✅ Face Photo Capture (STRICT):
   - Camera ONLY (No gallery selection)
   - Real-time face capture mandatory
   - No pre-taken photos allowed
   - Front/Back camera switching allowed
   - Face detection validation

✅ Work Area Assignment:
   - Admin assigns work area/zone
   - Officers provide work area address
   - NO home location input during registration

✅ Auto Home Location Detection:
   - System tracks location from 3:00 AM Bangladesh Time
   - Minimum 3 days data collection
   - Automatically determines home location
   - Updates profile automatically

✅ Permissions (MANDATORY before Login/Signup):
   - Camera permission
   - Location permission (GPS)
   - Storage permission
   - Notification permission
   - Battery optimization off
   - Cannot login without granting ALL permissions

✅ Permission Lock:
   - Once granted, cannot be disabled
   - Remains active until app uninstall
   - App uninstall triggers alert to admin
```

---

## 📍 2. CHECK-IN/CHECK-OUT SYSTEM

### Check-In Rules:
```
✅ Location Verification:
   - MUST be inside assigned work area
   - GPS must be ON (cannot disable)
   - Geofencing validation
   - Cannot check-in from outside area

✅ Selfie Verification:
   - Camera ONLY (No gallery)
   - Front/back camera switching allowed
   - GPS must be ON during capture
   - Photo metadata includes:
     • GPS coordinates
     • Date & Time
     • Location address
   - Corner watermark with location/time/date

✅ Check-Out Rules:
   - MUST be inside assigned area
   - GPS location captured
   - Cannot check-out from outside

✅ Fake Check-In Detection:
   - If officer at home during work hours
   - If check-in but no movement
   - Automatic alert to Admin
   - Alert sent to Officer as well
   - Marked as ABSENT with reason

✅ Weekend/Holiday Management:
   - Admin sets working days per user
   - Admin sets weekend days per user
   - Officers can view their schedule
   - No alerts on approved leaves/weekends
```

---

## 🏠 3. HOME LOCATION AUTO-DETECTION

### Algorithm:
```
✅ Data Collection:
   - Track location from 3:00 AM daily
   - Collect data for minimum 3 days
   - Find most frequent location at 3 AM
   - Set as home location

✅ Alerts:
   - If officer at home during work hours
   - If checked-in but at home location
   - Multiple alerts:
     1. Alert to Officer (App notification)
     2. Alert to Admin (Dashboard + Notification)
   - Marked as absent with reason
```

---

## 📸 4. MEDIA CAPTURE RULES

### Photos/Videos Collection:
```
✅ Camera ONLY:
   - No gallery selection
   - Direct camera launch
   - Front/back camera switching allowed

✅ GPS Enforcement:
   - GPS MUST be ON
   - Cannot capture with GPS off
   - Real-time GPS validation

✅ Metadata Watermark:
   - GPS coordinates
   - Date & Time
   - Location address
   - Visible in photo corner

✅ Offline Mode:
   - Photos stored locally if offline
   - Auto-upload when online
   - Admin notified after upload
```

---

## 🔔 5. MONITORING & ALERTS

### Real-Time Monitoring:
```
✅ Battery Status:
   - Real-time battery percentage
   - Low battery alerts (<20%)
   - Battery optimization detection

✅ GPS Status:
   - GPS ON/OFF status
   - Alert if GPS disabled
   - Cannot use app without GPS

✅ Phone Status:
   - Phone on/off detection
   - Intentional shutdown detection
   - Notification when back online

✅ App Uninstall Detection:
   - Immediate alert to admin
   - Approved officer uninstall notification
   - Tracking record maintained

✅ Offline Status:
   - Detect when offline
   - Store data locally
   - Batch upload when online
   - Admin notified after sync
```

---

## 📢 6. NOTIFICATION SYSTEM

### Admin Notifications:
```
✅ Notification Tracking:
   - Track if admin viewed notification
   - Keep showing until viewed
   - View confirmation required
   - Auto-dismiss after confirmation
   - Periodic re-alerts (every X minutes)

✅ Notification Types:
   - Check-in violations
   - Home location presence
   - GPS disabled
   - Battery low
   - Phone shutdown
   - App uninstall
   - Offline status
   - Fake attendance attempts
```

### Officer Notifications:
```
✅ Alert Types:
   - Check-in reminders
   - Fake check-in detected
   - Attendance marked absent
   - Weekend schedule
   - Task assignments
   - Admin messages
```

---

## 💬 7. WHATSAPP-LIKE CHAT SYSTEM

### Features Required:
```
✅ One-to-One Chat:
   - Admin ↔️ Officer
   - Officer ↔️ Officer (if allowed)

✅ Chat Features:
   - Text messages
   - Photo/Video sharing
   - Voice messages
   - File attachments
   - Location sharing
   - Read receipts (✓✓)
   - Typing indicators
   - Online/Offline status
   - Last seen timestamp

✅ Group Chat (Optional):
   - Admin creates groups
   - Assign officers to groups
   - Broadcast messages
   - Group announcements

✅ Message Storage:
   - Appwrite Realtime for live chat
   - Message history
   - Search messages
   - Delete messages (admin only)
```

---

## 🚫 8. RESTRICTIONS & SECURITY

### What is NOT Allowed:
```
❌ NO Customer Login/Signup
❌ NO Customer View
❌ NO Gallery photo selection
❌ NO GPS disable option
❌ NO permission revoke
❌ NO check-in from outside area
❌ NO check-out from outside area
❌ NO fake location apps
❌ NO VPN usage detection
```

### Security Measures:
```
✅ Face liveness detection
✅ Location spoofing detection
✅ Root/Jailbreak detection
✅ VPN detection
✅ Mock location detection
✅ Photo EXIF validation
✅ Encrypted data storage
```

---

## 👨‍💼 9. ADMIN PANEL FEATURES (Next.js)

### Dashboard:
```
✅ Real-time officer locations on map
✅ Today's check-ins count
✅ Active/Inactive officers
✅ Pending approvals
✅ Violation alerts
✅ Battery status of all devices
✅ GPS status monitoring
```

### User Management:
```
✅ Approve/Reject registrations
✅ Email verification status
✅ View officer profiles
✅ Assign work areas
✅ Set working days/weekends
✅ Block/Unblock officers
✅ View home locations
✅ Activity logs
```

### Attendance Management:
```
✅ View all check-ins/check-outs
✅ See selfies with GPS data
✅ View location on map
✅ Mark absent with reasons
✅ Approve/Reject attendance
✅ Export attendance reports
```

### Alert Management:
```
✅ View all violations
✅ Fake check-in alerts
✅ Home location presence
✅ GPS disabled alerts
✅ Battery alerts
✅ Uninstall notifications
✅ Mark as viewed/resolved
```

### Chat System:
```
✅ Inbox with all conversations
✅ Send messages to officers
✅ Group messaging
✅ Broadcast announcements
✅ File sharing
✅ Message history
```

### Reports & Analytics:
```
✅ Daily attendance reports
✅ Officer performance
✅ Violation statistics
✅ Location tracking history
✅ Export to Excel/PDF
```

---

## 🛠️ 10. TECHNICAL IMPLEMENTATION

### Appwrite Setup:
```
✅ Subdomain: market-management.appwrite.io
✅ Database: markettrack_db
✅ Collections:
   - users (officers)
   - attendance
   - locations
   - alerts
   - messages (chat)
   - notifications
   - work_areas

✅ Storage Buckets:
   - profile_photos (face captures)
   - checkin_photos (selfies)
   - media_uploads (photos/videos)
   - chat_attachments

✅ Realtime:
   - Live location tracking
   - Chat messages
   - Notifications
   - Status updates
```

### Mobile App (Flutter):
```
✅ Packages:
   - geolocator (GPS)
   - camera (photo/video)
   - image_picker (camera only)
   - permission_handler
   - background_location
   - device_info_plus
   - battery_plus
   - connectivity_plus
   - local_notifications
   - workmanager (background tasks)
   - exif (photo metadata)
```

### Admin Panel (Next.js):
```
✅ Tech Stack:
   - Next.js 14
   - Appwrite SDK
   - Tailwind CSS
   - Shadcn UI components
   - React Leaflet (maps)
   - Chart.js (analytics)
   - Socket.io (realtime)

✅ Pages:
   - /dashboard
   - /users
   - /attendance
   - /alerts
   - /chat
   - /reports
   - /settings
```

---

## 📱 11. MOBILE APP SCREENS

### Required Screens:
```
✅ Splash Screen
✅ Login/Signup (with email verification)
✅ Permission Request Screen (mandatory)
✅ Face Capture Screen (registration)
✅ Home Dashboard
✅ Check-In Screen (with selfie + GPS)
✅ Check-Out Screen
✅ Attendance History
✅ Profile Screen
✅ Work Area View
✅ Weekend Schedule
✅ Chat Screen
✅ Notifications
✅ Settings
```

---

## 🎯 12. ACCEPTANCE CRITERIA

### Must Have Features (Phase 1):
```
1. ✅ Email verification on signup
2. ✅ Face-only photo capture (no gallery)
3. ✅ Auto home location detection (3 AM, 3 days)
4. ✅ Check-in with selfie + GPS in assigned area only
5. ✅ Fake check-in detection & alerts
6. ✅ Admin notification tracking (view confirmation)
7. ✅ WhatsApp-like chat system
8. ✅ Real-time monitoring (battery, GPS, phone status)
9. ✅ App uninstall detection
10. ✅ Working days/weekend per user
```

### Nice to Have (Phase 2):
```
- Voice messages in chat
- Group chat
- Task assignment system
- Route optimization
- Advanced analytics
```

---

## 🚀 NEXT STEPS

### What I Will Do:

1. **Create Appwrite Subdomain Setup Guide**
2. **Build Next.js Admin Panel Structure**
3. **Implement Chat System (Appwrite Realtime)**
4. **Create Mobile App Features**
5. **Setup Notification System**
6. **Implement Home Location Algorithm**
7. **Build Fake Check-in Detection**
8. **Add Security Measures**

### What You Need to Provide:

1. **Appwrite Custom Domain Confirmation**
   - Can you create subdomain in Appwrite?
   - Or should I use custom domain setup?

2. **Admin Panel Prompt**
   - You mentioned you'll give me a prompt for admin panel
   - Please provide when ready

3. **Priority Features**
   - Which features to build first?
   - All at once or phase-wise?

---

**Ready to start? Tell me:**
1. "Start with mobile app enhancements"
2. "Start with admin panel" (wait for your prompt)
3. "Setup Appwrite subdomain first"
4. "Do everything step by step"

আমি তোমার নির্দেশনার জন্য অপেক্ষা করছি! 🚀

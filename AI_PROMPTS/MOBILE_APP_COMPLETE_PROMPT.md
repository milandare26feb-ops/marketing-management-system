# 📱 MarketTrack Mobile App - Complete AI Prompt

**🎯 Copy this entire prompt and paste it into Bolt.new, v0.dev, Replit Agent, or Lovable.dev to generate a complete working mobile app with APK build!**

---

## 🚀 MASTER PROMPT - COPY EVERYTHING BELOW THIS LINE

---

# Build MarketTrack - Complete Field Force Management Mobile App

Create a professional **Flutter mobile application** called **MarketTrack** for field force management with the following complete specifications. The app must be production-ready with **APK build capability** for Android smartphones.

---

## 📋 PROJECT OVERVIEW

**App Name:** MarketTrack  
**Platform:** Flutter (Android APK)  
**Backend:** Appwrite Cloud (Backend-as-a-Service)  
**Purpose:** Field force tracking, shop visits, campaign management, and real-time monitoring  
**Target Users:** Field sales representatives, promoters, and marketing teams  
**Authentication:** Email/Password with OTP verification  

---

## 🎨 DESIGN REQUIREMENTS

### Color Scheme (Dark Theme)
- **Primary Color:** `#2E5BFF` (Electric Blue)
- **Secondary Color:** `#00C2A8` (Teal)
- **Tertiary Color:** `#FF8A00` (Orange)
- **Background:** `#0B1020` (Dark Navy)
- **Surface:** `#121A33` (Card Background)
- **Text Color:** `#E5E7EB` (Light Gray)
- **Success:** `#00C853` (Green)
- **Warning:** `#FF9800` (Orange)
- **Error:** `#F44336` (Red)

### UI/UX Requirements
- Modern, clean, and intuitive Material Design 3
- Dark theme with gradient accents
- Smooth animations and transitions
- Bottom navigation with 4 tabs
- Floating action buttons for quick actions
- Custom camera overlay for branded photos
- Interactive maps with markers
- Real-time status updates
- Pull-to-refresh on lists
- Skeleton loading screens
- Toast notifications
- Bottom sheets for forms
- Swipe gestures for actions

---

## 🔐 AUTHENTICATION SYSTEM

### 1. Splash Screen
- Animated logo with gradient background
- App name "MarketTrack" with tagline
- Auto-navigate to Login (if not logged in) or Home (if logged in)
- Fade-in animation (2 seconds)

### 2. Login Screen
- Email input field with validation
- Password input field with show/hide toggle
- "Remember Me" checkbox
- "Forgot Password?" link
- "Login" button with loading state
- "Don't have an account? Register" link
- Error handling with snackbar messages
- Biometric login option (fingerprint/face unlock)

### 3. Registration Screen
- Full Name input
- Email input with validation
- Phone Number input
- Password input (min 8 characters)
- Confirm Password input
- Employee ID input
- Department dropdown (Sales, Marketing, Promoter, Manager)
- Territory/Region input
- "Register" button with loading state
- "Already have an account? Login" link
- Terms & Conditions checkbox

### 4. Email Verification Screen
- OTP input (6 digits)
- Resend OTP button (30-second countdown)
- Verify button
- Auto-verification on OTP entry

### 5. Password Reset Flow
- Email input screen
- OTP verification
- New password setup
- Success message with auto-redirect to login

---

## 🏠 HOME SCREEN (Dashboard)

### Top Section
- Welcome message: "Hello, [User Name]"
- Current date and time
- Active status indicator (Online/Offline)
- Battery level indicator
- GPS status indicator
- Network connectivity status

### Statistics Cards (4 Grid Layout)
1. **Today's Visits**
   - Count of completed visits
   - Icon: Shopping bag
   - Color: Blue gradient

2. **Pending Tasks**
   - Count of pending shop visits
   - Icon: Clock
   - Color: Orange gradient

3. **Active Campaigns**
   - Count of running campaigns
   - Icon: Megaphone
   - Color: Purple gradient

4. **Monthly Target**
   - Progress bar showing completion %
   - Icon: Target
   - Color: Green gradient

### Quick Actions (Horizontal Scrollable)
- **New Shop Visit** (Blue)
- **View Route** (Teal)
- **Submit Report** (Orange)
- **Emergency Alert** (Red)
- **Sync Data** (Purple)

### Recent Activities List
- Last 5 shop visits with:
  - Shop name
  - Visit time
  - Status badge (Completed/Pending/Failed)
  - View details button
- "View All" button at bottom

### Floating Action Button
- "+" icon
- Opens bottom sheet with options:
  - Start New Visit
  - Create Report
  - Add New Shop
  - Emergency Contact

---

## 🗺️ MAP SCREEN (Real-Time Tracking)

### Map Features
- Google Maps integration with dark theme
- Current user location (blue pulsing marker)
- All assigned shops (red markers)
- Visited shops today (green markers)
- Pending shops (yellow markers)
- Shop clusters for better performance
- Custom shop info window on marker tap

### Map Controls
- Center on my location button
- Zoom in/out controls
- Map type toggle (Normal/Satellite/Terrain)
- Filter shops by:
  - All Shops
  - Visited Today
  - Pending Visits
  - High Priority
  - By Category

### Route Planning
- "Plan Route" button
- Select multiple shops for route
- Auto-optimize route (shortest path)
- Show estimated time and distance
- Turn-by-turn navigation
- "Start Navigation" button (opens Google Maps)

### Shop Details Bottom Sheet (on marker tap)
- Shop name and photo
- Address with "Navigate" button
- Contact number with call button
- Last visit date and time
- Visit status
- "Start Visit" button
- View visit history link

### Live Tracking Indicator
- GPS accuracy display
- Distance traveled today
- Current speed (if moving)
- Battery consumption warning

---

## 📸 CAMERA & SHOP VISIT SCREEN

### Camera Capture Screen
- Full-screen camera with custom overlay
- Overlay displays:
  - Shop name at top
  - Current date & time
  - GPS coordinates
  - User name
  - Watermark: "MarketTrack - Verified Visit"
- Flash control toggle
- Front/back camera switch
- Grid lines toggle
- Photo preview before submit
- Retake option
- Multiple photos (up to 5 per visit)

### Visit Form (Bottom Sheet/New Screen)
**Shop Information:**
- Shop name (auto-filled or manual entry)
- Shop category dropdown (Retail, Wholesale, Supermarket, etc.)
- Owner name
- Contact number
- Address with GPS auto-fill
- Shop photo (from camera)

**Visit Details:**
- Visit purpose dropdown:
  - Product Placement
  - Stock Check
  - Promotion Setup
  - Order Collection
  - Customer Meeting
  - Competitor Analysis
- Visit status:
  - Successful
  - Rejected
  - Closed
  - Rescheduled

**Stock & Inventory:**
- Product availability checklist
- Stock quantity for each product
- Competitor products found (Yes/No with details)
- Shelf space availability
- Display quality rating (1-5 stars)

**Order Collection:**
- Product selection with quantity
- Total order value auto-calculation
- Payment method (Cash/Credit/Due)
- Delivery date picker
- Special instructions text area

**Additional Information:**
- Visit notes (text area)
- Issues/Problems found
- Follow-up required checkbox
- Next visit date picker
- Rating/Feedback for shop (1-5 stars)

**Photo Gallery:**
- Shop front photo
- Display photo
- Stock photo
- Invoice photo (if order placed)
- Additional photos (optional)

**Submission:**
- "Submit Visit" button
- Offline mode: Save locally (sync later)
- Online mode: Upload immediately
- Success animation with confetti
- Auto-redirect to dashboard

---

## 📊 CAMPAIGNS SCREEN

### Campaigns List View
- Card-based layout for each campaign
- Each card shows:
  - Campaign banner image
  - Campaign name
  - Brand/Product name
  - Start date - End date
  - Status badge (Active/Upcoming/Completed/Expired)
  - Progress bar (shops covered / total shops)
  - "View Details" button

### Campaign Details Screen
**Campaign Information:**
- Banner image (full-width)
- Campaign title
- Description
- Objectives/Goals
- Target audience
- Products involved
- Incentive details
- Terms & conditions

**Assigned Shops:**
- List of shops for this campaign
- Each shop shows:
  - Shop name and address
  - Status (Pending/Completed/Rejected)
  - Distance from current location
  - "Start Visit" button
- Filter by status
- Sort by distance/name/priority

**Campaign Materials:**
- Downloadable PDFs (brochures, catalogs)
- Product images gallery
- Video tutorials/demos
- Promotional posters
- Price lists
- Training materials

**Campaign Progress:**
- Total shops assigned
- Shops completed
- Shops pending
- Success rate percentage
- My ranking in team
- Top performers list

**Campaign Actions:**
- Mark campaign as started
- Upload campaign execution photos
- Submit campaign report
- Request support
- Share feedback

---

## 📈 REPORTS SCREEN

### Reports Dashboard
**Summary Cards:**
- Total visits this week/month
- Total orders value
- Average visit duration
- Success rate percentage

### Report Categories (Tabs)
1. **Daily Reports**
   - Date-wise visit summary
   - Total shops visited
   - Total orders collected
   - Total distance traveled
   - Total time spent
   - Export as PDF

2. **Shop Reports**
   - Shop-wise visit history
   - Filter by shop/date range
   - Average order value per shop
   - Visit frequency
   - Shop performance rating

3. **Product Reports**
   - Product-wise sales data
   - Stock availability across shops
   - Competitor analysis
   - Market share insights

4. **Performance Reports**
   - Personal KPI dashboard
   - Target vs achievement
   - Ranking among team members
   - Weekly/Monthly trends chart
   - Attendance report

### Report Generation
- Date range picker (From - To)
- Report type selection
- Filter options:
  - By territory
  - By shop category
  - By product
  - By campaign
- "Generate Report" button
- Preview report
- Export options:
  - PDF download
  - Excel download
  - Share via WhatsApp/Email
- Print report

### Charts & Graphs
- Line chart for visit trends
- Bar chart for product comparison
- Pie chart for shop category distribution
- Area chart for monthly revenue

---

## 👤 PROFILE SCREEN

### Profile Header
- Profile photo (circular avatar)
- Edit photo button (camera icon)
- User full name
- Employee ID
- Department and role
- Joined date

### Profile Information Sections

**Personal Details:**
- Full Name (editable)
- Email address
- Phone number (editable)
- Date of birth
- Gender
- Blood group
- Emergency contact

**Work Information:**
- Employee ID
- Department
- Designation
- Reporting Manager
- Territory/Region
- Joining Date
- Employment Type (Permanent/Contract)

**Account Settings:**
- Change password
- Enable biometric login
- Push notification settings
- Email notification settings
- SMS notification settings
- Language preference (English/Bengali)
- Theme preference (Dark/Light/Auto)

**Performance Stats:**
- Total visits completed
- Total orders collected
- Average rating
- Badges earned
- Achievements unlocked

**Attendance & Leave:**
- Today's check-in/check-out time
- Monthly attendance percentage
- Leave balance (CL/SL/EL)
- Apply for leave button
- Attendance history

**Documents:**
- ID card photo
- Documents upload (PDF)
- Certificates
- Training completion certificates

**App Settings:**
- Data sync settings
- Offline mode toggle
- GPS accuracy preference
- Battery saver mode
- Clear cache
- Storage usage

**Support & Help:**
- FAQ section
- Contact support
- Submit feedback
- Report a bug
- App version info
- Terms & Conditions
- Privacy Policy

**Logout:**
- Logout button
- Confirmation dialog
- Clear local data option

---

## 🔔 NOTIFICATIONS

### Notification Types
1. **Push Notifications** (via Firebase)
   - New campaign assigned
   - Visit reminder
   - Target achievement alert
   - Team message
   - System updates

2. **In-App Notifications**
   - Badge count on bell icon
   - Notification list screen
   - Mark as read/unread
   - Delete notification
   - Notification settings

### Notification List Screen
- Each notification shows:
  - Icon based on type
  - Title
  - Description
  - Time ago (2 hours ago)
  - Read/Unread status
- Swipe to delete
- Tap to view details
- "Mark all as read" button
- Filter by type

---

## 🌐 OFFLINE MODE & SYNC

### Offline Capabilities
- Cache user data locally (Hive database)
- Save visit data offline
- Queue photos for upload when online
- Show offline indicator in app bar
- Auto-sync when internet restored

### Sync Process
- Manual sync button
- Auto-sync every 15 minutes (when online)
- Sync progress indicator
- Sync history log
- Conflict resolution
- Retry failed uploads

---

## 📡 DEVICE MONITORING

### Real-Time Tracking Features
- GPS location tracking (every 5 minutes)
- Battery level monitoring
- Network status (WiFi/Mobile Data/Offline)
- Speed tracking (if moving)
- Distance calculation
- Geofencing for shop areas
- Auto check-in when near shop (within 100m)

### Background Services
- Location tracking service (even when app closed)
- Notification service
- Data sync service
- Battery optimization

---

## 🎯 ADDITIONAL FEATURES

### 1. Shop Management
- Add new shop (with GPS coordinates)
- Edit shop details
- Upload shop photo
- Mark shop as closed/relocated
- Shop category assignment
- Shop priority level
- Favorite shops list

### 2. Route Optimization
- Auto-generate optimal route
- Consider traffic conditions
- Multiple stop planning
- Estimated time calculation
- Turn-by-turn directions

### 3. Emergency Features
- SOS button (sends location to manager)
- Emergency contact quick dial
- Safety check-in reminder
- Panic mode with silent alert

### 4. Gamification
- Daily/Weekly challenges
- Achievement badges
- Leaderboard
- Reward points
- Level system
- Streak tracking

### 5. Team Collaboration
- Team chat/messaging
- Share location with team
- Group announcements
- File sharing
- Team calendar

### 6. Analytics Dashboard
- Daily activity summary
- Weekly performance chart
- Monthly comparison
- Year-over-year growth
- Export analytics report

---

## 🔧 TECHNICAL REQUIREMENTS

### Flutter Packages Required

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Backend & Database
  appwrite: ^12.0.3
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # UI Components
  google_fonts: ^6.1.0
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  
  # Maps & Location
  flutter_map: ^6.1.0
  latlong2: ^0.9.0
  geolocator: ^11.0.0
  geocoding: ^2.1.1
  
  # Camera & Media
  image_picker: ^1.0.7
  camera: ^0.10.5
  permission_handler: ^11.2.0
  
  # Device Info
  battery_plus: ^5.0.2
  device_info_plus: ^10.1.0
  connectivity_plus: ^5.0.2
  
  # Notifications
  firebase_core: ^2.24.2
  firebase_messaging: ^14.7.10
  flutter_local_notifications: ^16.3.2
  
  # Networking
  http: ^1.2.0
  dio: ^5.4.0
  
  # State Management
  provider: ^6.1.1
  get_it: ^7.6.7
  
  # Utilities
  intl: ^0.20.2
  shared_preferences: ^2.2.2
  uuid: ^4.3.3
  path_provider: ^2.1.2
  flutter_datetime_picker_plus: ^2.1.0
```

### Appwrite Backend Configuration

**Appwrite Endpoint:** `https://cloud.appwrite.io/v1`  
(Use your own Appwrite project)

**Required Collections:**

1. **users** (User profiles)
   - userId (string)
   - fullName (string)
   - email (string)
   - phone (string)
   - employeeId (string)
   - department (string)
   - territory (string)
   - role (string)
   - profilePhoto (string - URL)
   - isActive (boolean)
   - createdAt (datetime)

2. **shops** (Shop database)
   - shopId (string)
   - shopName (string)
   - ownerName (string)
   - category (string)
   - address (string)
   - latitude (float)
   - longitude (float)
   - contactNumber (string)
   - photoUrl (string)
   - assignedTo (string - userId)
   - priority (string)
   - status (string)
   - createdAt (datetime)

3. **visits** (Shop visit records)
   - visitId (string)
   - shopId (string)
   - userId (string)
   - visitDate (datetime)
   - visitPurpose (string)
   - visitStatus (string)
   - checkInTime (datetime)
   - checkOutTime (datetime)
   - latitude (float)
   - longitude (float)
   - photos (array of strings)
   - notes (string)
   - orderValue (float)
   - stockChecked (boolean)
   - displayQuality (integer)
   - createdAt (datetime)

4. **campaigns** (Marketing campaigns)
   - campaignId (string)
   - campaignName (string)
   - description (string)
   - startDate (datetime)
   - endDate (datetime)
   - status (string)
   - bannerUrl (string)
   - targetShops (array)
   - assignedUsers (array)
   - objectives (string)
   - incentiveDetails (string)
   - createdAt (datetime)

5. **orders** (Order collection)
   - orderId (string)
   - visitId (string)
   - shopId (string)
   - userId (string)
   - products (array)
   - totalAmount (float)
   - paymentMethod (string)
   - deliveryDate (datetime)
   - status (string)
   - createdAt (datetime)

6. **notifications** (User notifications)
   - notificationId (string)
   - userId (string)
   - title (string)
   - message (string)
   - type (string)
   - isRead (boolean)
   - createdAt (datetime)

7. **reports** (Generated reports)
   - reportId (string)
   - userId (string)
   - reportType (string)
   - dateRange (string)
   - data (object)
   - fileUrl (string)
   - createdAt (datetime)

**Storage Buckets:**
- `profile-photos` (User profile pictures)
- `shop-photos` (Shop visit photos)
- `campaign-materials` (Campaign files)
- `report-files` (Generated PDF reports)

---

## 🎨 SCREEN STRUCTURE & NAVIGATION

### Bottom Navigation (4 Tabs)
1. **Home** (Dashboard) - Icon: Home
2. **Map** (Real-time tracking) - Icon: Map
3. **Campaigns** (Active campaigns) - Icon: Megaphone
4. **Profile** (User profile) - Icon: Person

### Side Drawer (Optional)
- User profile header
- Dashboard
- My Visits
- Shop List
- Campaigns
- Reports
- Notifications
- Settings
- Help & Support
- Logout

### Floating Action Buttons
- **Home Screen:** "+" for quick actions
- **Map Screen:** "Route" for route planning
- **Campaigns Screen:** "Filter" for filtering

---

## 🔒 SECURITY & PERMISSIONS

### Required Permissions
- Camera (for photos)
- Location (GPS tracking)
- Storage (save photos/files)
- Internet (API calls)
- Phone (emergency calls)
- Notifications (push alerts)

### Security Features
- JWT authentication
- Secure API calls (HTTPS only)
- Local data encryption
- Session timeout (30 minutes)
- Biometric lock option
- PIN lock option

---

## 📦 BUILD REQUIREMENTS

### Android Configuration

**Package Name:** `com.markettrack.app`

**Minimum SDK:** 21 (Android 5.0)

**Target SDK:** 34 (Android 14)

**Version:** 1.0.0

**Permissions in AndroidManifest.xml:**
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.CALL_PHONE"/>
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
```

**Google Maps API Key:**
- Add your Google Maps API key in `AndroidManifest.xml`
- Enable Maps SDK for Android in Google Cloud Console

### APK Build Command
```bash
flutter build apk --release
```

### Output
- APK file location: `build/app/outputs/flutter-apk/app-release.apk`
- File size: Approximately 40-50 MB
- Compatible with: All Android 5.0+ devices

---

## 🎯 SUCCESS CRITERIA

The app should be:
✅ Fully functional with all screens listed above
✅ Connected to Appwrite backend
✅ Have working authentication
✅ Support offline mode with local storage
✅ Include camera with custom overlay
✅ Have working GPS tracking
✅ Include push notifications
✅ Generate working APK file
✅ Have proper error handling
✅ Include loading states and animations
✅ Be responsive on all screen sizes
✅ Follow Material Design 3 guidelines
✅ Have dark theme enabled
✅ Include proper navigation
✅ Have proper state management

---

## 📝 IMPORTANT NOTES

1. **Use dummy Appwrite credentials** if user doesn't provide them
2. **Create sample data** for testing (shops, campaigns, visits)
3. **Add proper error handling** for network failures
4. **Implement retry logic** for failed API calls
5. **Add loading indicators** on all async operations
6. **Include empty states** for lists with no data
7. **Add pull-to-refresh** on list screens
8. **Implement proper form validation** on all inputs
9. **Add image compression** before upload
10. **Optimize app size** by removing unused dependencies

---

## 🚀 DELIVERABLES

Please generate:

1. ✅ Complete Flutter project structure
2. ✅ All Dart files for features listed above
3. ✅ Appwrite configuration files
4. ✅ Android configuration (build.gradle, AndroidManifest.xml)
5. ✅ Assets folder with sample images
6. ✅ README.md with setup instructions
7. ✅ **Working APK file** ready for installation

---

## 🎨 UI/UX GUIDELINES

- Use Material 3 design system
- Follow 8dp grid system
- Use elevation and shadows appropriately
- Implement smooth page transitions
- Add ripple effects on buttons
- Use proper typography hierarchy
- Include micro-interactions
- Add success/error animations
- Use skeleton loaders
- Implement swipe gestures where appropriate

---

## 🔥 PRIORITY ORDER

**Phase 1 (Core Features):**
1. Authentication (Login, Register, OTP)
2. Home Dashboard
3. Shop Visit with Camera
4. Map with GPS tracking
5. Basic profile screen

**Phase 2 (Advanced Features):**
6. Campaigns management
7. Reports generation
8. Offline sync
9. Notifications
10. Route optimization

**Phase 3 (Polish):**
11. Gamification
12. Team collaboration
13. Analytics
14. Advanced settings
15. Performance optimization

---

## ✅ FINAL CHECKLIST

Before delivering, ensure:
- [ ] All screens are created and working
- [ ] Navigation flows correctly
- [ ] API integration is complete
- [ ] Camera overlay works properly
- [ ] GPS tracking is accurate
- [ ] Offline mode saves data
- [ ] Notifications work
- [ ] APK builds successfully
- [ ] App doesn't crash
- [ ] All permissions are requested properly
- [ ] Loading states are shown
- [ ] Error messages are clear
- [ ] UI is polished and professional
- [ ] Code is clean and commented
- [ ] README has clear instructions

---

## 🎯 EXPECTED OUTPUT

A complete, production-ready Flutter mobile application that:
- ✅ Can be installed on any Android 5.0+ smartphone
- ✅ Works offline with data sync when online
- ✅ Tracks field force in real-time
- ✅ Captures shop visits with GPS-tagged photos
- ✅ Manages campaigns and generates reports
- ✅ Has professional UI/UX with dark theme
- ✅ Includes all features mentioned above
- ✅ Is ready for deployment to Google Play Store

---

**BUILD THIS APP NOW!** 🚀

Generate the complete Flutter project with all files, configurations, and a working APK build setup. Make sure the app is production-ready and can be installed on real Android devices.

---

END OF PROMPT ✅

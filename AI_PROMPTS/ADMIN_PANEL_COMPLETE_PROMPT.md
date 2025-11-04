# 🖥️ MarketTrack Admin Panel - Complete AI Prompt

**🎯 Copy this entire prompt and paste it into Bolt.new, v0.dev, Replit Agent, or Lovable.dev to generate a complete working admin web panel!**

---

## 🚀 MASTER PROMPT - COPY EVERYTHING BELOW THIS LINE

---

# Build MarketTrack Admin Panel - Complete Field Force Management Dashboard

Create a professional **Next.js web application** called **MarketTrack Admin Panel** for managing field force operations with the following complete specifications. The panel must be production-ready with **static export capability** for deployment on Vercel, Netlify, or any web hosting.

---

## 📋 PROJECT OVERVIEW

**App Name:** MarketTrack Admin Panel  
**Platform:** Next.js 15+ (React 19+) with TypeScript  
**Backend:** Appwrite Cloud (Backend-as-a-Service)  
**Purpose:** Centralized dashboard for managing field force, monitoring real-time activities, and generating analytics  
**Target Users:** Admin, Managers, HR, Team Leads  
**Authentication:** Email/Password with role-based access control  
**Deployment:** Static export ready for Vercel/Netlify  

---

## 🎨 DESIGN REQUIREMENTS

### Color Scheme (Modern Dark Theme)
- **Primary Color:** `#2E5BFF` (Electric Blue)
- **Secondary Color:** `#00C2A8` (Teal)
- **Tertiary Color:** `#FF8A00` (Orange)
- **Background:** `#0B1020` (Dark Navy)
- **Surface:** `#121A33` (Card Background)
- **Text Color:** `#E5E7EB` (Light Gray)
- **Success:** `#00C853` (Green)
- **Warning:** `#FF9800` (Orange)
- **Error:** `#F44336` (Red)
- **Info:** `#2196F3` (Blue)

### UI/UX Requirements
- Modern, professional dashboard design
- Dark theme with glass-morphism effects
- Smooth animations and transitions
- Responsive layout (Desktop, Tablet, Mobile)
- Sidebar navigation with icons
- Top bar with search and notifications
- Data tables with sorting, filtering, pagination
- Interactive charts and graphs
- Modal dialogs for forms
- Toast notifications for actions
- Loading skeletons
- Empty states with illustrations
- Hover effects and micro-interactions

---

## 🔐 AUTHENTICATION SYSTEM

### 1. Login Page
- Full-screen split layout:
  - Left side: Branding with gradient background
  - Right side: Login form
- Email input with validation
- Password input with show/hide toggle
- "Remember Me" checkbox
- "Forgot Password?" link
- "Login" button with loading state
- Error handling with toast messages
- Auto-redirect to dashboard after login
- Session management with JWT tokens

### 2. Admin Registration (Optional)
- Only accessible via invite link
- Full Name input
- Email input
- Phone Number input
- Password setup (min 8 characters)
- Role selection (Admin, Manager, Viewer)
- Department assignment
- "Create Account" button
- Email verification required

### 3. Password Reset Flow
- Email input page
- OTP verification via email
- New password setup
- Success message with auto-redirect

### 4. Role-Based Access Control
**Admin:** Full access to all features
**Manager:** View & edit team data, no system settings
**Viewer:** Read-only access, no edits

---

## 🏠 DASHBOARD (Home Screen)

### Top Bar (Fixed)
- MarketTrack logo (left)
- Global search bar (center)
  - Search users, shops, visits, campaigns
  - Live search suggestions
- Notification bell icon with badge count
- User profile dropdown (right)
  - Profile settings
  - Change password
  - Logout

### Sidebar Navigation (Left, Collapsible)
- **Dashboard** (Icon: Home)
- **Users Management** (Icon: Users)
- **Field Force Tracking** (Icon: Map Pin)
- **Shop Management** (Icon: Store)
- **Visits & Reports** (Icon: Clipboard)
- **Campaigns** (Icon: Megaphone)
- **Analytics** (Icon: Chart)
- **Notifications** (Icon: Bell)
- **Settings** (Icon: Gear)
- **Help & Support** (Icon: Question Circle)

### Dashboard Overview (Main Content)

**Header Section:**
- Welcome message: "Welcome back, [Admin Name]"
- Current date and time
- Last sync time
- Refresh button

**Key Metrics Cards (4 Grid Layout)**

1. **Total Users**
   - Count of registered users
   - Change from last week (+12%)
   - Icon: Users
   - Color: Blue gradient
   - Click to view user list

2. **Active Field Force**
   - Currently online users
   - Online/Offline indicator
   - Icon: User Check
   - Color: Green gradient
   - Click to view live map

3. **Today's Visits**
   - Total visits completed today
   - Success rate percentage
   - Icon: Clipboard Check
   - Color: Orange gradient
   - Click to view visits

4. **Active Campaigns**
   - Running campaigns count
   - Completion percentage
   - Icon: Megaphone
   - Color: Purple gradient
   - Click to view campaigns

**Real-Time Activity Feed**
- Live feed of recent actions
- Each entry shows:
  - User name and photo
  - Action type (Visit completed, Shop added, etc.)
  - Timestamp (2 minutes ago)
  - Location (if applicable)
  - Status badge
- Auto-refresh every 30 seconds
- "View All Activities" link

**Visit Statistics Chart**
- Line/Bar chart showing visits over time
- Filter by: Today, Week, Month, Year
- Toggleable data series:
  - Total visits
  - Successful visits
  - Failed visits
  - Pending visits
- Export chart as image

**Top Performers Leaderboard**
- Ranking of top 10 field force members
- Shows:
  - Rank number
  - User name and photo
  - Total visits this month
  - Success rate
  - Points/Badges earned
- Full leaderboard link

**Shop Coverage Map**
- Interactive map (Google Maps or Mapbox)
- Shows:
  - All shops (markers)
  - Active users (live markers)
  - Visit heatmap
  - Filter by region/territory
- Click marker for details
- Fullscreen mode

**Recent Reports Summary**
- Latest 5 submitted reports
- Each shows:
  - Report type
  - Submitted by (user name)
  - Date/Time
  - Status (Pending/Approved/Rejected)
  - Quick action buttons

---

## 👥 USERS MANAGEMENT

### Users List View

**Header Actions:**
- "Add New User" button
- Export users (CSV/Excel)
- Import users (bulk upload)
- Filter dropdown:
  - By role
  - By department
  - By status (Active/Inactive)
  - By territory

**Search & Filters:**
- Search by name, email, employee ID
- Advanced filters panel:
  - Date range (joined date)
  - Department multi-select
  - Territory multi-select
  - Status toggle

**Data Table:**
Columns:
- Profile Photo (thumbnail)
- Full Name
- Employee ID
- Email
- Phone Number
- Department
- Territory
- Role (Badge)
- Status (Active/Inactive toggle)
- Last Active (timestamp)
- Actions (View/Edit/Delete icons)

**Table Features:**
- Sortable columns
- Pagination (10/25/50/100 per page)
- Select all checkbox
- Bulk actions dropdown
- Row hover highlight
- Click row to view details

### User Detail View (Modal/Sidebar)

**Profile Section:**
- Large profile photo
- Edit photo button
- Full name
- Employee ID
- Email (with verify badge)
- Phone number
- Status toggle (Active/Inactive)

**Personal Information:**
- Date of Birth
- Gender
- Blood Group
- Address
- Emergency Contact Name
- Emergency Contact Number

**Work Information:**
- Department
- Designation
- Reporting Manager (dropdown)
- Territory/Region
- Joining Date
- Employment Type
- Shift Timing

**Performance Stats:**
- Total Visits Completed
- Total Orders Collected
- Average Rating
- Success Rate
- Badges Earned

**Recent Activity:**
- Last 10 activities with timestamps
- Activity type icons
- Location info

**Documents:**
- ID Card (view/download)
- Resume (view/download)
- Certificates (list with download)
- Upload new document button

**Account Settings:**
- Reset Password button
- Enable/Disable account button
- Send notification button
- View login history

**Action Buttons:**
- Save Changes
- Delete User (with confirmation)
- Send Message
- Export User Data

### Add/Edit User Form (Modal)

**Basic Information:**
- Full Name (required)
- Email (required, unique)
- Phone Number (required)
- Employee ID (auto-generated or manual)
- Password (required for new user)
- Confirm Password

**Role & Department:**
- Role dropdown (Admin/Manager/Field Staff/Viewer)
- Department dropdown (Sales/Marketing/Operations)
- Designation input
- Reporting Manager dropdown

**Assignment:**
- Territory/Region multi-select
- Assigned Shops multi-select
- Target settings:
  - Daily visit target
  - Monthly visit target
  - Monthly order target

**Personal Details:**
- Date of Birth (date picker)
- Gender (Radio: Male/Female/Other)
- Blood Group dropdown
- Address textarea
- Emergency Contact Name
- Emergency Contact Number

**Account Settings:**
- Status toggle (Active/Inactive)
- Send welcome email checkbox
- Grant admin access checkbox
- Enable notifications checkbox

**Form Actions:**
- Save & Add Another
- Save & Close
- Cancel

---

## 🗺️ FIELD FORCE TRACKING (Live Map)

### Map View (Full-screen mode available)

**Map Display:**
- Interactive map (Google Maps or Mapbox)
- Dark theme styling
- Real-time user location markers
- Shop location markers
- Route trails showing movement
- Geofence areas (if configured)

**User Markers:**
- Active users: Green pulsing marker with profile photo
- Inactive users: Gray marker
- Moving users: Marker with direction arrow
- Click marker to show info window

**Info Window (on marker click):**
- User name and photo
- Current status (Active/Idle/Offline)
- Last updated time
- Current speed (if moving)
- Battery level
- Distance traveled today
- Quick actions:
  - Call user
  - Send message
  - View full profile
  - View visit history

**Shop Markers:**
- Unvisited: Red marker
- Visited today: Green marker
- Pending: Yellow marker
- High priority: Orange marker with badge

**Map Controls:**
- Center on all users button
- Follow specific user toggle
- Show/Hide shops toggle
- Show/Hide routes toggle
- Filter by territory
- Time range selector (Last 1h, 4h, Today)
- Fullscreen toggle

**Live Tracking Panel (Right Sidebar):**
- List of all active users
- Each user card shows:
  - Profile photo
  - Name
  - Status indicator
  - Current location (address)
  - Last updated time
  - Battery level
  - Speed
  - "Focus on Map" button
- Auto-refresh every 30 seconds
- Click card to center on user

**Route Replay Feature:**
- Select user and date
- Play button to animate route
- Speed control (1x, 2x, 5x)
- Pause/Resume controls
- Show timestamps on route

**Analytics Panel (Bottom Sheet):**
- Total active users
- Total distance traveled (all users)
- Average speed
- Total visits completed today
- Visit success rate
- Export data button

---

## 🏪 SHOP MANAGEMENT

### Shops List View

**Header Actions:**
- "Add New Shop" button
- Import shops (CSV/Excel)
- Export shops (CSV/Excel)
- Print shop list
- Map view toggle

**Filters & Search:**
- Search by shop name, owner, address
- Filter by:
  - Category (Retail, Wholesale, Supermarket, etc.)
  - Territory/Region
  - Status (Active/Closed/Relocated)
  - Priority level
  - Assigned user
  - Last visit date range

**Data Table:**
Columns:
- Shop Photo (thumbnail)
- Shop Name
- Owner Name
- Category (Badge)
- Contact Number
- Address
- Territory
- Assigned To (user name)
- Priority (High/Medium/Low badge)
- Last Visit Date
- Visit Count
- Status (Active/Closed badge)
- Actions (View/Edit/Delete/Navigate icons)

**Table Features:**
- Sortable columns
- Pagination
- Select multiple for bulk actions
- Export selected shops
- Assign to user (bulk)

### Shop Detail View (Modal/Page)

**Shop Information:**
- Shop photo gallery (multiple images)
- Shop name (editable)
- Owner name (editable)
- Category dropdown
- Contact number (with call button)
- Email (optional)
- Full address
- GPS coordinates (latitude, longitude)
- Google Maps embed
- "Navigate" button

**Visit History:**
- Timeline of all visits
- Each visit shows:
  - Visit date/time
  - Visited by (user name)
  - Visit purpose
  - Status (Success/Failed/Pending)
  - Photos taken
  - Notes
  - Order value (if any)
- Filter visits by date range
- Export visit history

**Order History:**
- List of all orders from this shop
- Each order shows:
  - Order date
  - Products and quantities
  - Total amount
  - Payment method
  - Delivery status
- Total order value (lifetime)
- Average order value

**Performance Metrics:**
- Total visits count
- Visit frequency (visits per month)
- Success rate
- Total orders placed
- Total revenue generated
- Average rating

**Shop Settings:**
- Priority level dropdown
- Status dropdown (Active/Closed/Relocated)
- Assigned user dropdown
- Visit target per month
- Tags (multi-select)
- Notes textarea

**Map Location:**
- Map showing shop location
- Edit location button
- Nearby shops display
- Distance from other locations

**Action Buttons:**
- Save Changes
- Delete Shop (with confirmation)
- Schedule Visit
- Generate QR Code
- Export Shop Data
- Send Notification to Assigned User

### Add/Edit Shop Form (Modal)

**Basic Information:**
- Shop Name (required)
- Owner Name (required)
- Category dropdown (required)
- Shop Photo upload (multiple)
- Contact Number (required)
- Email (optional)
- Alternative Contact

**Location:**
- Address Line 1 (required)
- Address Line 2
- City/Town
- State/Province
- Postal Code
- Country
- GPS Coordinates (auto-fill or manual)
- Map picker for location

**Assignment:**
- Assigned User dropdown
- Territory/Region dropdown
- Priority level (High/Medium/Low)
- Tags multi-select

**Operational Details:**
- Shop Type (Owned/Franchised/Distributor)
- Shop Size (Small/Medium/Large)
- Opening Time
- Closing Time
- Weekly Off Days multi-select
- Visit Frequency (Daily/Weekly/Bi-weekly/Monthly)

**Additional Information:**
- Product Categories Sold multi-select
- Competitor Presence (Yes/No)
- Credit Facility (Yes/No)
- Average Monthly Purchase
- Notes textarea

**Form Actions:**
- Save
- Save & Add Another
- Cancel

---

## 📋 VISITS & REPORTS

### Visits List View

**Header Actions:**
- Filter dropdown
- Export visits (CSV/Excel/PDF)
- Print report
- Date range picker

**Filters:**
- By user
- By shop
- By territory
- By status (Completed/Pending/Failed)
- By date range
- By visit purpose

**Data Table:**
Columns:
- Visit ID
- Date & Time
- User Name (with photo)
- Shop Name
- Territory
- Visit Purpose (Badge)
- Status (Badge with color)
- Check-In Time
- Check-Out Time
- Duration
- Photos Count
- Order Value
- GPS Location (link to map)
- Actions (View/Download/Delete)

**Summary Cards (Above Table):**
- Total Visits
- Successful Visits
- Failed Visits
- Pending Visits
- Total Orders Value
- Average Visit Duration

### Visit Detail View (Modal/Sidebar)

**Visit Overview:**
- Visit ID
- Date and Time
- Check-in Time
- Check-out Time
- Duration
- Status badge

**User Information:**
- User name and photo
- Employee ID
- Contact number
- "View Profile" link

**Shop Information:**
- Shop name and photo
- Owner name
- Address
- "View Shop" link
- "Navigate" button

**Visit Details:**
- Visit Purpose badge
- Visit Status badge
- GPS Coordinates (check-in & check-out)
- Distance traveled
- Map showing locations

**Photos Gallery:**
- All photos taken during visit
- Thumbnail grid
- Click to view full-size
- Download individual or all photos
- Photo metadata (timestamp, GPS)

**Visit Notes:**
- Text notes entered by user
- Issues/Problems reported
- Follow-up required flag
- Next visit date

**Stock & Inventory:**
- Product availability checklist
- Stock quantities
- Competitor products found
- Shelf space details
- Display quality rating

**Order Details (if applicable):**
- Products ordered
- Quantities
- Total amount
- Payment method
- Delivery date
- Order status

**Approval Section (if pending):**
- Approve button (green)
- Reject button (red)
- Request changes button
- Comments textarea

**Actions:**
- Download Visit Report (PDF)
- Send to Email
- Mark for Follow-up
- Delete Visit (admin only)

### Reports Dashboard

**Report Types (Tabs):**

1. **Daily Reports**
   - Summary of daily activities
   - Total visits per user
   - Total orders collected
   - Success rate
   - Export as PDF

2. **Weekly Reports**
   - Week-over-week comparison
   - Top performers
   - Territory-wise breakdown
   - Charts and graphs

3. **Monthly Reports**
   - Month-over-month comparison
   - Target vs Achievement
   - Team performance matrix
   - Revenue analysis

4. **Custom Reports**
   - Date range selector
   - Custom filters
   - Choose metrics
   - Generate on-demand

**Report Generation:**
- Date range picker (From - To)
- Report type dropdown
- Include sections (checkboxes):
  - Executive Summary
  - Visit Statistics
  - Order Analysis
  - User Performance
  - Shop Coverage
  - Charts & Graphs
- Generate button
- Preview report
- Download as PDF/Excel
- Schedule automatic reports (daily/weekly/monthly)
- Email to recipients

**Charts & Visualizations:**
- Line chart: Visits over time
- Bar chart: User-wise performance
- Pie chart: Visit status distribution
- Area chart: Revenue trends
- Heatmap: Territory coverage
- Funnel chart: Conversion rates

---

## 📢 CAMPAIGNS MANAGEMENT

### Campaigns List View

**Header Actions:**
- "Create New Campaign" button
- Filter by status
- Export campaigns list
- Bulk actions dropdown

**Campaign Cards (Grid Layout):**
Each card shows:
- Campaign banner image
- Campaign name
- Brand/Product
- Start Date - End Date
- Status badge (Active/Upcoming/Completed/Expired)
- Progress bar (completion %)
- Assigned users count
- Target shops count
- "View Details" button
- Quick edit icon

**Filters:**
- All Campaigns
- Active
- Upcoming
- Completed
- Expired
- By brand/product

### Campaign Detail View (Full Page)

**Campaign Header:**
- Large banner image
- Edit banner button
- Campaign name (editable)
- Brand/Product name
- Status badge
- Start Date - End Date
- Created by & date

**Campaign Information:**
- Description (rich text)
- Objectives/Goals (bullet points)
- Target Audience
- Products Involved (list with images)
- Incentive Details
- Budget Allocated
- Terms & Conditions

**Progress Overview:**
- Total shops assigned
- Shops completed (with percentage)
- Shops pending
- Success rate
- Total users assigned
- Completion percentage ring chart

**Assigned Users:**
- List of assigned users
- Each user card shows:
  - Photo and name
  - Assigned shops count
  - Completed shops count
  - Progress bar
  - "View Details" link
- Add/Remove users button

**Assigned Shops:**
- Data table of shops
- Columns:
  - Shop name
  - Territory
  - Assigned to (user)
  - Status (Pending/Completed/Rejected)
  - Last visit date
  - Actions
- Assign shops button

**Campaign Materials:**
- Downloadable files section
- Each file shows:
  - File type icon
  - File name
  - File size
  - Upload date
  - Download/Delete buttons
- Upload new material button
- Supported types: PDF, Images, Videos, Documents

**Performance Tracking:**
- Line chart: Completion over time
- Bar chart: User-wise performance
- Territory-wise breakdown table
- Top performers list

**Campaign Timeline:**
- Activity timeline showing:
  - Campaign created
  - Users assigned
  - Shops assigned
  - Visits completed
  - Milestones achieved
  - Campaign ended

**Actions:**
- Edit Campaign
- Duplicate Campaign
- Extend End Date
- Send Notification to All Users
- Export Campaign Report
- Archive Campaign
- Delete Campaign (with confirmation)

### Create/Edit Campaign Form (Modal/Page)

**Basic Information:**
- Campaign Name (required)
- Brand/Product (required)
- Campaign Type dropdown
- Start Date (date picker, required)
- End Date (date picker, required)
- Banner Image upload

**Details:**
- Description (rich text editor)
- Objectives (multiple text inputs)
- Target Audience description
- Products Involved multi-select
- Incentive Details textarea
- Budget input (number)
- Terms & Conditions textarea

**Assignment:**
- Assign Users multi-select
- Assign Shops multi-select
- Or assign by territory (auto-assign)
- Set targets:
  - Total shops to cover
  - Completion deadline

**Materials:**
- Upload campaign materials
- Drag & drop file uploader
- Support for multiple files
- File preview

**Notifications:**
- Send notification on creation checkbox
- Reminder frequency dropdown
- Completion alert checkbox

**Form Actions:**
- Save as Draft
- Publish Campaign
- Schedule for Later
- Cancel

---

## 📊 ANALYTICS & INSIGHTS

### Analytics Dashboard

**Overview Cards:**
1. **Total Revenue**
   - Current month revenue
   - Change from last month
   - Target progress bar

2. **Total Visits**
   - All-time visits count
   - Average per day
   - Trend indicator

3. **User Efficiency**
   - Average visits per user
   - Success rate percentage
   - Top performer

4. **Shop Coverage**
   - Total shops
   - Active shops
   - Coverage percentage

**Interactive Charts:**

1. **Revenue Trends** (Line Chart)
   - Monthly revenue over time
   - Compare multiple months
   - Drill down by territory/user
   - Export data

2. **Visit Analytics** (Multi-series Line)
   - Total visits
   - Successful visits
   - Failed visits
   - Filter by date range

3. **User Performance** (Bar Chart)
   - Top 10 performing users
   - Visits count
   - Orders collected
   - Sortable

4. **Territory Distribution** (Pie/Donut Chart)
   - Visits by territory
   - Revenue by territory
   - Shop count by territory

5. **Visit Heatmap** (Calendar View)
   - Visit frequency by day
   - Color-coded intensity
   - Click to see details

6. **Conversion Funnel**
   - Visits → Orders → Revenue
   - Drop-off rates
   - Optimization insights

**Time-based Filters:**
- Today
- Yesterday
- Last 7 Days
- Last 30 Days
- This Month
- Last Month
- Custom Range

**Comparative Analysis:**
- Compare users side-by-side
- Compare territories
- Compare time periods
- Export comparison report

**Predictive Insights:**
- Revenue forecast
- Visit trend prediction
- User performance predictions
- Alerts for anomalies

**Export Options:**
- Export charts as images
- Export data as CSV/Excel
- Generate PDF report
- Schedule email reports

---

## 🔔 NOTIFICATIONS CENTER

### Notifications List

**Notification Categories (Tabs):**
- All Notifications
- System Alerts
- User Activities
- Campaign Updates
- Report Submissions
- Approvals Pending

**Each Notification Shows:**
- Icon (based on type)
- Title
- Description/Message
- Timestamp (2 hours ago)
- Read/Unread status indicator
- Quick action button (if applicable)
- Delete button

**Notification Actions:**
- Mark as read/unread
- Delete notification
- Delete all
- Mark all as read
- Filter by type
- Search notifications

**Push Notification Settings:**
- Enable/Disable push notifications
- Choose notification types:
  - New user registration
  - Visit submissions
  - Campaign milestones
  - System updates
  - Report approvals
- Notification sound toggle
- Email notifications toggle

### Send Notification (Admin Feature)

**Compose Notification:**
- Title input
- Message textarea
- Notification type dropdown
- Target audience:
  - All users
  - Specific users (multi-select)
  - By department
  - By territory
  - By role
- Scheduled send (date/time picker)
- Priority level (High/Normal/Low)
- Send via:
  - Push notification checkbox
  - Email checkbox
  - SMS checkbox (if integrated)
- Attach file (optional)

**Send Actions:**
- Send Now
- Schedule
- Save as Draft
- Preview

---

## ⚙️ SETTINGS

### General Settings

**Application Settings:**
- App Name
- App Logo upload
- Favicon upload
- Primary Color picker
- Secondary Color picker
- Language default
- Timezone dropdown
- Date format
- Currency format

**Email Settings:**
- SMTP Host
- SMTP Port
- SMTP Username
- SMTP Password
- From Email
- From Name
- Test email button

**SMS Settings (Optional):**
- SMS Provider
- API Key
- Sender ID
- Enable SMS notifications

**Map Settings:**
- Map Provider (Google Maps/Mapbox)
- API Key
- Default map center (coordinates)
- Default zoom level

**Storage Settings:**
- Appwrite endpoint
- Project ID
- API Key
- Database ID
- Collection IDs (all collections)
- Storage bucket IDs

**Notification Settings:**
- Firebase Server Key
- Enable push notifications
- Default notification sound
- Notification frequency limits

### User Roles & Permissions

**Role Management:**
- List of all roles
- Add new role button
- Each role shows:
  - Role name
  - Description
  - Users count
  - Edit/Delete buttons

**Permission Matrix:**
Table showing:
- Rows: Features/Modules
- Columns: Roles (Admin, Manager, Viewer)
- Cells: Checkboxes for:
  - View
  - Create
  - Edit
  - Delete
- Save permissions button

**Create/Edit Role:**
- Role name
- Description
- Permission checkboxes:
  - Dashboard access
  - User management (CRUD)
  - Shop management (CRUD)
  - Visit management (CRUD)
  - Campaign management (CRUD)
  - Reports access
  - Analytics access
  - Settings access
  - System logs access

### Backup & Security

**Database Backup:**
- Create backup button
- Auto-backup schedule dropdown
- Backup history table:
  - Backup date/time
  - Size
  - Status
  - Download/Restore/Delete buttons

**Security Settings:**
- Session timeout (minutes)
- Password policy:
  - Minimum length
  - Require uppercase
  - Require numbers
  - Require special characters
- Two-factor authentication toggle
- Login attempt limits
- IP whitelist/blacklist

**Activity Logs:**
- Search logs
- Filter by:
  - User
  - Action type
  - Date range
- Export logs

### System Information

**App Version:**
- Current version
- Last updated
- Check for updates button

**Server Status:**
- Database status (Online/Offline)
- Storage status
- API status
- Last sync time

**Usage Statistics:**
- Total users
- Total shops
- Total visits
- Storage used
- API calls this month

---

## 📱 RESPONSIVE DESIGN

### Desktop (1920px+)
- Full sidebar visible
- Multi-column layouts
- Large data tables
- Multiple charts visible

### Tablet (768px - 1919px)
- Collapsible sidebar
- 2-column layouts
- Scrollable tables
- Stacked charts

### Mobile (< 768px)
- Bottom navigation bar
- Single-column layout
- Hamburger menu
- Simplified tables (card view)
- Swipeable charts

---

## 🔧 TECHNICAL REQUIREMENTS

### Tech Stack

```json
{
  "framework": "Next.js 15+",
  "react": "19.0.0",
  "typescript": "5.3+",
  "styling": "Tailwind CSS 3.4+",
  "backend": "Appwrite 1.6+",
  "charts": "Recharts or Chart.js",
  "maps": "Google Maps React or Mapbox GL",
  "icons": "Lucide React or Heroicons",
  "tables": "TanStack Table (React Table v8)",
  "forms": "React Hook Form + Zod",
  "notifications": "React Hot Toast",
  "deployment": "Vercel/Netlify (Static Export)"
}
```

### Required NPM Packages

```json
{
  "dependencies": {
    "next": "^15.0.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "typescript": "^5.3.0",
    "appwrite": "^14.0.0",
    "tailwindcss": "^3.4.0",
    "recharts": "^2.10.0",
    "react-hook-form": "^7.49.0",
    "zod": "^3.22.0",
    "lucide-react": "^0.300.0",
    "@tanstack/react-table": "^8.11.0",
    "react-hot-toast": "^2.4.1",
    "date-fns": "^3.0.0",
    "clsx": "^2.1.0",
    "tailwind-merge": "^2.2.0"
  }
}
```

### Appwrite Collections Schema

**1. users**
```json
{
  "userId": "string (ID)",
  "fullName": "string",
  "email": "string (unique)",
  "phone": "string",
  "employeeId": "string",
  "department": "string",
  "territory": "string",
  "role": "string",
  "profilePhoto": "string (URL)",
  "status": "string (active/inactive)",
  "createdAt": "datetime"
}
```

**2. shops**
```json
{
  "shopId": "string (ID)",
  "shopName": "string",
  "ownerName": "string",
  "category": "string",
  "address": "string",
  "latitude": "float",
  "longitude": "float",
  "contactNumber": "string",
  "photoUrl": "string",
  "assignedTo": "string (userId)",
  "priority": "string",
  "status": "string",
  "createdAt": "datetime"
}
```

**3. visits**
```json
{
  "visitId": "string (ID)",
  "shopId": "string",
  "userId": "string",
  "visitDate": "datetime",
  "visitPurpose": "string",
  "visitStatus": "string",
  "checkInTime": "datetime",
  "checkOutTime": "datetime",
  "latitude": "float",
  "longitude": "float",
  "photos": "array",
  "notes": "string",
  "orderValue": "float",
  "createdAt": "datetime"
}
```

**4. campaigns**
```json
{
  "campaignId": "string (ID)",
  "campaignName": "string",
  "description": "string",
  "startDate": "datetime",
  "endDate": "datetime",
  "status": "string",
  "bannerUrl": "string",
  "targetShops": "array",
  "assignedUsers": "array",
  "createdAt": "datetime"
}
```

**5. notifications**
```json
{
  "notificationId": "string (ID)",
  "userId": "string",
  "title": "string",
  "message": "string",
  "type": "string",
  "isRead": "boolean",
  "createdAt": "datetime"
}
```

**6. reports**
```json
{
  "reportId": "string (ID)",
  "userId": "string",
  "reportType": "string",
  "dateRange": "string",
  "data": "object",
  "fileUrl": "string",
  "createdAt": "datetime"
}
```

---

## 🚀 BUILD & DEPLOYMENT

### Next.js Configuration

**next.config.ts:**
```typescript
import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
  output: 'export', // Static export for Vercel/Netlify
  images: {
    unoptimized: true, // Required for static export
  },
  trailingSlash: true,
};

export default nextConfig;
```

### Environment Variables

Create `.env.local`:
```env
NEXT_PUBLIC_APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1
NEXT_PUBLIC_APPWRITE_PROJECT=your_project_id
NEXT_PUBLIC_APPWRITE_DATABASE=your_database_id
NEXT_PUBLIC_APPWRITE_USERS_COLLECTION=users_collection_id
NEXT_PUBLIC_APPWRITE_SHOPS_COLLECTION=shops_collection_id
NEXT_PUBLIC_APPWRITE_VISITS_COLLECTION=visits_collection_id
NEXT_PUBLIC_APPWRITE_CAMPAIGNS_COLLECTION=campaigns_collection_id
NEXT_PUBLIC_APPWRITE_NOTIFICATIONS_COLLECTION=notifications_collection_id
NEXT_PUBLIC_APPWRITE_REPORTS_COLLECTION=reports_collection_id
```

### Build Commands

```bash
# Install dependencies
npm install

# Development
npm run dev

# Build for production
npm run build

# Preview production build
npm run start
```

### Deployment to Vercel

1. Push code to GitHub
2. Import project to Vercel
3. Set root directory: `admin-web` (if in subdirectory)
4. Add environment variables
5. Deploy!

**Vercel Configuration (vercel.json):**
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "out",
  "framework": "nextjs",
  "regions": ["sin1"]
}
```

---

## 🎯 SUCCESS CRITERIA

The admin panel should:
✅ Have all screens and features listed above
✅ Be fully responsive (Desktop/Tablet/Mobile)
✅ Connect to Appwrite backend
✅ Have working authentication with role-based access
✅ Display real-time data with auto-refresh
✅ Include interactive charts and graphs
✅ Have data tables with sorting, filtering, pagination
✅ Support CRUD operations for all entities
✅ Include proper error handling
✅ Have loading states and skeletons
✅ Be production-ready with static export
✅ Follow modern design principles
✅ Have smooth animations and transitions
✅ Include proper TypeScript types
✅ Be optimized for performance

---

## 📝 IMPORTANT FEATURES

### Must-Have Features:
1. ✅ Real-time dashboard with live data
2. ✅ User management (CRUD operations)
3. ✅ Shop management (CRUD operations)
4. ✅ Visit tracking and approval
5. ✅ Live map with field force tracking
6. ✅ Campaign management
7. ✅ Reports and analytics
8. ✅ Role-based access control
9. ✅ Responsive design
10. ✅ Static export capability

### Nice-to-Have Features:
- Dark/Light theme toggle
- Export data in multiple formats
- Advanced filtering and search
- Bulk operations
- Activity logs
- Email notifications
- Scheduled reports
- Custom dashboards per role

---

## 🎨 UI COMPONENTS TO CREATE

### Reusable Components:
1. **Button** (Primary, Secondary, Danger, Ghost)
2. **Input** (Text, Email, Password, Number, Date)
3. **Select** (Dropdown, Multi-select)
4. **Checkbox** & **Radio**
5. **Table** (with sorting, filtering, pagination)
6. **Modal** (for forms and details)
7. **Toast** (success, error, info, warning)
8. **Card** (with variants)
9. **Badge** (status indicators)
10. **Avatar** (user photos)
11. **Stat Card** (metrics display)
12. **Chart** (Line, Bar, Pie, Area)
13. **Map** (with markers and controls)
14. **Sidebar** (collapsible navigation)
15. **TopBar** (header with search)
16. **Loading Spinner** & **Skeleton**
17. **Empty State** (no data illustrations)
18. **Form** (with validation)
19. **DatePicker** & **DateRangePicker**
20. **File Upload** (drag & drop)

---

## 🔥 PRIORITY IMPLEMENTATION

**Phase 1 (Core MVP):**
1. Authentication (Login/Logout)
2. Dashboard with key metrics
3. Users list and detail view
4. Shops list and detail view
5. Visits list and detail view

**Phase 2 (Advanced Features):**
6. Live map tracking
7. Campaign management
8. Reports and analytics
9. Notifications center
10. Settings page

**Phase 3 (Polish):**
11. Advanced filtering and search
12. Export functionality
13. Bulk operations
14. Activity logs
15. Performance optimization

---

## ✅ FINAL CHECKLIST

Before delivering:
- [ ] All pages are created and working
- [ ] Navigation works correctly
- [ ] Appwrite integration is complete
- [ ] Authentication with role-based access works
- [ ] Data tables have sorting, filtering, pagination
- [ ] Forms have proper validation
- [ ] Charts display correct data
- [ ] Live map shows real-time locations
- [ ] CRUD operations work for all entities
- [ ] Responsive design on all screen sizes
- [ ] Loading states and errors handled
- [ ] Static export builds successfully
- [ ] Environment variables configured
- [ ] TypeScript has no errors
- [ ] Code is clean and documented
- [ ] Performance is optimized

---

## 🎯 EXPECTED OUTPUT

A complete, production-ready Next.js admin panel that:
- ✅ Can be deployed to Vercel/Netlify in minutes
- ✅ Manages all aspects of field force operations
- ✅ Provides real-time tracking and analytics
- ✅ Has professional UI/UX with modern design
- ✅ Works on all devices (desktop, tablet, mobile)
- ✅ Connects seamlessly to Appwrite backend
- ✅ Includes all features mentioned above
- ✅ Is ready for production use

---

**BUILD THIS ADMIN PANEL NOW!** 🚀

Generate the complete Next.js project with:
1. ✅ Full folder structure (app router)
2. ✅ All TypeScript files
3. ✅ Tailwind CSS configuration
4. ✅ Appwrite integration
5. ✅ Reusable components
6. ✅ All pages and features
7. ✅ Static export configuration
8. ✅ README with deployment instructions

Make it production-ready, responsive, and beautiful! 🎨

---

END OF PROMPT ✅

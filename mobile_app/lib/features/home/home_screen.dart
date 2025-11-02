import 'package:flutter/material.dart';
import '../../core/auth_service.dart';
import '../../core/attendance_service.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _authService = AuthService();
  final _attendanceService = AttendanceService();
  bool _isCheckedIn = false;

  final List<Widget> _screens = [
    DashboardTab(),
    TasksTab(),
    AttendanceTab(),
    ProfileTab(),
  ];

  Future<void> _handleCheckIn() async {
    final user = await _authService.getCurrentUser();
    if (user == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color(0xFF121A33),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Color(0xFF2E5BFF)),
              SizedBox(height: 16),
              Text(
                'চেক-ইন করা হচ্ছে...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );

    final result = await _attendanceService.checkIn(user.$id);
    Navigator.pop(context);

    if (result != null) {
      setState(() => _isCheckedIn = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('✅ চেক-ইন সফল হয়েছে'),
            ],
          ),
          backgroundColor: Color(0xFF00C2A8),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 12),
              Text('❌ চেক-ইন ব্যর্থ হয়েছে'),
            ],
          ),
          backgroundColor: Color(0xFFE53935),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E5BFF), Color(0xFF00C2A8)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.location_on, size: 20, color: Colors.white),
            ),
            SizedBox(width: 12),
            Text('MarketTrack', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          // Online/Offline Indicator
          Container(
            margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFF00C2A8).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFF00C2A8)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF00C2A8),
                  ),
                ),
                SizedBox(width: 6),
                Text('অনলাইন', style: TextStyle(fontSize: 12, color: Color(0xFF00C2A8))),
              ],
            ),
          ),
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF8A00),
                      shape: BoxShape.circle,
                    ),
                    child: Text('3', style: TextStyle(fontSize: 8)),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF2E5BFF),
          unselectedItemColor: Color(0xFF7A8189),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'হোম',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined),
              activeIcon: Icon(Icons.task),
              label: 'কাজ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'উপস্থিতি',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'প্রোফাইল',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isCheckedIn ? null : _handleCheckIn,
        icon: Icon(_isCheckedIn ? Icons.check : Icons.login, color: Colors.white),
        label: Text(
          _isCheckedIn ? 'চেক-ইন সম্পন্ন' : 'চেক-ইন',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _isCheckedIn ? Colors.grey : Color(0xFF2E5BFF),
        elevation: 8,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF121A33),
              Color(0xFF0B1020),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E5BFF), Color(0xFF00C2A8)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Color(0xFF2E5BFF)),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'ফিল্ড ইউজার',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'user@example.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, 'হোম', () => Navigator.pop(context)),
            _buildDrawerItem(Icons.map, 'ম্যাপ ভিউ', () {}),
            _buildDrawerItem(Icons.report, 'রিপোর্ট', () {}),
            _buildDrawerItem(Icons.language, 'ভাষা পরিবর্তন', () {}),
            _buildDrawerItem(Icons.settings, 'সেটিংস', () {}),
            _buildDrawerItem(Icons.help_outline, 'সাহায্য', () {}),
            Divider(color: Colors.white24),
            _buildDrawerItem(
              Icons.logout,
              'লগআউট',
              () async {
                await _authService.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
              color: Color(0xFFE53935),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.white70),
      title: Text(title, style: TextStyle(color: color ?? Colors.white)),
      onTap: onTap,
      hoverColor: Colors.white.withOpacity(0.05),
    );
  }
}

// Dashboard Tab with Cards
class DashboardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📊 ড্যাশবোর্ড',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'আজকের অবস্থা',
            style: TextStyle(color: Colors.grey[400]),
          ),
          SizedBox(height: 20),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  '✅ চেক-ইন',
                  '9:00 AM',
                  Color(0xFF00C2A8),
                  Icons.login,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  context,
                  '📍 লোকেশন',
                  'ঢাকা',
                  Color(0xFF2E5BFF),
                  Icons.location_on,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  '✏️ কাজ',
                  '৫টি বাকি',
                  Color(0xFFFF8A00),
                  Icons.task_alt,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  context,
                  '📸 রিপোর্ট',
                  '১২টি',
                  Color(0xFF9C27B0),
                  Icons.photo_library,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Recent Activity
          Text(
            '📌 সাম্প্রতিক কার্যক্রম',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _buildActivityCard('চেক-ইন সম্পন্ন', '৫ মিনিট আগে', Icons.check_circle, Color(0xFF00C2A8)),
          _buildActivityCard('নতুন কাজ পাওয়া গেছে', '১৫ মিনিট আগে', Icons.task, Color(0xFF2E5BFF)),
          _buildActivityCard('রিপোর্ট জমা দেওয়া হয়েছে', '৩০ মিনিট আগে', Icons.upload, Color(0xFFFF8A00)),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF121A33),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(String title, String time, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF121A33),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text(time, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[600]),
        ],
      ),
    );
  }
}

// Tasks Tab
class TasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 80, color: Colors.grey[600]),
          SizedBox(height: 16),
          Text('কাজের তালিকা শীঘ্রই আসছে', style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }
}

// Attendance Tab
class AttendanceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, size: 80, color: Colors.grey[600]),
          SizedBox(height: 16),
          Text('উপস্থিতির ক্যালেন্ডার শীঘ্রই আসছে', style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }
}

// Profile Tab
class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Colors.grey[600]),
          SizedBox(height: 16),
          Text('প্রোফাইল পেজ শীঘ্রই আসছে', style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }
}

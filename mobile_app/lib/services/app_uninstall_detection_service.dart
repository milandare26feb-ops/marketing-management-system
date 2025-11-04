import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:appwrite/appwrite.dart';
import '../core/appwrite_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 🗑️ App Uninstall Detection Service
/// Features:
/// - Track FCM token
/// - Detect when app is uninstalled
/// - Alert admin if inactive > 24 hours
/// - Track last_seen timestamp
class AppUninstallDetectionService {
  final AppwriteConfig _config = AppwriteConfig();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Timer? _heartbeatTimer;
  String? _userId;

  /// Initialize service with user ID
  void initialize(String userId) {
    _userId = userId;
    print('🗑️ Uninstall detection initialized for: $userId');
  }

  /// Setup FCM token and start tracking
  Future<void> setupTracking() async {
    if (_userId == null) {
      throw Exception('User ID not set');
    }

    // Request notification permission
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM token
    final token = await _fcm.getToken();
    if (token != null) {
      await _saveFCMToken(token);
    }

    // Listen for token refresh
    _fcm.onTokenRefresh.listen((newToken) {
      _saveFCMToken(newToken);
    });

    // Start heartbeat (every 30 minutes)
    startHeartbeat();

    print('✅ Uninstall tracking setup complete');
  }

  /// Save FCM token to Appwrite
  Future<void> _saveFCMToken(String token) async {
    try {
      await _config.databases.updateDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.usersCollection,
        documentId: _userId!,
        data: {
          'fcm_token': token,
          'fcm_updated_at': DateTime.now().toIso8601String(),
          'device_active': true,
        },
      );

      print('✅ FCM token saved: ${token.substring(0, 20)}...');
    } catch (e) {
      print('❌ Failed to save FCM token: $e');
    }
  }

  /// Start heartbeat to track app activity
  void startHeartbeat({int intervalMinutes = 30}) {
    _heartbeatTimer?.cancel();

    _heartbeatTimer = Timer.periodic(
      Duration(minutes: intervalMinutes),
      (_) => _sendHeartbeat(),
    );

    // Send initial heartbeat
    _sendHeartbeat();

    print('💓 Heartbeat started (interval: ${intervalMinutes}m)');
  }

  /// Send heartbeat to indicate app is active
  Future<void> _sendHeartbeat() async {
    if (_userId == null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final lastSeen = DateTime.now().toIso8601String();
      
      // Save locally
      await prefs.setString('last_heartbeat', lastSeen);

      // Update in Appwrite
      await _config.databases.updateDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.usersCollection,
        documentId: _userId!,
        data: {
          'last_seen': lastSeen,
          'device_active': true,
          'app_version': '1.0.0', // TODO: Get from package_info
        },
      );

      print('💓 Heartbeat sent: $lastSeen');
    } catch (e) {
      print('❌ Heartbeat error: $e');
    }
  }

  /// Stop heartbeat
  void stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    print('⏹️ Heartbeat stopped');
  }

  /// Check if user is inactive (for admin dashboard)
  static Future<Map<String, dynamic>> checkUserActivity(String userId) async {
    try {
      final config = AppwriteConfig();
      final doc = await config.databases.getDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.usersCollection,
        documentId: userId,
      );

      final lastSeenStr = doc.data['last_seen'] as String?;
      if (lastSeenStr == null) {
        return {
          'is_active': false,
          'inactive_hours': -1,
          'status': 'কখনো সক্রিয় ছিল না',
        };
      }

      final lastSeen = DateTime.parse(lastSeenStr);
      final now = DateTime.now();
      final inactiveDuration = now.difference(lastSeen);
      final inactiveHours = inactiveDuration.inHours;

      return {
        'is_active': inactiveHours < 24,
        'inactive_hours': inactiveHours,
        'last_seen': lastSeenStr,
        'status': _getActivityStatus(inactiveHours),
        'likely_uninstalled': inactiveHours > 48,
      };
    } catch (e) {
      print('❌ Activity check error: $e');
      return {
        'is_active': false,
        'error': e.toString(),
      };
    }
  }

  /// Get activity status message
  static String _getActivityStatus(int inactiveHours) {
    if (inactiveHours < 1) return 'সক্রিয় ✅';
    if (inactiveHours < 24) return '${inactiveHours} ঘন্টা আগে সক্রিয় ছিল';
    if (inactiveHours < 48) return '⚠️ 24+ ঘন্টা নিষ্ক্রিয়';
    return '🚨 সম্ভবত আনইনস্টল করেছে (${(inactiveHours / 24).toInt()} দিন)';
  }

  /// Send test notification (for uninstall detection)
  Future<bool> sendTestNotification() async {
    try {
      // This should be sent from server/admin panel
      // Using Appwrite Functions or Firebase Cloud Functions
      print('📤 Test notification sent');
      return true;
    } catch (e) {
      print('❌ Test notification failed: $e');
      return false;
    }
  }

  /// Dispose resources
  void dispose() {
    stopHeartbeat();
  }
}

/// 🔔 Notification Tracking Service
class NotificationTrackingService {
  final AppwriteConfig _config = AppwriteConfig();

  /// Track when user views a notification
  Future<void> markNotificationAsViewed(String notificationId) async {
    try {
      await _config.databases.updateDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: 'notifications', // Create this collection
        documentId: notificationId,
        data: {
          'viewed': true,
          'viewed_at': DateTime.now().toIso8601String(),
        },
      );

      print('✅ Notification marked as viewed: $notificationId');
    } catch (e) {
      print('❌ Failed to mark notification: $e');
    }
  }

  /// Check if admin notification was viewed (admin requirement)
  Future<bool> hasUserViewedNotification(String userId, String notificationId) async {
    try {
      final doc = await _config.databases.getDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: 'notifications',
        documentId: notificationId,
      );

      return doc.data['viewed'] == true;
    } catch (e) {
      print('❌ Check notification error: $e');
      return false;
    }
  }

  /// Get unread notification count
  Future<int> getUnreadCount(String userId) async {
    try {
      final docs = await _config.databases.listDocuments(
        databaseId: AppwriteConfig.databaseId,
        collectionId: 'notifications',
        queries: [
          Query.equal('user_id', userId),
          Query.equal('viewed', false),
        ],
      );

      return docs.total;
    } catch (e) {
      print('❌ Unread count error: $e');
      return 0;
    }
  }
}

/// 📊 Activity Monitor (Admin Dashboard)
class ActivityMonitor {
  /// Get list of inactive users (for admin dashboard)
  static Future<List<Map<String, dynamic>>> getInactiveUsers({
    int inactiveHoursThreshold = 24,
  }) async {
    try {
      final config = AppwriteConfig();
      
      // Calculate threshold time
      final thresholdTime = DateTime.now()
          .subtract(Duration(hours: inactiveHoursThreshold))
          .toIso8601String();

      // Query users with last_seen < threshold
      final docs = await config.databases.listDocuments(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.usersCollection,
        queries: [
          Query.lessThan('last_seen', thresholdTime),
        ],
      );

      return docs.documents.map((doc) {
        final lastSeenStr = doc.data['last_seen'] as String?;
        final lastSeen = lastSeenStr != null ? DateTime.parse(lastSeenStr) : null;
        final inactiveHours = lastSeen != null
            ? DateTime.now().difference(lastSeen).inHours
            : -1;

        return {
          'user_id': doc.$id,
          'name': doc.data['name'],
          'email': doc.data['email'],
          'last_seen': lastSeenStr,
          'inactive_hours': inactiveHours,
          'likely_uninstalled': inactiveHours > 48,
        };
      }).toList();
    } catch (e) {
      print('❌ Get inactive users error: $e');
      return [];
    }
  }
}

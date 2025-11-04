import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../core/appwrite_config.dart';
import 'dart:io';

/// 📊 Real-time Device Monitoring Service
/// Features:
/// - Battery level monitoring
/// - GPS status tracking
/// - Phone on/off detection
/// - Network connectivity
/// - Send realtime data to admin dashboard
class DeviceMonitoringService {
  final AppwriteConfig _config = AppwriteConfig();
  final Battery _battery = Battery();
  Timer? _monitoringTimer;
  String? _userId;

  /// Initialize monitoring for user
  void initialize(String userId) {
    _userId = userId;
    print('📊 Monitoring initialized for user: $userId');
  }

  /// Start real-time monitoring (every 5 minutes)
  void startMonitoring({int intervalMinutes = 5}) {
    if (_userId == null) {
      throw Exception('User ID not set. Call initialize() first.');
    }

    _monitoringTimer?.cancel();
    
    _monitoringTimer = Timer.periodic(
      Duration(minutes: intervalMinutes),
      (_) => _collectAndSendMonitoringData(),
    );

    // Send initial data immediately
    _collectAndSendMonitoringData();
    
    print('✅ Monitoring started (interval: ${intervalMinutes}m)');
  }

  /// Stop monitoring
  void stopMonitoring() {
    _monitoringTimer?.cancel();
    _monitoringTimer = null;
    print('⏹️ Monitoring stopped');
  }

  /// Collect all monitoring data
  Future<Map<String, dynamic>> _collectAndSendMonitoringData() async {
    try {
      final data = await collectDeviceStatus();
      
      // Send to Appwrite Realtime
      await _sendToAppwrite(data);
      
      // Check for alerts
      await _checkAndSendAlerts(data);
      
      return data;
    } catch (e) {
      print('❌ Monitoring error: $e');
      return {};
    }
  }

  /// Collect comprehensive device status
  Future<Map<String, dynamic>> collectDeviceStatus() async {
    final battery = await _getBatteryStatus();
    final location = await _getLocationStatus();
    final network = await _getNetworkStatus();
    final device = await _getDeviceInfo();

    return {
      'user_id': _userId,
      'timestamp': DateTime.now().toIso8601String(),
      'battery': battery,
      'location': location,
      'network': network,
      'device': device,
    };
  }

  /// Get battery status
  Future<Map<String, dynamic>> _getBatteryStatus() async {
    try {
      final batteryLevel = await _battery.batteryLevel;
      final batteryState = await _battery.batteryState;
      
      return {
        'level': batteryLevel,
        'state': batteryState.toString().split('.').last,
        'is_charging': batteryState == BatteryState.charging,
        'is_low': batteryLevel < 20,
        'is_critical': batteryLevel < 10,
      };
    } catch (e) {
      print('❌ Battery error: $e');
      return {'level': -1, 'error': e.toString()};
    }
  }

  /// Get GPS/Location status
  Future<Map<String, dynamic>> _getLocationStatus() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      
      Position? position;
      if (serviceEnabled) {
        try {
          position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 5),
          );
        } catch (e) {
          print('⚠️ Could not get position: $e');
        }
      }

      return {
        'service_enabled': serviceEnabled,
        'has_position': position != null,
        'latitude': position?.latitude,
        'longitude': position?.longitude,
        'accuracy': position?.accuracy,
        'is_mocked': position?.isMocked ?? false,
        'timestamp': position?.timestamp?.toIso8601String(),
      };
    } catch (e) {
      print('❌ Location error: $e');
      return {'service_enabled': false, 'error': e.toString()};
    }
  }

  /// Get network connectivity status
  Future<Map<String, dynamic>> _getNetworkStatus() async {
    try {
      final connectivity = Connectivity();
      final result = await connectivity.checkConnectivity();
      
      return {
        'is_connected': result != ConnectivityResult.none,
        'type': result.toString().split('.').last,
        'is_mobile': result == ConnectivityResult.mobile,
        'is_wifi': result == ConnectivityResult.wifi,
        'is_vpn': result == ConnectivityResult.vpn,
      };
    } catch (e) {
      print('❌ Network error: $e');
      return {'is_connected': false, 'error': e.toString()};
    }
  }

  /// Get device information
  Future<Map<String, dynamic>> _getDeviceInfo() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return {
          'platform': 'Android',
          'model': androidInfo.model,
          'version': androidInfo.version.release,
          'sdk': androidInfo.version.sdkInt,
          'manufacturer': androidInfo.manufacturer,
          'is_physical': androidInfo.isPhysicalDevice,
        };
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return {
          'platform': 'iOS',
          'model': iosInfo.model,
          'version': iosInfo.systemVersion,
          'name': iosInfo.name,
          'is_physical': iosInfo.isPhysicalDevice,
        };
      }
      
      return {'platform': 'Unknown'};
    } catch (e) {
      print('❌ Device info error: $e');
      return {'error': e.toString()};
    }
  }

  /// Send data to Appwrite database
  Future<void> _sendToAppwrite(Map<String, dynamic> data) async {
    try {
      await _config.databases.createDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: 'device_monitoring', // Create this collection
        documentId: 'unique()',
        data: data,
      );
      
      print('✅ Monitoring data sent to Appwrite');
    } catch (e) {
      print('❌ Failed to send to Appwrite: $e');
    }
  }

  /// Check for alerts and send to admin
  Future<void> _checkAndSendAlerts(Map<String, dynamic> data) async {
    final alerts = <String>[];

    // Battery alerts
    final battery = data['battery'] as Map<String, dynamic>;
    if (battery['is_critical'] == true) {
      alerts.add('🔋 ব্যাটারি সংকটজনক: ${battery['level']}%');
    }

    // Location alerts
    final location = data['location'] as Map<String, dynamic>;
    if (location['service_enabled'] == false) {
      alerts.add('📍 GPS বন্ধ আছে');
    }
    if (location['is_mocked'] == true) {
      alerts.add('⚠️ ফেক লোকেশন সনাক্ত');
    }

    // Network alerts
    final network = data['network'] as Map<String, dynamic>;
    if (network['is_vpn'] == true) {
      alerts.add('🔒 VPN সনাক্ত করা হয়েছে');
    }
    if (network['is_connected'] == false) {
      alerts.add('📶 ইন্টারনেট সংযোগ নেই');
    }

    // Device alerts
    final device = data['device'] as Map<String, dynamic>;
    if (device['is_physical'] == false) {
      alerts.add('⚠️ এমুলেটর/সিমুলেটর সনাক্ত');
    }

    if (alerts.isNotEmpty) {
      await _sendAlertsToAdmin(alerts, data);
    }
  }

  /// Send alerts to admin via Appwrite Realtime
  Future<void> _sendAlertsToAdmin(List<String> alerts, Map<String, dynamic> data) async {
    try {
      await _config.databases.createDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: 'monitoring_alerts', // Create this collection
        documentId: 'unique()',
        data: {
          'user_id': _userId,
          'alerts': alerts,
          'severity': alerts.length > 2 ? 'high' : 'medium',
          'timestamp': DateTime.now().toIso8601String(),
          'device_data': data,
        },
      );
      
      print('🚨 Alerts sent to admin: ${alerts.join(', ')}');
    } catch (e) {
      print('❌ Failed to send alerts: $e');
    }
  }

  /// Get current status summary
  Future<String> getStatusSummary() async {
    final data = await collectDeviceStatus();
    
    final battery = data['battery'] as Map<String, dynamic>;
    final location = data['location'] as Map<String, dynamic>;
    final network = data['network'] as Map<String, dynamic>;

    return '''
📊 ডিভাইস স্ট্যাটাস:
🔋 ব্যাটারি: ${battery['level']}% ${battery['is_charging'] ? '⚡' : ''}
📍 GPS: ${location['service_enabled'] ? '✅' : '❌'}
📶 নেটওয়ার্ক: ${network['type']}
⏰ সময়: ${DateTime.now().toString().substring(11, 16)}
''';
  }

  /// Dispose resources
  void dispose() {
    stopMonitoring();
  }
}

/// 📱 Phone Status Detector
class PhoneStatusDetector {
  static bool _isAppInBackground = false;

  /// Detect if app is in background/foreground
  static void setAppState(bool isBackground) {
    _isAppInBackground = isBackground;
    print(isBackground ? '⏸️ App in background' : '▶️ App in foreground');
  }

  /// Check if app is active
  static bool get isActive => !_isAppInBackground;

  /// Detect phone lock/unlock (requires lifecycle observer)
  static Future<void> onPhoneLocked() async {
    print('🔒 Phone locked detected');
    // TODO: Send to monitoring service
  }

  static Future<void> onPhoneUnlocked() async {
    print('🔓 Phone unlocked detected');
    // TODO: Send to monitoring service
  }
}

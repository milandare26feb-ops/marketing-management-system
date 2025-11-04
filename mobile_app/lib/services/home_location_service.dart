import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/appwrite_config.dart';
import 'dart:convert';

/// 🏠 Home Location Auto-Detection Service
/// Algorithm:
/// 1. Track location at 3:00 AM for 3 consecutive days
/// 2. If user is at same location (±50m radius) for 3 days, mark as home
/// 3. Auto-set home location without user intervention
/// 4. Use for fake check-in detection
class HomeLocationService {
  final AppwriteConfig _config = AppwriteConfig();
  static const String _homeLocationKey = 'home_location';
  static const String _trackingDataKey = 'location_tracking_data';
  static const double _homeRadiusMeters = 50.0; // 50 meters tolerance

  /// Start background location tracking at 3 AM
  Future<void> initializeBackgroundTracking() async {
    // This should be called from a background task scheduler
    // Use flutter_background_service or workmanager package
    
    final now = DateTime.now();
    final target3AM = DateTime(now.year, now.month, now.day, 3, 0, 0);
    
    // If already past 3 AM today, schedule for tomorrow
    final nextRun = now.isAfter(target3AM)
        ? target3AM.add(Duration(days: 1))
        : target3AM;
    
    print('🕒 Next tracking scheduled at: $nextRun');
    
    // TODO: Implement with flutter_background_service
    // For now, this is a placeholder
  }

  /// Track location at 3 AM (called by background service)
  Future<void> track3AMLocation() async {
    try {
      // Check if it's approximately 3 AM (±15 minutes)
      final now = DateTime.now();
      if (now.hour != 3 || now.minute > 15) {
        print('⚠️ Not tracking time (must be 3:00-3:15 AM)');
        return;
      }

      // Get current location
      final position = await _getCurrentLocation();
      if (position == null) return;

      // Save tracking data
      await _saveTrackingData(position);

      // Check if we have 3 days of data
      final trackingData = await _getTrackingData();
      if (trackingData.length >= 3) {
        await _analyzeAndSetHomeLocation(trackingData);
      }

      print('✅ Location tracked: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('❌ Tracking error: $e');
    }
  }

  /// Get current GPS location
  Future<Position?> _getCurrentLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('❌ Location error: $e');
      return null;
    }
  }

  /// Save tracking data locally
  Future<void> _saveTrackingData(Position position) async {
    final prefs = await SharedPreferences.getInstance();
    
    final data = {
      'lat': position.latitude,
      'lng': position.longitude,
      'timestamp': DateTime.now().toIso8601String(),
      'accuracy': position.accuracy,
    };

    // Get existing data
    final existingDataJson = prefs.getStringList(_trackingDataKey) ?? [];
    
    // Add new data
    existingDataJson.add(jsonEncode(data));
    
    // Keep only last 7 days of data
    if (existingDataJson.length > 7) {
      existingDataJson.removeAt(0);
    }

    await prefs.setStringList(_trackingDataKey, existingDataJson);
  }

  /// Get tracking data
  Future<List<Map<String, dynamic>>> _getTrackingData() async {
    final prefs = await SharedPreferences.getInstance();
    final dataList = prefs.getStringList(_trackingDataKey) ?? [];
    
    return dataList.map((json) {
      return jsonDecode(json) as Map<String, dynamic>;
    }).toList();
  }

  /// Analyze tracking data and set home location
  Future<void> _analyzeAndSetHomeLocation(List<Map<String, dynamic>> trackingData) async {
    if (trackingData.length < 3) return;

    // Get last 3 tracking points
    final last3 = trackingData.sublist(trackingData.length - 3);

    // Check if all 3 points are within home radius
    final firstPoint = last3[0];
    final firstLat = firstPoint['lat'] as double;
    final firstLng = firstPoint['lng'] as double;

    bool allWithinRadius = true;
    for (var i = 1; i < last3.length; i++) {
      final lat = last3[i]['lat'] as double;
      final lng = last3[i]['lng'] as double;

      final distance = Geolocator.distanceBetween(
        firstLat,
        firstLng,
        lat,
        lng,
      );

      if (distance > _homeRadiusMeters) {
        allWithinRadius = false;
        break;
      }
    }

    if (allWithinRadius) {
      // Calculate center point (average)
      final avgLat = last3.map((p) => p['lat'] as double).reduce((a, b) => a + b) / 3;
      final avgLng = last3.map((p) => p['lng'] as double).reduce((a, b) => a + b) / 3;

      await _setHomeLocation(avgLat, avgLng);
      print('🏠 Home location auto-detected and set!');
    } else {
      print('⚠️ Locations not consistent, continue tracking...');
    }
  }

  /// Set home location in Appwrite and local storage
  Future<void> _setHomeLocation(double lat, double lng) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Save locally
      await prefs.setString(_homeLocationKey, jsonEncode({
        'lat': lat,
        'lng': lng,
        'set_at': DateTime.now().toIso8601String(),
      }));

      // Update in Appwrite
      final account = _config.account;
      final user = await account.get();
      
      await _config.databases.updateDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.usersCollection,
        documentId: user.$id,
        data: {
          'home_latitude': lat,
          'home_longitude': lng,
          'home_set_at': DateTime.now().toIso8601String(),
        },
      );

      print('✅ Home location saved to Appwrite');
    } catch (e) {
      print('❌ Failed to save home location: $e');
    }
  }

  /// Get home location
  Future<Map<String, double>?> getHomeLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final homeJson = prefs.getString(_homeLocationKey);
    
    if (homeJson == null) return null;
    
    final data = jsonDecode(homeJson);
    return {
      'lat': data['lat'],
      'lng': data['lng'],
    };
  }

  /// Check if location is near home
  Future<bool> isNearHome(double currentLat, double currentLng, {double radiusMeters = 100.0}) async {
    final home = await getHomeLocation();
    if (home == null) return false;

    final distance = Geolocator.distanceBetween(
      home['lat']!,
      home['lng']!,
      currentLat,
      currentLng,
    );

    return distance <= radiusMeters;
  }

  /// Reset home location (admin only)
  Future<void> resetHomeLocation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_homeLocationKey);
    await prefs.remove(_trackingDataKey);
    print('🗑️ Home location reset');
  }

  /// Get tracking status
  Future<Map<String, dynamic>> getTrackingStatus() async {
    final trackingData = await _getTrackingData();
    final home = await getHomeLocation();
    
    return {
      'has_home': home != null,
      'tracking_days': trackingData.length,
      'needs_days': 3 - trackingData.length,
      'home_location': home,
      'last_tracked': trackingData.isNotEmpty
          ? trackingData.last['timestamp']
          : null,
    };
  }
}

/// 🚫 Fake Check-in Detection Service
class FakeCheckinDetectionService {
  final HomeLocationService _homeService = HomeLocationService();
  static const double _validCheckinRadiusMeters = 200.0; // 200m from assigned location

  /// Validate check-in location
  Future<Map<String, dynamic>> validateCheckin({
    required double userLat,
    required double userLng,
    required double targetLat,
    required double targetLng,
  }) async {
    final violations = <String>[];
    
    // 1. Check distance from target location
    final distance = Geolocator.distanceBetween(
      userLat,
      userLng,
      targetLat,
      targetLng,
    );

    if (distance > _validCheckinRadiusMeters) {
      violations.add('চেক-ইন পয়েন্ট থেকে ${distance.toInt()}m দূরে (সর্বোচ্চ ${_validCheckinRadiusMeters.toInt()}m)');
    }

    // 2. Check if user is at home (suspicious for field work)
    final isAtHome = await _homeService.isNearHome(userLat, userLng);
    if (isAtHome) {
      violations.add('আপনি বাড়িতে আছেন - ফিল্ড চেক-ইন অবৈধ');
    }

    // 3. Check location accuracy
    final position = await Geolocator.getCurrentPosition();
    if (position.accuracy > 50) {
      violations.add('GPS নির্ভুলতা কম (${position.accuracy.toInt()}m)');
    }

    // 4. Check if mock location is enabled (Android)
    if (position.isMocked) {
      violations.add('⚠️ ফেক লোকেশন সনাক্ত করা হয়েছে!');
    }

    // 5. Check timestamp manipulation
    final now = DateTime.now();
    final deviceTime = position.timestamp;
    if (deviceTime != null) {
      final timeDiff = now.difference(deviceTime).abs().inMinutes;
      if (timeDiff > 5) {
        violations.add('ডিভাইস সময় ${timeDiff} মিনিট ভুল');
      }
    }

    return {
      'is_valid': violations.isEmpty,
      'distance_meters': distance.toInt(),
      'is_at_home': isAtHome,
      'accuracy': position.accuracy,
      'is_mocked': position.isMocked,
      'violations': violations,
      'risk_level': _calculateRiskLevel(violations.length),
    };
  }

  /// Calculate risk level
  String _calculateRiskLevel(int violationCount) {
    if (violationCount == 0) return 'নিরাপদ ✅';
    if (violationCount == 1) return 'সতর্ক ⚠️';
    return 'উচ্চ ঝুঁকি 🚨';
  }

  /// Detect VPN usage (basic check)
  Future<bool> isVPNActive() async {
    // TODO: Implement VPN detection
    // Check for VPN network interfaces
    // Use connectivity_plus package
    return false; // Placeholder
  }

  /// Detect root/jailbreak (security check)
  Future<bool> isDeviceCompromised() async {
    // TODO: Implement root detection
    // Use flutter_jailbreak_detection package
    return false; // Placeholder
  }

  /// Create check-in report with fraud detection
  Future<Map<String, dynamic>> createSecureCheckin({
    required double userLat,
    required double userLng,
    required double targetLat,
    required double targetLng,
    required String userId,
  }) async {
    final validation = await validateCheckin(
      userLat: userLat,
      userLng: userLng,
      targetLat: targetLat,
      targetLng: targetLng,
    );

    final isVPN = await isVPNActive();
    final isRooted = await isDeviceCompromised();

    return {
      ...validation,
      'vpn_detected': isVPN,
      'device_rooted': isRooted,
      'timestamp': DateTime.now().toIso8601String(),
      'user_id': userId,
      'should_block': !validation['is_valid'] || isVPN || isRooted,
    };
  }
}

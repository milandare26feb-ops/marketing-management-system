import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// 🔒 Permission Lock Service
/// Once permissions are granted, user cannot disable them
/// Features:
/// - Detect permission revocation
/// - Lock app until permissions restored
/// - Alert admin when permissions disabled
class PermissionLockService {
  static const String _permissionStatusKey = 'permission_lock_status';
  
  /// Required permissions for app
  static const List<Permission> requiredPermissions = [
    Permission.location,
    Permission.locationAlways,
    Permission.camera,
    Permission.storage,
    Permission.notification,
  ];

  /// Request all required permissions
  Future<Map<Permission, PermissionStatus>> requestAllPermissions() async {
    final statuses = <Permission, PermissionStatus>{};
    
    for (var permission in requiredPermissions) {
      final status = await permission.request();
      statuses[permission] = status;
    }

    // Save granted permissions
    await _savePermissionLock(statuses);
    
    return statuses;
  }

  /// Check if all required permissions are granted
  Future<bool> areAllPermissionsGranted() async {
    for (var permission in requiredPermissions) {
      final status = await permission.status;
      if (!status.isGranted && permission != Permission.locationAlways) {
        return false;
      }
    }
    return true;
  }

  /// Save permission lock (once granted, cannot be revoked)
  Future<void> _savePermissionLock(Map<Permission, PermissionStatus> statuses) async {
    final prefs = await SharedPreferences.getInstance();
    
    final data = {
      'granted_at': DateTime.now().toIso8601String(),
      'permissions': statuses.map(
        (key, value) => MapEntry(key.toString(), value.isGranted),
      ),
    };

    await prefs.setString(_permissionStatusKey, jsonEncode(data));
  }

  /// Check if permissions were previously granted (lock status)
  Future<bool> werePermissionsGrantedBefore() async {
    final prefs = await SharedPreferences.getInstance();
    final lockJson = prefs.getString(_permissionStatusKey);
    
    if (lockJson == null) return false;
    
    final data = jsonDecode(lockJson);
    final permissions = data['permissions'] as Map<String, dynamic>;
    
    // If any permission was granted before, lock is active
    return permissions.values.any((granted) => granted == true);
  }

  /// Detect permission revocation (user disabled after granting)
  Future<Map<String, dynamic>> detectPermissionViolation() async {
    final wereGranted = await werePermissionsGrantedBefore();
    if (!wereGranted) {
      return {
        'has_violation': false,
        'message': 'কোন লক নেই',
      };
    }

    final currentStatus = await areAllPermissionsGranted();
    
    if (!currentStatus) {
      // Violation detected!
      final missingPermissions = <String>[];
      
      for (var permission in requiredPermissions) {
        final status = await permission.status;
        if (!status.isGranted) {
          missingPermissions.add(_getPermissionName(permission));
        }
      }

      return {
        'has_violation': true,
        'missing_permissions': missingPermissions,
        'message': '⚠️ আপনি অনুমতি বন্ধ করেছেন! অ্যাপ ব্যবহার করতে পুনরায় চালু করুন।',
        'detected_at': DateTime.now().toIso8601String(),
      };
    }

    return {
      'has_violation': false,
      'message': 'সব অনুমতি সক্রিয় ✅',
    };
  }

  /// Get Bengali permission name
  String _getPermissionName(Permission permission) {
    switch (permission) {
      case Permission.location:
        return 'লোকেশন';
      case Permission.locationAlways:
        return 'সর্বদা লোকেশন';
      case Permission.camera:
        return 'ক্যামেরা';
      case Permission.storage:
        return 'স্টোরেজ';
      case Permission.notification:
        return 'নোটিফিকেশন';
      default:
        return permission.toString();
    }
  }

  /// Open app settings for user to re-enable permissions
  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  /// Get permission status summary
  Future<Map<String, dynamic>> getPermissionSummary() async {
    final summary = <String, bool>{};
    
    for (var permission in requiredPermissions) {
      final status = await permission.status;
      summary[_getPermissionName(permission)] = status.isGranted;
    }

    final allGranted = await areAllPermissionsGranted();
    final wereGranted = await werePermissionsGrantedBefore();

    return {
      'all_granted': allGranted,
      'lock_active': wereGranted,
      'permissions': summary,
      'has_violation': wereGranted && !allGranted,
    };
  }

  /// Reset permission lock (admin only)
  Future<void> resetPermissionLock() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_permissionStatusKey);
    print('🗑️ Permission lock reset');
  }
}

/// 🚨 Permission Violation Handler
class PermissionViolationHandler {
  final PermissionLockService _lockService = PermissionLockService();

  /// Check and handle permission violations
  Future<void> checkAndEnforce() async {
    final violation = await _lockService.detectPermissionViolation();
    
    if (violation['has_violation'] == true) {
      // Send alert to admin
      await _sendViolationAlert(violation);
      
      // Block app usage
      throw PermissionViolationException(
        message: violation['message'],
        missingPermissions: violation['missing_permissions'],
      );
    }
  }

  /// Send violation alert to admin via Appwrite
  Future<void> _sendViolationAlert(Map<String, dynamic> violation) async {
    // TODO: Send to Appwrite Realtime or create alert document
    print('🚨 Permission violation detected: ${violation['message']}');
  }
}

/// Custom exception for permission violations
class PermissionViolationException implements Exception {
  final String message;
  final List<String> missingPermissions;

  PermissionViolationException({
    required this.message,
    required this.missingPermissions,
  });

  @override
  String toString() => message;
}

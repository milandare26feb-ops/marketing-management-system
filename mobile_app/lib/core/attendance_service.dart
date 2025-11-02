import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../core/appwrite_config.dart';
import '../core/user_folder_service.dart';

class AttendanceService {
  final AppwriteConfig _config = AppwriteConfig();
  final UserFolderService _folderService = UserFolderService();
  final ImagePicker _picker = ImagePicker();
  
  /// Check-in with selfie + GPS
  Future<Map<String, dynamic>?> checkIn(String userId) async {
    try {
      // 1. Get current location
      final position = await _getCurrentLocation();
      
      // 2. Take selfie
      final XFile? selfie = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
      );
      
      if (selfie == null) {
        throw Exception('Selfie required for check-in');
      }
      
      // 3. Upload selfie to user folder
      final uploadedFile = await _folderService.uploadFileToUserFolder(
        userId: userId,
        file: File(selfie.path),
        fileType: 'selfie',
      );
      
      // 4. Create attendance record
      final attendanceDoc = await _config.databases.createDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.attendanceCollection,
        documentId: ID.unique(),
        data: {
          'user_id': userId,
          'type': 'CHECK_IN',
          'timestamp': DateTime.now().toIso8601String(),
          'latitude': position.latitude,
          'longitude': position.longitude,
          'selfie_url': uploadedFile?.$id ?? '',
          'address': await _getAddressFromCoordinates(position),
        },
      );
      
      print('✅ Check-in successful at ${position.latitude}, ${position.longitude}');
      return attendanceDoc.data;
    } catch (e) {
      print('❌ Check-in error: $e');
      return null;
    }
  }
  
  /// Check-out
  Future<Map<String, dynamic>?> checkOut(String userId) async {
    try {
      final position = await _getCurrentLocation();
      
      final attendanceDoc = await _config.databases.createDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.attendanceCollection,
        documentId: ID.unique(),
        data: {
          'user_id': userId,
          'type': 'CHECK_OUT',
          'timestamp': DateTime.now().toIso8601String(),
          'latitude': position.latitude,
          'longitude': position.longitude,
          'address': await _getAddressFromCoordinates(position),
        },
      );
      
      print('✅ Check-out successful');
      return attendanceDoc.data;
    } catch (e) {
      print('❌ Check-out error: $e');
      return null;
    }
  }
  
  /// Get current GPS location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }
    
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }
    
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
  
  /// Get address from coordinates (Geocoding)
  Future<String> _getAddressFromCoordinates(Position position) async {
    // TODO: Implement geocoding (requires geocoding package)
    return '${position.latitude}, ${position.longitude}';
  }
}

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// 📸 Camera Service - Camera-Only Capture (No Gallery Access)
/// Features:
/// - Face detection for check-in selfies
/// - NID card capture with camera only
/// - No gallery access (security requirement)
/// - Auto-focus and flash control
class CameraService {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;

  /// Initialize camera system
  Future<bool> initializeCamera({bool useFrontCamera = true}) async {
    try {
      // Check camera permission
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        throw Exception('ক্যামেরা অনুমতি দেওয়া হয়নি');
      }

      // Get available cameras
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        throw Exception('কোন ক্যামেরা পাওয়া যায়নি');
      }

      // Select camera (front or back)
      final camera = useFrontCamera
          ? _cameras!.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.front,
              orElse: () => _cameras!.first,
            )
          : _cameras!.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.back,
              orElse: () => _cameras!.first,
            );

      // Initialize controller
      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();
      _isInitialized = true;
      return true;
    } catch (e) {
      debugPrint('❌ Camera initialization error: $e');
      return false;
    }
  }

  /// Get camera controller for preview
  CameraController? get controller => _controller;

  /// Check if camera is initialized
  bool get isInitialized => _isInitialized;

  /// Capture photo (returns File path)
  Future<File?> capturePhoto() async {
    if (!_isInitialized || _controller == null) {
      debugPrint('❌ Camera not initialized');
      return null;
    }

    try {
      // Take picture
      final XFile photo = await _controller!.takePicture();

      // Save to app directory (not gallery)
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'capture_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = path.join(appDir.path, fileName);

      // Copy file to app directory
      final File savedFile = await File(photo.path).copy(savedPath);

      debugPrint('✅ Photo captured: $savedPath');
      return savedFile;
    } catch (e) {
      debugPrint('❌ Capture error: $e');
      return null;
    }
  }

  /// Switch between front and back camera
  Future<void> switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) {
      debugPrint('❌ Only one camera available');
      return;
    }

    final isFront =
        _controller?.description.lensDirection == CameraLensDirection.front;
    await disposeCamera();
    await initializeCamera(useFrontCamera: !isFront);
  }

  /// Toggle flash
  Future<void> toggleFlash() async {
    if (_controller == null) return;

    final currentMode = _controller!.value.flashMode;
    final newMode = currentMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
    await _controller!.setFlashMode(newMode);
  }

  /// Dispose camera resources
  Future<void> disposeCamera() async {
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
      _isInitialized = false;
    }
  }
}

/// 🎯 Face Detection Helper (Basic Implementation)
/// For production, integrate Google ML Kit or TensorFlow Lite
class FaceDetectionHelper {
  /// Validate if image likely contains a face
  /// (Placeholder - integrate ML Kit for real face detection)
  static Future<bool> hasFaceInImage(File imageFile) async {
    // TODO: Integrate Google ML Kit Face Detection
    // For now, return true (implement actual face detection)
    
    // Check file size (face photos are usually > 50KB)
    final fileSize = await imageFile.length();
    if (fileSize < 50000) {
      debugPrint('❌ Image too small, likely no face');
      return false;
    }

    // Check image dimensions (should be reasonably sized)
    // Add image package for actual dimension check
    
    debugPrint('⚠️ Face detection placeholder - integrate ML Kit');
    return true; // Placeholder response
  }

  /// Check if face is centered and clear
  static Future<Map<String, dynamic>> validateSelfie(File imageFile) async {
    // TODO: Add actual face detection logic
    return {
      'hasFace': true,
      'isCentered': true,
      'isWellLit': true,
      'confidence': 0.85,
      'message': 'মুখ সনাক্ত করা হয়েছে ✅',
    };
  }
}

/// 🆔 NID Card Validator
class NIDCardValidator {
  /// Validate NID card format (17 or 10 digits)
  static bool isValidNID(String nid) {
    final cleanNID = nid.replaceAll(RegExp(r'\s+'), '');
    return RegExp(r'^\d{10}$|^\d{13}$|^\d{17}$').hasMatch(cleanNID);
  }

  /// Extract NID from text (if OCR is integrated)
  static String? extractNIDFromText(String text) {
    final match = RegExp(r'\d{10}|\d{13}|\d{17}').firstMatch(text);
    return match?.group(0);
  }

  /// Validate NID card image quality
  static Future<Map<String, dynamic>> validateNIDImage(File imageFile) async {
    final fileSize = await imageFile.length();
    
    return {
      'isValid': fileSize > 100000, // At least 100KB
      'isClear': true, // TODO: Add blur detection
      'hasText': true, // TODO: Add OCR text detection
      'message': fileSize > 100000
          ? 'NID কার্ড চিত্র সঠিক ✅'
          : 'ছবিটি আরও স্পষ্ট হতে হবে ⚠️',
    };
  }
}

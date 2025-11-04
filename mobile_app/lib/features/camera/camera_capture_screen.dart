import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../../services/camera_service.dart';
import '../../services/storage_service.dart';
import '../../core/auth_service.dart';

/// 📸 Camera Capture Screen - Face & NID
/// Features:
/// - Face-only camera for check-in selfie
/// - NID card capture (camera only, no gallery)
/// - Real-time preview
/// - Flash control
class CameraCaptureScreen extends StatefulWidget {
  final CaptureMode mode;
  final String userId;

  const CameraCaptureScreen({
    Key? key,
    required this.mode,
    required this.userId,
  }) : super(key: key);

  @override
  State<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

enum CaptureMode {
  face, // Front camera for selfie
  nid, // Back camera for NID card
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  final CameraService _cameraService = CameraService();
  final StorageService _storageService = StorageService();
  final AuthService _authService = AuthService();
  bool _isInitialized = false;
  bool _isCapturing = false;
  bool _isFlashOn = false;
  File? _capturedImage;
  
  // Overlay data
  String _userName = 'লোড হচ্ছে...';
  String _currentTime = '';
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadUserData();
    _startTimeUpdater();
    _getCurrentLocation();
  }
  
  Future<void> _loadUserData() async {
    try {
      final user = await _authService.getCurrentUser();
      setState(() {
        _userName = user?.$id ?? 'ব্যবহারকারী';
      });
    } catch (e) {
      setState(() {
        _userName = 'ব্যবহারকারী';
      });
    }
  }
  
  void _startTimeUpdater() {
    // Update time every second
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _currentTime = DateFormat('dd MMM yyyy, hh:mm a', 'bn').format(DateTime.now());
        });
        _startTimeUpdater();
      }
    });
  }
  
  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      // Location not available
    }
  }

  Future<void> _initializeCamera() async {
    final useFrontCamera = widget.mode == CaptureMode.face;
    final success = await _cameraService.initializeCamera(
      useFrontCamera: useFrontCamera,
    );

    if (success) {
      setState(() => _isInitialized = true);
    } else {
      _showError('ক্যামেরা চালু করা যায়নি');
    }
  }

  Future<void> _capturePhoto() async {
    if (_isCapturing) return;

    setState(() => _isCapturing = true);

    try {
      final imageFile = await _cameraService.capturePhoto();

      if (imageFile != null) {
        // Validate based on mode
        if (widget.mode == CaptureMode.face) {
          final hasFace = await FaceDetectionHelper.hasFaceInImage(imageFile);
          if (!hasFace) {
            _showError('মুখ সনাক্ত করা যায়নি। আবার চেষ্টা করুন।');
            setState(() => _isCapturing = false);
            return;
          }
        } else {
          final validation = await NIDCardValidator.validateNIDImage(imageFile);
          if (validation['isValid'] != true) {
            _showError(validation['message']);
            setState(() => _isCapturing = false);
            return;
          }
        }

        setState(() {
          _capturedImage = imageFile;
          _isCapturing = false;
        });
      } else {
        _showError('ছবি তোলা যায়নি');
        setState(() => _isCapturing = false);
      }
    } catch (e) {
      _showError('ত্রুটি: $e');
      setState(() => _isCapturing = false);
    }
  }

  Future<void> _uploadImage() async {
    if (_capturedImage == null) return;

    setState(() => _isCapturing = true);

    try {
      String? uploadedUrl;

      if (widget.mode == CaptureMode.face) {
        uploadedUrl = await _storageService.uploadCheckInSelfie(
          widget.userId,
          _capturedImage!,
        );
      } else {
        uploadedUrl = await _storageService.uploadNIDCard(
          widget.userId,
          _capturedImage!,
        );
      }

      if (uploadedUrl != null) {
        Navigator.pop(context, uploadedUrl);
      } else {
        _showError('আপলোড ব্যর্থ হয়েছে');
      }
    } catch (e) {
      _showError('আপলোড ত্রুটি: $e');
    } finally {
      setState(() => _isCapturing = false);
    }
  }

  Future<void> _toggleFlash() async {
    await _cameraService.toggleFlash();
    setState(() => _isFlashOn = !_isFlashOn);
  }

  void _retake() {
    setState(() => _capturedImage = null);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _cameraService.disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.mode == CaptureMode.face ? '📸 সেলফি তুলুন' : '🆔 NID কার্ড স্ক্যান করুন',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _capturedImage != null
          ? _buildPreviewScreen()
          : _buildCameraScreen(),
    );
  }

  Widget _buildCameraScreen() {
    if (!_isInitialized) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFF2E5BFF)),
            SizedBox(height: 16),
            Text(
              'ক্যামেরা চালু হচ্ছে...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        // Camera preview
        Center(
          child: AspectRatio(
            aspectRatio: _cameraService.controller!.value.aspectRatio,
            child: CameraPreview(_cameraService.controller!),
          ),
        ),

        // 🎯 Data Overlay (Bottom-Left Corner)
        Positioned(
          bottom: 120,
          left: 16,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.75),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xFF2E5BFF).withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // User Name
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, color: Color(0xFF2E5BFF), size: 14),
                    SizedBox(width: 4),
                    Text(
                      _userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                // Time
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, color: Color(0xFF00C2A8), size: 14),
                    SizedBox(width: 4),
                    Text(
                      _currentTime,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                // Location (if available)
                if (_currentPosition != null) ...[
                  SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on, color: Color(0xFFFF8A00), size: 14),
                      SizedBox(width: 4),
                      Text(
                        '${_currentPosition!.latitude.toStringAsFixed(4)}, ${_currentPosition!.longitude.toStringAsFixed(4)}',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),

        // Overlay guide
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: widget.mode == CaptureMode.face
                ? MediaQuery.of(context).size.width * 0.8
                : MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF2E5BFF),
                width: 3,
              ),
              borderRadius: widget.mode == CaptureMode.face
                  ? BorderRadius.circular(200)
                  : BorderRadius.circular(16),
            ),
          ),
        ),

        // Instructions
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.mode == CaptureMode.face
                  ? '• মুখ ফ্রেমের মধ্যে রাখুন\n• ভালো আলোতে থাকুন\n• চশমা খুলে নিন'
                  : '• NID কার্ড ফ্রেমের মধ্যে রাখুন\n• সম্পূর্ণ কার্ড দৃশ্যমান রাখুন\n• স্পষ্ট ছবি তুলুন',
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        // Controls
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Flash toggle (only for back camera)
              if (widget.mode == CaptureMode.nid)
                IconButton(
                  icon: Icon(
                    _isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: _toggleFlash,
                ),
              if (widget.mode == CaptureMode.face) SizedBox(width: 60),

              // Capture button
              GestureDetector(
                onTap: _isCapturing ? null : _capturePhoto,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Color(0xFF2E5BFF), width: 4),
                  ),
                  child: _isCapturing
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF2E5BFF),
                          ),
                        )
                      : Icon(Icons.camera_alt, size: 40, color: Color(0xFF2E5BFF)),
                ),
              ),

              SizedBox(width: 60), // Spacer
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewScreen() {
    return Stack(
      children: [
        // Image preview
        Center(
          child: Image.file(
            _capturedImage!,
            fit: BoxFit.contain,
          ),
        ),

        // Actions
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Retake
              ElevatedButton.icon(
                onPressed: _retake,
                icon: Icon(Icons.refresh),
                label: Text('আবার তুলুন'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),

              // Upload
              ElevatedButton.icon(
                onPressed: _isCapturing ? null : _uploadImage,
                icon: _isCapturing
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(Icons.check),
                label: Text('ব্যবহার করুন'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00C2A8),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Storage Service Extension for NID upload
extension StorageServiceExtension on StorageService {
  Future<String?> uploadFile({
    required String bucketId,
    required File file,
    required String fileName,
  }) async {
    try {
      // TODO: Implement generic file upload
      print('Uploading to bucket $bucketId: $fileName');
      return 'https://example.com/$fileName'; // Placeholder
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }
}

import 'dart:io';
import 'package:appwrite/appwrite.dart';
import '../core/appwrite_config.dart';

class StorageService {
  late final Storage _storage;
  late final String _projectId;

  StorageService() {
    final client = Client()
        .setEndpoint(AppwriteConfig.endpoint)
        .setProject(AppwriteConfig.projectId);
    
    _storage = Storage(client);
    _projectId = AppwriteConfig.projectId;
  }

  /// Upload NID card image
  Future<String> uploadNIDCard(String userId, File imageFile) async {
    try {
      final file = await _storage.createFile(
        bucketId: 'nid_cards',
        fileId: 'unique()',
        file: InputFile.fromPath(path: imageFile.path),
      );
      
      return '${AppwriteConfig.endpoint}/storage/buckets/nid_cards/files/${file.$id}/view?project=$_projectId';
    } catch (e) {
      throw Exception('Failed to upload NID card: $e');
    }
  }

  /// Upload profile picture
  Future<String> uploadProfilePicture(String userId, File imageFile) async {
    try {
      final file = await _storage.createFile(
        bucketId: 'profile_videos',
        fileId: 'unique()',
        file: InputFile.fromPath(path: imageFile.path),
      );
      
      return '${AppwriteConfig.endpoint}/storage/buckets/profile_videos/files/${file.$id}/view?project=$_projectId';
    } catch (e) {
      throw Exception('Failed to upload profile picture: $e');
    }
  }

  /// Upload profile video
  Future<String> uploadProfileVideo(String userId, File videoFile) async {
    try {
      final file = await _storage.createFile(
        bucketId: 'profile_videos',
        fileId: 'unique()',
        file: InputFile.fromPath(path: videoFile.path),
      );
      
      return '${AppwriteConfig.endpoint}/storage/buckets/profile_videos/files/${file.$id}/view?project=$_projectId';
    } catch (e) {
      throw Exception('Failed to upload profile video: $e');
    }
  }

  /// Upload check-in selfie
  Future<String> uploadCheckInSelfie(String userId, File imageFile) async {
    try {
      final file = await _storage.createFile(
        bucketId: 'check_in_selfies',
        fileId: 'unique()',
        file: InputFile.fromPath(path: imageFile.path),
      );
      
      return '${AppwriteConfig.endpoint}/storage/buckets/check_in_selfies/files/${file.$id}/view?project=$_projectId';
    } catch (e) {
      throw Exception('Failed to upload selfie: $e');
    }
  }

  /// Upload report file (PDF/Image)
  Future<String> uploadReport(String userId, File reportFile) async {
    try {
      final file = await _storage.createFile(
        bucketId: 'reports',
        fileId: 'unique()',
        file: InputFile.fromPath(path: reportFile.path),
      );
      
      return '${AppwriteConfig.endpoint}/storage/buckets/reports/files/${file.$id}/view?project=$_projectId';
    } catch (e) {
      throw Exception('Failed to upload report: $e');
    }
  }

  /// Upload audio note
  Future<String> uploadAudioNote(String userId, File audioFile) async {
    try {
      final file = await _storage.createFile(
        bucketId: 'audio_notes',
        fileId: 'unique()',
        file: InputFile.fromPath(path: audioFile.path),
      );
      
      return '${AppwriteConfig.endpoint}/storage/buckets/audio_notes/files/${file.$id}/view?project=$_projectId';
    } catch (e) {
      throw Exception('Failed to upload audio note: $e');
    }
  }

  /// Delete file from storage
  Future<void> deleteFile(String bucketId, String fileId) async {
    try {
      await _storage.deleteFile(
        bucketId: bucketId,
        fileId: fileId,
      );
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }
}

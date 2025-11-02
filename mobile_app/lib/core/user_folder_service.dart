import 'dart:io' as io;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../core/appwrite_config.dart';

/// 📁 User-wise folder structure manager
/// Admin approval এর পর automatic folder তৈরি করবে
class UserFolderService {
  final AppwriteConfig _config = AppwriteConfig();
  
  /// Admin approval এর পর user folder create করা
  /// Format: "FirstName_WorkLocation" (e.g., "Rahim_Dhaka")
  Future<String> createUserFolder({
    required String userId,
    required String firstName,
    required String workLocation,
  }) async {
    try {
      // Folder name sanitize করা
      final folderName = '${_sanitizeName(firstName)}_${_sanitizeName(workLocation)}';
      
      // Appwrite এ folder concept নেই, তাই metadata দিয়ে organize করা
      // User document update করে folder path store করা
      await _config.databases.updateDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.usersCollection,
        documentId: userId,
        data: {
          'folder_name': folderName,
          'folder_path': '/users/$userId/$folderName',
          'status': 'APPROVED',
          'approved_at': DateTime.now().toIso8601String(),
        },
      );
      
      print('✅ User folder created: $folderName for user $userId');
      return folderName;
    } catch (e) {
      print('❌ Error creating user folder: $e');
      rethrow;
    }
  }
  
  /// File upload করা user এর নিজস্ব folder এ
  Future<models.File?> uploadFileToUserFolder({
    required String userId,
    required io.File file,
    required String fileType, // 'selfie', 'report', 'photo', 'video', 'document'
  }) async {
    try {
      // User এর folder name fetch করা
      final userDoc = await _config.databases.getDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.usersCollection,
        documentId: userId,
      );
      
      final folderName = userDoc.data['folder_name'] ?? 'unknown';
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileBaseName = file.path.split(io.Platform.pathSeparator).last;
      final fileName = '$folderName/$fileType/${timestamp}_$fileBaseName';
      
      // Appwrite Storage এ upload
      final uploadedFile = await _config.storage.createFile(
        bucketId: AppwriteConfig.storageBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path, filename: fileName),
      );
      
      print('✅ File uploaded: ${uploadedFile.name}');
      return uploadedFile;
    } catch (e) {
      print('❌ Error uploading file: $e');
      return null;
    }
  }
  
  /// User এর সব files list করা
  Future<List<models.File>> getUserFiles(String userId) async {
    try {
      final userDoc = await _config.databases.getDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.usersCollection,
        documentId: userId,
      );
      
      final folderName = userDoc.data['folder_name'];
      
      // Appwrite Storage থেকে files fetch করা (folder prefix দিয়ে filter)
      final filesList = await _config.storage.listFiles(
        bucketId: AppwriteConfig.storageBucketId,
        queries: [
          Query.search('name', folderName),
        ],
      );
      
      return filesList.files;
    } catch (e) {
      print('❌ Error fetching user files: $e');
      return [];
    }
  }
  
  /// File delete করা
  Future<void> deleteUserFile(String fileId) async {
    try {
      await _config.storage.deleteFile(
        bucketId: AppwriteConfig.storageBucketId,
        fileId: fileId,
      );
      print('✅ File deleted: $fileId');
    } catch (e) {
      print('❌ Error deleting file: $e');
    }
  }
  
  /// Name sanitize করা (special characters remove)
  String _sanitizeName(String name) {
    return name
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(' ', '_')
        .toLowerCase();
  }
}

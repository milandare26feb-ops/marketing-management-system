import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import '../core/appwrite_config.dart';
import '../core/user_folder_service.dart';

class AuthService {
  final AppwriteConfig _config = AppwriteConfig();
  final UserFolderService _folderService = UserFolderService();
  
  /// Register new user with mandatory fields
  Future<User?> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
    required double latitude,
    required double longitude,
    required String workLocation,
    String? photoUrl,
  }) async {
    try {
      // 1. Create Appwrite account
      final user = await _config.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: '$firstName $lastName',
      );
      
      // 2. Create user document in database (status: PENDING)
      await _config.databases.createDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.usersCollection,
        documentId: user.$id,
        data: {
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'address': address,
          'latitude': latitude,
          'longitude': longitude,
          'work_location': workLocation,
          'photo_url': photoUrl ?? '',
          'status': 'PENDING', // 🚨 Admin approval দরকার
          'role': 'field_user',
          'created_at': DateTime.now().toIso8601String(),
        },
      );
      
      print('✅ User registered: ${user.email} (Status: PENDING)');
      return user;
    } catch (e) {
      print('❌ Registration error: $e');
      return null;
    }
  }
  
  /// Login with email & password
  Future<Session?> login(String email, String password) async {
    try {
      final session = await _config.account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      
      // Check user approval status
      final user = await getCurrentUser();
      if (user != null) {
        final userDoc = await _config.databases.getDocument(
          databaseId: AppwriteConfig.databaseId,
          collectionId: AppwriteConfig.usersCollection,
          documentId: user.$id,
        );
        
        if (userDoc.data['status'] != 'APPROVED') {
          throw Exception('⚠️ Your account is pending admin approval');
        }
      }
      
      print('✅ Login successful: $email');
      return session;
    } catch (e) {
      print('❌ Login error: $e');
      rethrow;
    }
  }
  
  /// Get current logged-in user
  Future<User?> getCurrentUser() async {
    try {
      return await _config.account.get();
    } catch (e) {
      return null;
    }
  }
  
  /// Logout
  Future<void> logout() async {
    try {
      await _config.account.deleteSession(sessionId: 'current');
      print('✅ Logged out');
    } catch (e) {
      print('❌ Logout error: $e');
    }
  }
  
  /// Admin: Approve user (এটি admin panel থেকে call হবে)
  Future<void> approveUser(String userId, String firstName, String workLocation) async {
    try {
      // 1. User status update করা
      await _config.databases.updateDocument(
        databaseId: AppwriteConfig.databaseId,
        collectionId: AppwriteConfig.usersCollection,
        documentId: userId,
        data: {
          'status': 'APPROVED',
          'approved_at': DateTime.now().toIso8601String(),
        },
      );
      
      // 2. Automatic user folder তৈরি করা
      await _folderService.createUserFolder(
        userId: userId,
        firstName: firstName,
        workLocation: workLocation,
      );
      
      print('✅ User approved and folder created: $userId');
    } catch (e) {
      print('❌ Approval error: $e');
      rethrow;
    }
  }
}

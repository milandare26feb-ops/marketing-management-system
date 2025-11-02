import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  // 🔧 Appwrite Configuration - আপনার Appwrite credentials এখানে দিন
  static const String endpoint = 'https://cloud.appwrite.io/v1'; // বা self-hosted URL
  static const String projectId = 'YOUR_APPWRITE_PROJECT_ID';
  static const String databaseId = 'markettrack_db';
  static const String storageBucketId = 'user_files';
  
  // Collections
  static const String usersCollection = 'users';
  static const String reportsCollection = 'reports';
  static const String attendanceCollection = 'attendance';
  static const String tasksCollection = 'tasks';
  
  // Singleton pattern
  static final AppwriteConfig _instance = AppwriteConfig._internal();
  factory AppwriteConfig() => _instance;
  AppwriteConfig._internal();
  
  late Client client;
  late Account account;
  late Databases databases;
  late Storage storage;
  late Realtime realtime;
  
  void init() {
    client = Client()
        ..setEndpoint(endpoint)
        ..setProject(projectId)
        ..setSelfSigned(status: true); // Development only
    
    account = Account(client);
    databases = Databases(client);
    storage = Storage(client);
    realtime = Realtime(client);
  }
}

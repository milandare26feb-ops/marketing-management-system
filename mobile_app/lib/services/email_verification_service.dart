import 'package:appwrite/models.dart';
import '../core/appwrite_config.dart';

/// 📧 Email Verification Service
/// Features:
/// - Send verification email on registration
/// - Block login until email verified
/// - Resend verification email
/// - Check verification status
class EmailVerificationService {
  final AppwriteConfig _config = AppwriteConfig();

  /// Send verification email after registration
  Future<bool> sendVerificationEmail() async {
    try {
      final account = _config.account;
      
      // Appwrite automatically sends verification email
      // Create verification URL (your app deep link)
      final verificationUrl = 'https://markettrack.app/verify'; // Your app URL
      
      await account.createVerification(
        url: verificationUrl,
      );

      print('✅ Verification email sent successfully');
      return true;
    } catch (e) {
      print('❌ Failed to send verification email: $e');
      return false;
    }
  }

  /// Confirm email verification with secret token
  Future<bool> confirmEmailVerification(String userId, String secret) async {
    try {
      final account = _config.account;
      
      await account.updateVerification(
        userId: userId,
        secret: secret,
      );

      print('✅ Email verified successfully');
      return true;
    } catch (e) {
      print('❌ Verification failed: $e');
      return false;
    }
  }

  /// Check if current user's email is verified
  Future<bool> isEmailVerified() async {
    try {
      final account = _config.account;
      final user = await account.get();
      
      return user.emailVerification;
    } catch (e) {
      print('❌ Failed to check verification status: $e');
      return false;
    }
  }

  /// Get current user details
  Future<User?> getCurrentUser() async {
    try {
      final account = _config.account;
      return await account.get();
    } catch (e) {
      print('❌ Failed to get user: $e');
      return null;
    }
  }

  /// Resend verification email
  Future<bool> resendVerificationEmail() async {
    return await sendVerificationEmail();
  }

  /// Logout if email not verified
  Future<void> enforceEmailVerification() async {
    final isVerified = await isEmailVerified();
    
    if (!isVerified) {
      print('⚠️ Email not verified - blocking access');
      // Force user to verify email
      throw Exception('অনুগ্রহ করে আপনার ইমেইল যাচাই করুন');
    }
  }
}

/// 🔐 Email Verification Widget State
class EmailVerificationState {
  bool isVerified = false;
  bool isLoading = false;
  String? errorMessage;
  DateTime? lastSentTime;

  bool get canResend {
    if (lastSentTime == null) return true;
    final diff = DateTime.now().difference(lastSentTime!);
    return diff.inMinutes >= 2; // Can resend after 2 minutes
  }

  int get secondsUntilResend {
    if (lastSentTime == null) return 0;
    final diff = DateTime.now().difference(lastSentTime!);
    final remaining = 120 - diff.inSeconds; // 2 minutes = 120 seconds
    return remaining > 0 ? remaining : 0;
  }
}

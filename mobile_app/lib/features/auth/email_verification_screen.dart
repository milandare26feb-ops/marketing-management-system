import 'package:flutter/material.dart';
import 'dart:async';
import '../../services/email_verification_service.dart';
import '../home/home_screen.dart';

/// 📧 Email Verification Screen
/// Blocks user from accessing app until email is verified
class EmailVerificationScreen extends StatefulWidget {
  final String userEmail;

  const EmailVerificationScreen({
    Key? key,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final EmailVerificationService _verificationService = EmailVerificationService();
  final EmailVerificationState _state = EmailVerificationState();
  Timer? _checkTimer;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startAutoCheck();
    _startResendTimer();
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    _resendTimer?.cancel();
    super.dispose();
  }

  /// Auto-check verification status every 5 seconds
  void _startAutoCheck() {
    _checkTimer = Timer.periodic(Duration(seconds: 5), (_) {
      _checkVerificationStatus();
    });
  }

  /// Start resend countdown timer
  void _startResendTimer() {
    _resendTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  /// Check if email is verified
  Future<void> _checkVerificationStatus() async {
    setState(() => _state.isLoading = true);

    try {
      final isVerified = await _verificationService.isEmailVerified();
      
      if (isVerified) {
        _state.isVerified = true;
        _checkTimer?.cancel();
        
        // Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (e) {
      _state.errorMessage = e.toString();
    } finally {
      if (mounted) {
        setState(() => _state.isLoading = false);
      }
    }
  }

  /// Resend verification email
  Future<void> _resendVerificationEmail() async {
    if (!_state.canResend) return;

    setState(() => _state.isLoading = true);

    try {
      final success = await _verificationService.resendVerificationEmail();
      
      if (success) {
        _state.lastSentTime = DateTime.now();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ যাচাইকরণ ইমেইল পাঠানো হয়েছে'),
            backgroundColor: Color(0xFF00C2A8),
          ),
        );
      } else {
        throw Exception('ইমেইল পাঠাতে ব্যর্থ');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _state.isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B1020),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email icon
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2E5BFF), Color(0xFF00C2A8)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.email_outlined,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              
              SizedBox(height: 32),
              
              // Title
              Text(
                'ইমেইল যাচাই করুন',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              SizedBox(height: 16),
              
              // Description
              Text(
                'আপনার ইমেইলে একটি যাচাইকরণ লিঙ্ক পাঠানো হয়েছে',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
              
              SizedBox(height: 8),
              
              // Email address
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF121A33),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.userEmail,
                  style: TextStyle(
                    color: Color(0xFF2E5BFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              
              SizedBox(height: 32),
              
              // Instructions
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF121A33),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF2E5BFF).withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📌 করণীয়:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildStep('1', 'আপনার ইমেইল ইনবক্স চেক করুন'),
                    _buildStep('2', 'যাচাইকরণ লিঙ্কে ক্লিক করুন'),
                    _buildStep('3', 'এই পেজে স্বয়ংক্রিয়ভাবে লগইন হবে'),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Auto-checking indicator
              if (_state.isLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF2E5BFF),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'যাচাই করা হচ্ছে...',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                )
              else
                Text(
                  '🔄 স্বয়ংক্রিয়ভাবে যাচাই হচ্ছে',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              
              Spacer(),
              
              // Resend button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _state.canResend ? _resendVerificationEmail : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E5BFF),
                    disabledBackgroundColor: Colors.grey[800],
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _state.canResend
                        ? 'পুনরায় ইমেইল পাঠান'
                        : 'পুনরায় পাঠান (${_state.secondsUntilResend}s)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 12),
              
              // Help text
              Text(
                'ইমেইল পাননি? Spam ফোল্ডার চেক করুন',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(0xFF2E5BFF).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Color(0xFF2E5BFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey[300]),
            ),
          ),
        ],
      ),
    );
  }
}

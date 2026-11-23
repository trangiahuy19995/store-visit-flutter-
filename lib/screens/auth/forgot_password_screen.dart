import 'package:flutter/material.dart';
import '../../theme/vfm_colors.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage;

  bool get _isEmailValid {
    final email = _emailController.text.trim();
    return email.isNotEmpty && email.contains('@');
  }

  void _handleSendOtp() {
    setState(() => _errorMessage = null);
    final email = _emailController.text.trim();

    if (!_isEmailValid) {
      setState(() => _errorMessage = 'Vui lòng nhập định dạng email hợp lệ (vd: user@vfm.com.vn)');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(email: email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: VfmColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Quên mật khẩu',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: VfmColors.textPrimary,
          ),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: VfmColors.borderLight),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Header (Figma node 6:6583)
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: VfmColors.primaryGreenLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  size: 40,
                  color: VfmColors.primaryGreen,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Gửi OTP qua email',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: VfmColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Description
              const Text(
                'Vui lòng nhập địa chỉ email đã đăng ký của bạn. Chúng tôi sẽ gửi một mã xác thực (OTP) để hỗ trợ bạn đặt lại mật khẩu.',
                style: TextStyle(
                  fontSize: 14,
                  color: VfmColors.textSecondary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: VfmColors.error, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: VfmColors.error, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Email Input Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email *',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: VfmColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Nhập địa chỉ email của bạn',
                      hintStyle: const TextStyle(color: VfmColors.textSecondary, fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: VfmColors.borderDefault),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: VfmColors.primaryGreen, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Send OTP Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _emailController.text.isNotEmpty ? VfmColors.primaryGreen : VfmColors.disabledBg,
                    foregroundColor: _emailController.text.isNotEmpty ? Colors.white : VfmColors.disabledText,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: _emailController.text.isNotEmpty ? _handleSendOtp : null,
                  child: const Text('Gửi mã OTP', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/vfm_colors.dart';
import '../store_visit_screen.dart';

class FirstTimePasswordScreen extends StatefulWidget {
  final String username;

  const FirstTimePasswordScreen({super.key, required this.username});

  @override
  State<FirstTimePasswordScreen> createState() => _FirstTimePasswordScreenState();
}

class _FirstTimePasswordScreenState extends State<FirstTimePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureNew = true;
  bool _obscureConfirm = true;
  String? _errorMessage;

  bool get _isFormFilled =>
      _newPasswordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  void _handleSubmit() {
    setState(() => _errorMessage = null);

    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;

    if (newPass.length < 6) {
      setState(() => _errorMessage = 'Mật khẩu phải có độ dài tối thiểu 6 ký tự.');
      return;
    }

    if (newPass != confirmPass) {
      setState(() => _errorMessage = 'Mật khẩu xác nhận không khớp với mật khẩu mới.');
      return;
    }

    // Success dialog (Figma node 6:3726)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: VfmColors.primaryGreen, size: 28),
            SizedBox(width: 10),
            Text('Thành công', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          'Đổi mật khẩu lần đầu thành công! Bây giờ bạn có thể bắt đầu sử dụng ứng dụng.',
          style: TextStyle(fontSize: 14, color: VfmColors.textSecondary),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: VfmColors.primaryGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(dialogCtx);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const StoreVisitScreen()),
                  (route) => false,
                );
              },
              child: const Text('Vào trang chính'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VfmColors.backgroundSecondary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: VfmColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Đổi mật khẩu',
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tài khoản của bạn cần đổi mật khẩu trong lần đầu đăng nhập để đảm bảo an toàn thông tin.',
                      style: TextStyle(fontSize: 13, color: VfmColors.textSecondary, height: 1.4),
                    ),
                    const SizedBox(height: 20),

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

                    // Field 1: New password
                    _buildPasswordField(
                      label: 'Mật khẩu mới *',
                      hint: 'Nhập mật khẩu mới',
                      controller: _newPasswordController,
                      isObscure: _obscureNew,
                      onToggleObscure: () => setState(() => _obscureNew = !_obscureNew),
                    ),
                    const SizedBox(height: 16),

                    // Field 2: Confirm password
                    _buildPasswordField(
                      label: 'Nhập lại mật khẩu *',
                      hint: 'Nhập lại mật khẩu',
                      controller: _confirmPasswordController,
                      isObscure: _obscureConfirm,
                      onToggleObscure: () => setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Bar (Figma node 3:3097)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(top: BorderSide(color: VfmColors.borderLight)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormFilled ? VfmColors.primaryGreen : VfmColors.disabledBg,
                  foregroundColor: _isFormFilled ? Colors.white : VfmColors.disabledText,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: _isFormFilled ? _handleSubmit : null,
                child: const Text('Đổi mật khẩu', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isObscure,
    required VoidCallback onToggleObscure,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: VfmColors.textPrimary),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isObscure,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: hint,
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
            suffixIcon: IconButton(
              icon: Icon(
                isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
                color: VfmColors.textSecondary,
              ),
              onPressed: onToggleObscure,
            ),
          ),
        ),
      ],
    );
  }
}

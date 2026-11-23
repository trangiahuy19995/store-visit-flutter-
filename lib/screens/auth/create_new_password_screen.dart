import 'package:flutter/material.dart';
import '../../theme/vfm_colors.dart';
import 'login_screen.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String email;

  const CreateNewPasswordScreen({super.key, required this.email});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;
  String? _errorMessage;

  bool get _isFormFilled =>
      _passwordController.text.isNotEmpty &&
      _confirmController.text.isNotEmpty;

  void _handleSavePassword() {
    setState(() => _errorMessage = null);

    final pass = _passwordController.text;
    final confirm = _confirmController.text;

    if (pass.length < 6) {
      setState(() => _errorMessage = 'Mật khẩu phải có ít nhất 6 ký tự.');
      return;
    }

    if (pass != confirm) {
      setState(() => _errorMessage = 'Mật khẩu xác nhận không trùng khớp.');
      return;
    }

    // Success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: VfmColors.primaryGreen, size: 28),
            SizedBox(width: 10),
            Text('Đổi mật khẩu thành công', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          'Mật khẩu mới của bạn đã được cập nhật thành công. Vui lòng đăng nhập lại với mật khẩu mới.',
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
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Đăng nhập lại'),
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
          'Tạo mật khẩu mới',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: VfmColors.textPrimary),
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
                      'Vui lòng thiết lập mật khẩu mới cho tài khoản của bạn.',
                      style: TextStyle(fontSize: 13, color: VfmColors.textSecondary),
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

                    _buildField(
                      label: 'Mật khẩu *',
                      hint: 'Nhập mật khẩu mới',
                      controller: _passwordController,
                      isObscure: _obscurePass,
                      onToggle: () => setState(() => _obscurePass = !_obscurePass),
                    ),
                    const SizedBox(height: 16),

                    _buildField(
                      label: 'Mật khẩu xác nhận *',
                      hint: 'Nhập lại mật khẩu mới',
                      controller: _confirmController,
                      isObscure: _obscureConfirm,
                      onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Bar (Figma node 6:5845)
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
                onPressed: _isFormFilled ? _handleSavePassword : null,
                child: const Text('Tạo mật khẩu', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isObscure,
    required VoidCallback onToggle,
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
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }
}

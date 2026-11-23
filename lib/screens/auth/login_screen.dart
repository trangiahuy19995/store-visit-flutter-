import 'package:flutter/material.dart';
import '../../theme/vfm_colors.dart';
import '../../widgets/vfm_decorations.dart';
import '../store_visit_screen.dart';
import 'first_time_password_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordObscure = true;
  String? _errorMessage;

  bool get _isFormValid =>
      _usernameController.text.trim().isNotEmpty &&
      _passwordController.text.trim().isNotEmpty;

  void _handleLogin() {
    setState(() => _errorMessage = null);
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Special case to demonstrate the First-Time Password Change user flow
    if (username == 'newuser' || password == '123456') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FirstTimePasswordScreen(username: username),
        ),
      );
      return;
    }

    // Demo credentials: any non-empty password or standard login
    if (password.length >= 6) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StoreVisitScreen()),
      );
    } else {
      // Simulate Error State from Figma (Node 6:2636)
      setState(() {
        _errorMessage = 'Tên đăng nhập hoặc mật khẩu không chính xác. Vui lòng thử lại!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VfmColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            const VfmCornerDecorations(),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const VfmLogo(size: 140),
                    const SizedBox(height: 32),

                    // Error message banner (Figma node 6:2636)
                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: VfmColors.error.withOpacity(0.4)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: VfmColors.error, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(
                                  color: VfmColors.error,
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Username Input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tên đăng nhập',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: VfmColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _usernameController,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: 'Nhập tên đăng nhập',
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
                    const SizedBox(height: 16),

                    // Password Input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mật khẩu',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: VfmColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _passwordController,
                          obscureText: _isPasswordObscure,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: 'Nhập mật khẩu',
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
                                _isPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                size: 20,
                                color: VfmColors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() => _isPasswordObscure = !_isPasswordObscure);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Login Button (Large)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isFormValid ? VfmColors.primaryGreen : VfmColors.disabledBg,
                          foregroundColor: _isFormValid ? Colors.white : VfmColors.disabledText,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        onPressed: _isFormValid ? _handleLogin : null,
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Forgot Password Button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                          );
                        },
                        child: const Text(
                          'Quên mật khẩu',
                          style: TextStyle(
                            color: VfmColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Demo hint
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: VfmColors.backgroundSecondary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '💡 Gợi ý: Nhập mật khẩu >= 6 ký tự để vào trang chính. Nhập mật khẩu "123456" để xem flow Đổi mật khẩu lần đầu.',
                        style: TextStyle(fontSize: 12, color: VfmColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer Version
            const Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Phiên bản 1.0.11',
                  style: TextStyle(fontSize: 12, color: VfmColors.textMuted),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

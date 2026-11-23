import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/vfm_colors.dart';
import 'create_new_password_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _remainingSeconds = 150; // 00:02:30 from Figma
  Timer? _timer;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _remainingSeconds = 150);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '00:$minutes:$seconds';
  }

  void _verifyOtp() {
    setState(() => _errorMessage = null);
    final code = _otpCode;

    if (code.length < 6) {
      setState(() => _errorMessage = 'Vui lòng nhập đủ 6 chữ số mã OTP.');
      return;
    }

    // Demo check: any 6 digit code works (or reject '000000' to simulate error state 43:7979)
    if (code == '000000') {
      setState(() => _errorMessage = 'Mã OTP không chính xác hoặc đã hết hạn.');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateNewPasswordScreen(email: widget.email),
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
          'Xác Thực OTP',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: VfmColors.textPrimary),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: VfmColors.borderLight),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Password-02 Icon (Figma node 32:7762)
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: VfmColors.primaryGreenLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_reset_rounded,
                  size: 40,
                  color: VfmColors.primaryGreen,
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Nhập mã OTP',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: VfmColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Nhập mã OTP nhận được qua email ${widget.email}. Nếu bạn không nhận được email trong vòng vài phút, vui lòng kiểm tra hộp thư rác hoặc gửi lại.',
                style: const TextStyle(fontSize: 13, color: VfmColors.textSecondary, height: 1.4),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

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

              // 6 OTP Digit Fields (Figma node 32:7788)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return Container(
                    width: 48,
                    height: 56,
                    decoration: BoxDecoration(
                      color: VfmColors.primaryGreenLight.withOpacity(0.48),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _controllers[index].text.isNotEmpty ? VfmColors.primaryGreen : VfmColors.borderDefault,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: VfmColors.textPrimary,
                        ),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (val) {
                          setState(() {});
                          if (val.isNotEmpty && index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          } else if (val.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                          if (_otpCode.length == 6) {
                            _verifyOtp();
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Countdown Expired Time Badge (Figma node 102:5346)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: VfmColors.primaryGreen,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Thời gian hiệu lực của OTP : $_formattedTime',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _otpCode.length == 6 ? VfmColors.primaryGreen : VfmColors.disabledBg,
                    foregroundColor: _otpCode.length == 6 ? Colors.white : VfmColors.disabledText,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: _otpCode.length == 6 ? _verifyOtp : null,
                  child: const Text('Xác nhận', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 12),

              // Resend Button (Figma node 344:12137)
              TextButton(
                onPressed: _remainingSeconds == 0 ? _startCountdown : null,
                child: Text(
                  'Tôi không nhận được OTP - Gửi lại',
                  style: TextStyle(
                    color: _remainingSeconds == 0 ? VfmColors.primaryGreen : VfmColors.textMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

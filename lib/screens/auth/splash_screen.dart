import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/vfm_colors.dart';
import '../../widgets/vfm_decorations.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VfmColors.background,
      body: Stack(
        children: [
          const VfmCornerDecorations(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const VfmLogo(size: 160),
                const SizedBox(height: 24),
                const Text(
                  'VIETNAM FLOUR MILLS',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: VfmColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hệ thống quản lý bán hàng SFA',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: VfmColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Phiên bản 1.0.11',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  color: VfmColors.textMuted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

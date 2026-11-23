import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_colors.dart';
import 'screens/auth/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const StoreVisitApp());
}

class StoreVisitApp extends StatelessWidget {
  const StoreVisitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VFM SFA - Thăm Viếng Đúng Tuyến',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

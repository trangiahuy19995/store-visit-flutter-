import 'package:flutter/material.dart';

/// Material 3 Color Tokens extracted directly from the Figma Design Kit
class AppColors {
  // Primary (Forest Green)
  static const Color primary = Color(0xFF2D6A44);
  static const Color primaryContainer = Color(0xFFB1F1C2);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF11512E);

  // Secondary
  static const Color secondary = Color(0xFF4F6353);
  static const Color secondaryContainer = Color(0xFFD2E8D4);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF4A4459);

  // Surface & Containers
  static const Color surface = Color(0xFFF6FBF3);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF0F5ED);
  static const Color surfaceContainer = Color(0xFFEAEFE8);
  static const Color surfaceContainerHigh = Color(0xFFE5EAE2);
  static const Color surfaceContainerHighest = Color(0xFFDFE4DD);

  // Typography & Content
  static const Color onSurface = Color(0xFF181D18);
  static const Color onSurfaceVariant = Color(0xFF49454F);
  static const Color textPrimary = Color(0xFF111418);

  // Outlines & Borders
  static const Color outline = Color(0xFF717971);
  static const Color outlineVariant = Color(0xFFC0C9BF);
  static const Color borderDefault = Color(0xFFD1D8DB);

  // Status Chip Colors
  static const Color statusVisited = Color(0xFF2D6A44);    // Đã thăm viếng (Surface tint)
  static const Color statusMissed = Color(0xFFE46962);     // Lỡ viếng thăm (Error 60)
  static const Color statusPending = Color(0xFF633B48);    // Chưa thăm viếng (On-tertiary-fixed-variant)

  // Scrim & Shadows
  static const Color scrim = Color(0xFF000000);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surfaceContainerLowest,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        error: AppColors.statusMissed,
        onError: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
      ),
      fontFamily: 'Roboto',
      dividerTheme: const DividerThemeData(
        color: AppColors.outlineVariant,
        thickness: 1,
      ),
    );
  }
}

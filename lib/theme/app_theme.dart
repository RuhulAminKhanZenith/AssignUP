import 'package:flutter/material.dart';

class AppColors {
  // Primary gradient colors
  static const Color primaryPurple = Color(0xFF7B4FD4);
  static const Color deepPurple = Color(0xFF5B2EA6);
  static const Color lightPurple = Color(0xFF9C6FE4);
  static const Color bgPurple = Color(0xFF8B5CF6);

  // Accent colors
  static const Color accentPink = Color(0xFFEC4899);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentOrange = Color(0xFFF59E0B);
  static const Color accentRed = Color(0xFFEF4444);

  // Card backgrounds
  static const Color cardPurple = Color(0xFFD8B4FE);
  static const Color cardLight = Color(0xFFF5F0FF);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF8F4FF);

  // Text colors
  static const Color textDark = Color(0xFF1E1B4B);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textPink = Color(0xFFEC4899);
  static const Color textPurple = Color(0xFF7C3AED);

  // Bottom nav
  static const Color navBg = Color(0xFFF5F0FF);

  // Stat card colors
  static const Color classCard = Color(0xFFDDD6FE);
  static const Color taskCard = Color(0xFFFED7AA);
  static const Color overdueCard = Color(0xFFFECACA);
  static const Color doneCard = Color(0xFFBBF7D0);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9), Color(0xFF5B21B6)],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7C3AED), Color(0xFF9333EA), Color(0xFFA855F7)],
  );

  static const LinearGradient loginCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEDE9FE), Color(0xFFF3E8FF)],
  );
}

class AppTextStyles {
  static const TextStyle appTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryPurple,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.surfaceLight,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textDark,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        background: AppColors.background,
        surface: AppColors.backgroundLight,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(
          color: AppColors.textMain,
          fontWeight: FontWeight.bold,
          fontSize: 64,
          letterSpacing: -1.5,
        ),
        displayMedium: GoogleFonts.outfit(
          color: AppColors.textMain,
          fontWeight: FontWeight.bold,
          fontSize: 48,
          letterSpacing: -0.5,
        ),
        displaySmall: GoogleFonts.outfit(
          color: AppColors.textMain,
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
        headlineMedium: GoogleFonts.outfit(
          color: AppColors.textMain,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
        titleLarge: GoogleFonts.inter(
          color: AppColors.textMain,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        bodyLarge: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontSize: 18,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontSize: 16,
          height: 1.5,
        ),
      ),
      useMaterial3: true,
    );
  }
}

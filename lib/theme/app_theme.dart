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
        surface: AppColors.backgroundLight,
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textMain,
          fontWeight: FontWeight.w700,
          fontSize: 72,
          letterSpacing: -2,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.spaceGrotesk(
          color: AppColors.textMain,
          fontWeight: FontWeight.w700,
          fontSize: 52,
          letterSpacing: -1,
          height: 1.15,
        ),
        displaySmall: GoogleFonts.spaceGrotesk(
          color: AppColors.textMain,
          fontWeight: FontWeight.w600,
          fontSize: 36,
        ),
        headlineLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textMain,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          color: AppColors.textMain,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        titleLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textMain,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        bodyLarge: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontSize: 17,
          height: 1.75,
        ),
        bodyMedium: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontSize: 15,
          height: 1.65,
        ),
        labelLarge: GoogleFonts.dmMono(
          color: AppColors.accent,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        labelStyle: GoogleFonts.inter(color: AppColors.textSecondary),
        hintStyle: GoogleFonts.inter(color: AppColors.textSecondary.withValues(alpha: 0.5)),
      ),
      useMaterial3: true,
    );
  }
}

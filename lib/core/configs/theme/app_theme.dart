import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.secondary),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accent),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      titleMedium: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
      bodySmall: TextStyle(color: Colors.black54, fontSize: 14),
    ),
  );
}

import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:flutter/material.dart';



abstract final class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Cairo',

      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      cardColor: AppColors.card,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.gold,
        onPrimary: Colors.black,
        secondary: AppColors.goldLight,
        onSecondary: Colors.black,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.danger,
        onError: Colors.white,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.input,

        hintStyle: const TextStyle(
          color: AppColors.textHint,
          fontSize: 14,
        ),

        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
        ),

        floatingLabelStyle: const TextStyle(
          color: AppColors.gold,
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.gold,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.danger,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.danger,
            width: 1.5,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: Colors.black,
          disabledBackgroundColor: AppColors.surfaceLight,
          disabledForegroundColor: AppColors.textDisabled,

          elevation: 0,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.gold,
          minimumSize: const Size(0, 48),
          side: const BorderSide(
            color: AppColors.goldDark,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.gold,
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          backgroundColor: AppColors.surfaceLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: AppColors.border,
            ),
          ),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.goldSurface,
        disabledColor: AppColors.surfaceLight,

        side: const BorderSide(
          color: AppColors.border,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),

        secondaryLabelStyle: const TextStyle(
          color: AppColors.gold,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
      ),

      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),

        titleLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

        titleMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),

        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 15,
        ),

        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),

        bodySmall: TextStyle(
          color: AppColors.textHint,
          fontSize: 12,
        ),

        labelLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

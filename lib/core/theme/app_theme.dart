import 'package:crypto_tracker_app/core/theme/app_constant_text_style.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData light() {
    const palette = AppPalette.light;
    const brightness = Brightness.light;
    final colorScheme = ColorScheme.light(
      surface: palette.screenBackground,
      onSurface: const Color(0xFF1C1C1E),
      primary: palette.positive,
      onPrimary: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.screenBackground,
      textTheme: AppConstantTextStyle.textTheme(
        brightness: brightness,
        palette: palette,
      ),
      extensions: const [palette],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: AppConstantTextStyle.appBarTitle(colorScheme.onSurface),
      ),
      dividerTheme: DividerThemeData(color: palette.border, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.cardBackground,
        hintStyle: AppConstantTextStyle.inputHint(palette),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: palette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: palette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: palette.subtleText.withValues(alpha: 0.6)),
        ),
      ),
    );
  }

  static ThemeData dark() {
    const palette = AppPalette.dark;
    const brightness = Brightness.dark;
    final colorScheme = ColorScheme.dark(
      surface: palette.screenBackground,
      onSurface: Colors.white,
      primary: palette.positive,
      onPrimary: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.screenBackground,
      textTheme: AppConstantTextStyle.textTheme(
        brightness: brightness,
        palette: palette,
      ),
      extensions: const [palette],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: AppConstantTextStyle.appBarTitle(colorScheme.onSurface),
      ),
      dividerTheme: DividerThemeData(color: palette.border, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.cardBackground,
        hintStyle: AppConstantTextStyle.inputHint(palette),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: palette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: palette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: palette.subtleText.withValues(alpha: 0.6)),
        ),
      ),
    );
  }
}

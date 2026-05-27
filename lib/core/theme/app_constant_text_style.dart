import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized typography built on [GoogleFonts.inter].
abstract final class AppConstantTextStyle {
  static TextTheme textTheme({
    required Brightness brightness,
    required AppPalette palette,
  }) {
    final onSurface =
        brightness == Brightness.dark ? Colors.white : const Color(0xFF1C1C1E);

    final base = GoogleFonts.interTextTheme(
      ThemeData(brightness: brightness).textTheme,
    ).apply(
      bodyColor: onSurface,
      displayColor: onSurface,
    );

    return base.copyWith(
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.05,
        color: onSurface,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        height: 1.05,
        color: onSurface,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.15,
        color: onSurface,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: palette.subtleText,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: onSurface,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: onSurface.withValues(alpha: 0.85),
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: palette.subtleText,
      ),
    );
  }

  static TextStyle sectionLabel(AppPalette palette) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
    color: palette.subtleText,
  );

  static TextStyle liveSourceLabel(AppPalette palette) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    color: palette.subtleText,
  );

  static TextStyle marketsTitle(Color onSurface) => GoogleFonts.inter(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    height: 1.05,
    color: onSurface,
  );

  static TextStyle coinHeroName(AppPalette palette) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: palette.subtleText,
  );

  static TextStyle coinHeroPrice(Color onSurface) => GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.05,
    color: onSurface,
  );

  static TextStyle statCardLabel(AppPalette palette) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
    height: 1.2,
    color: palette.subtleText,
  );

  static TextStyle statCardValue(Color onSurface) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: onSurface,
  );

  static TextStyle tableHeader(AppPalette palette) => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6,
    color: palette.subtleText,
  );

  static TextStyle footerLink(AppPalette palette) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
    color: palette.subtleText,
  );

  static TextStyle inputHint(AppPalette palette) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: palette.subtleText,
  );

  static TextStyle appBarTitle(Color onSurface) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: onSurface,
  );

  static TextStyle changeBadge({
    required Color color,
    required bool compact,
  }) => GoogleFonts.inter(
    fontSize: compact ? 11 : 12,
    fontWeight: FontWeight.w600,
    color: color,
  );
}

extension AppConstantTextStyleContext on BuildContext {
  TextTheme get appTextStyles => Theme.of(this).textTheme;

  Color get _onSurface => Theme.of(this).colorScheme.onSurface;

  AppPalette get _palette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;

  TextStyle get sectionLabel => AppConstantTextStyle.sectionLabel(_palette);

  TextStyle get liveSourceLabel =>
      AppConstantTextStyle.liveSourceLabel(_palette);

  TextStyle get marketsTitle => AppConstantTextStyle.marketsTitle(_onSurface);

  TextStyle get coinHeroName => AppConstantTextStyle.coinHeroName(_palette);

  TextStyle get coinHeroPrice => AppConstantTextStyle.coinHeroPrice(_onSurface);

  TextStyle get statCardLabel => AppConstantTextStyle.statCardLabel(_palette);

  TextStyle get statCardValue => AppConstantTextStyle.statCardValue(_onSurface);

  TextStyle get tableHeader => AppConstantTextStyle.tableHeader(_palette);

  TextStyle get footerLink => AppConstantTextStyle.footerLink(_palette);

  TextStyle get appBarTitleStyle =>
      AppConstantTextStyle.appBarTitle(_onSurface);
}

import 'package:flutter/material.dart';

@immutable
final class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.screenBackground,
    required this.cardBackground,
    required this.statCardBackground,
    required this.subtleText,
    required this.positive,
    required this.negative,
    required this.positiveSurface,
    required this.negativeSurface,
    required this.border,
    required this.liveDot,
  });

  final Color screenBackground;
  final Color cardBackground;
  final Color statCardBackground;
  final Color subtleText;
  final Color positive;
  final Color negative;
  final Color positiveSurface;
  final Color negativeSurface;
  final Color border;
  final Color liveDot;

  static const light = AppPalette(
    screenBackground: Color(0xFFFFFFFF),
    cardBackground: Color(0xFFFFFFFF),
    statCardBackground: Color(0xFFF6F6F8),
    subtleText: Color(0xFF8A8A8E),
    positive: Color(0xFF1F9D6A),
    negative: Color(0xFFD64545),
    positiveSurface: Color(0xFFE6F6EE),
    negativeSurface: Color(0xFFFCEAEA),
    border: Color(0xFFEBEBEB),
    liveDot: Color(0xFF1F9D6A),
  );

  static const dark = AppPalette(
    screenBackground: Color(0xFF0A0A0A),
    cardBackground: Color(0xFF171717),
    statCardBackground: Color(0xFF171717),
    subtleText: Color(0xFF8E8E93),
    positive: Color(0xFF3DDC97),
    negative: Color(0xFFFF6B6B),
    positiveSurface: Color(0xFF163528),
    negativeSurface: Color(0xFF3A1F1F),
    border: Color(0xFF2A2A2A),
    liveDot: Color(0xFF3DDC97),
  );

  @override
  AppPalette copyWith({
    Color? screenBackground,
    Color? cardBackground,
    Color? statCardBackground,
    Color? subtleText,
    Color? positive,
    Color? negative,
    Color? positiveSurface,
    Color? negativeSurface,
    Color? border,
    Color? liveDot,
  }) {
    return AppPalette(
      screenBackground: screenBackground ?? this.screenBackground,
      cardBackground: cardBackground ?? this.cardBackground,
      statCardBackground: statCardBackground ?? this.statCardBackground,
      subtleText: subtleText ?? this.subtleText,
      positive: positive ?? this.positive,
      negative: negative ?? this.negative,
      positiveSurface: positiveSurface ?? this.positiveSurface,
      negativeSurface: negativeSurface ?? this.negativeSurface,
      border: border ?? this.border,
      liveDot: liveDot ?? this.liveDot,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      screenBackground: Color.lerp(screenBackground, other.screenBackground, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      statCardBackground:
          Color.lerp(statCardBackground, other.statCardBackground, t)!,
      subtleText: Color.lerp(subtleText, other.subtleText, t)!,
      positive: Color.lerp(positive, other.positive, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
      positiveSurface: Color.lerp(positiveSurface, other.positiveSurface, t)!,
      negativeSurface: Color.lerp(negativeSurface, other.negativeSurface, t)!,
      border: Color.lerp(border, other.border, t)!,
      liveDot: Color.lerp(liveDot, other.liveDot, t)!,
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}

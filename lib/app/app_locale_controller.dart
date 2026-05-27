import 'package:flutter/material.dart';

/// Exposes the user-selected app [locale] to descendants of [MaterialApp].
final class AppLocaleController extends InheritedWidget {
  const AppLocaleController({
    required this.locale,
    required this.setLocale,
    required super.child,
    super.key,
  });

  final Locale? locale;
  final ValueChanged<Locale> setLocale;

  static AppLocaleController of(BuildContext context) {
    final controller = context
        .dependOnInheritedWidgetOfExactType<AppLocaleController>();
    assert(controller != null, 'AppLocaleController not found in context');
    return controller!;
  }

  @override
  bool updateShouldNotify(AppLocaleController oldWidget) =>
      locale != oldWidget.locale;
}

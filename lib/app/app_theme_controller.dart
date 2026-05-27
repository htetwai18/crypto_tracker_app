import 'package:flutter/material.dart';

/// Exposes the user-selected [themeMode] to descendants of [MaterialApp].
final class AppThemeController extends InheritedWidget {
  const AppThemeController({
    required this.themeMode,
    required this.setThemeMode,
    required super.child,
    super.key,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> setThemeMode;

  static AppThemeController of(BuildContext context) {
    final controller =
        context.dependOnInheritedWidgetOfExactType<AppThemeController>();
    assert(controller != null, 'AppThemeController not found in context');
    return controller!;
  }

  @override
  bool updateShouldNotify(AppThemeController oldWidget) =>
      themeMode != oldWidget.themeMode;
}

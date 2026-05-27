import 'package:crypto_tracker_app/app/app_route.dart';
import 'package:crypto_tracker_app/app/app_locale_controller.dart';
import 'package:crypto_tracker_app/app/app_theme_controller.dart';
import 'package:crypto_tracker_app/core/theme/app_theme.dart';
import 'package:crypto_tracker_app/di/injection.dart';
import 'package:crypto_tracker_app/presentation/coin_list/bloc/coin_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CryptoApp extends StatefulWidget {
  const CryptoApp({super.key});

  @override
  State<CryptoApp> createState() => _CryptoAppState();
}

class _CryptoAppState extends State<CryptoApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  void _setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  void _setThemeMode(ThemeMode themeMode) {
    setState(() => _themeMode = themeMode);
  }

  Locale _resolveLocale(Locale? deviceLocale, Iterable<Locale> supported) {
    if (_locale != null) return _locale!;

    if (deviceLocale != null &&
        supported.any((l) => l.languageCode == deviceLocale.languageCode)) {
      return Locale(deviceLocale.languageCode);
    }

    return supported.firstWhere(
      (l) => l.languageCode == 'en',
      orElse: () => const Locale('en'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLocaleController(
      locale: _locale,
      setLocale: _setLocale,
      child: AppThemeController(
        themeMode: _themeMode,
        setThemeMode: _setThemeMode,
        child: BlocProvider(
          create: (_) => sl<CoinListBloc>(),
          child: MaterialApp(
            locale: _locale,
            onGenerateTitle: (ctx) =>
                AppLocalizations.of(ctx)?.appTitle ?? 'Crypto Tracker',
            debugShowCheckedModeBanner: false,
            themeMode: _themeMode,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: _resolveLocale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoute.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}

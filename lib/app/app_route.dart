import 'package:crypto_tracker_app/di/injection.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:crypto_tracker_app/presentation/coin_detail/bloc/coin_detail_bloc.dart';
import 'package:crypto_tracker_app/presentation/coin_detail/view/coin_detail_page.dart';
import 'package:crypto_tracker_app/presentation/coin_list/view/coin_list_page.dart';
import 'package:crypto_tracker_app/presentation/splash/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Named route paths for the app.
abstract final class AppRoutes {
  static const splash = '/splash';
  static const home = '/';
  static const coinDetail = '/coin-detail';
}

/// Arguments for [AppRoutes.coinDetail].
final class CoinDetailRouteArgs {
  const CoinDetailRouteArgs({required this.summary});

  final CoinSummary summary;
}

/// Central route table and navigation helpers.
abstract final class AppRoute {
  static const _pushDuration = Duration(milliseconds: 320);
  static const _popDuration = Duration(milliseconds: 280);

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(settings: settings, child: const SplashPage());
      case AppRoutes.home:
        return _buildRoute(settings: settings, child: const CoinListPage());
      case AppRoutes.coinDetail:
        final args = settings.arguments;
        if (args is! CoinDetailRouteArgs) {
          return _buildRoute(
            settings: settings,
            child: const _UnknownRoutePage(),
          );
        }
        final summary = args.summary;
        return _buildRoute(
          settings: settings,
          child: BlocProvider(
            create: (_) => CoinDetailBloc(
              coinId: summary.id,
              watchFavoriteIds: sl(),
              getCoinDetailUseCase: sl(),
              toggleFavoriteUseCase: sl(),
            ),
            child: CoinDetailPage(summary: summary),
          ),
          transition: AppRouteTransition.slideWithFade,
        );
      default:
        return _buildRoute(
          settings: settings,
          child: const _UnknownRoutePage(),
        );
    }
  }

  static void completeSplash(BuildContext context) {
    Navigator.of(context).pushReplacement(
      _buildRoute<void>(
        settings: const RouteSettings(name: AppRoutes.home),
        child: const CoinListPage(),
        transition: AppRouteTransition.fade,
      ),
    );
  }

  static Future<void> openCoinDetail(
    BuildContext context,
    CoinSummary summary,
  ) {
    return Navigator.of(context).pushNamed<void>(
      AppRoutes.coinDetail,
      arguments: CoinDetailRouteArgs(summary: summary),
    );
  }

  static Route<T> _buildRoute<T>({
    required RouteSettings settings,
    required Widget child,
    AppRouteTransition transition = AppRouteTransition.none,
  }) {
    if (transition == AppRouteTransition.none) {
      return MaterialPageRoute<T>(settings: settings, builder: (_) => child);
    }

    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: _pushDuration,
      reverseTransitionDuration: _popDuration,
      pageBuilder: (_, animation, secondaryAnimation) => child,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        return _AppRouteTransitions.build(
          transition: transition,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
    );
  }
}

enum AppRouteTransition { none, fade, slideWithFade }

abstract final class _AppRouteTransitions {
  static Widget build({
    required AppRouteTransition transition,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
  }) {
    switch (transition) {
      case AppRouteTransition.none:
        return child;
      case AppRouteTransition.fade:
        return _fade(animation: animation, child: child);
      case AppRouteTransition.slideWithFade:
        return _slideWithFade(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
    }
  }

  static Widget _fade({
    required Animation<double> animation,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: child,
    );
  }

  static Widget _slideWithFade({
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
  }) {
    const curve = Curves.easeOutCubic;
    final slideIn = Tween<Offset>(
      begin: const Offset(0.12, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));
    final fadeIn = CurvedAnimation(parent: animation, curve: curve);

    return SlideTransition(
      position: slideIn,
      child: FadeTransition(opacity: fadeIn, child: child),
    );
  }
}

class _UnknownRoutePage extends StatelessWidget {
  const _UnknownRoutePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Route not found')),
    );
  }
}

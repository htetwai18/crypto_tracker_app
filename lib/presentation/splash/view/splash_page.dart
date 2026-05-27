import 'package:crypto_tracker_app/app/app_route.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';
import 'package:crypto_tracker_app/presentation/coin_list/bloc/coin_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  static const _minDisplayDuration = Duration(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    context.read<CoinListBloc>().add(const CoinListOpened());

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _scaleAnimation = Tween<double>(begin: 0.88, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future<void>.delayed(_minDisplayDuration);
    if (!mounted) return;
    AppRoute.completeSplash(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;

    return Scaffold(
      backgroundColor: palette.screenBackground,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: palette.positiveSurface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.currency_bitcoin,
                    size: 44,
                    color: palette.positive,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.appTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: palette.positive,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

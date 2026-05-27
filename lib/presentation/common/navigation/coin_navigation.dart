import 'package:crypto_tracker_app/app/app_route.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:flutter/material.dart';

export 'package:crypto_tracker_app/presentation/common/formatters/market_formatters.dart';

/// Push coin detail with animated route transition.
Future<void> openCoinDetail(BuildContext context, CoinSummary summary) =>
    AppRoute.openCoinDetail(context, summary);

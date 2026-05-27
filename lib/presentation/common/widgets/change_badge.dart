import 'package:crypto_tracker_app/core/theme/app_constant_text_style.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/presentation/common/formatters/market_formatters.dart';
import 'package:flutter/material.dart';

class ChangeBadge extends StatelessWidget {
  const ChangeBadge({
    super.key,
    required this.changePercent,
    this.compact = false,
  });

  final double? changePercent;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    if (changePercent == null) {
      return Text(
        '—',
        style: AppConstantTextStyle.changeBadge(
          color: palette.subtleText,
          compact: compact,
        ),
      );
    }

    final positive = changePercent! >= 0;
    final bg = positive ? palette.positiveSurface : palette.negativeSurface;
    final fg = positive ? palette.positive : palette.negative;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 8,
        vertical: compact ? 3 : 4,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        formatPercentChange(changePercent),
        style: AppConstantTextStyle.changeBadge(color: fg, compact: compact),
      ),
    );
  }
}

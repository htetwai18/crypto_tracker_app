import 'package:crypto_tracker_app/core/theme/app_constant_text_style.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';
import 'package:crypto_tracker_app/presentation/common/widgets/app_settings_icons.dart';
import 'package:flutter/material.dart';

class MarketsHeader extends StatelessWidget {
  const MarketsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 12, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: palette.liveDot,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.liveSourceLabel,
                      style: context.liveSourceLabel,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.marketsTitle,
                  style: context.marketsTitle,
                ),
              ],
            ),
          ),
          const AppSettingsIcons(),
        ],
      ),
    );
  }
}

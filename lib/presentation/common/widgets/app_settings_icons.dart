import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';
import 'package:crypto_tracker_app/presentation/common/widgets/language_picker_dialog.dart';
import 'package:crypto_tracker_app/presentation/common/widgets/theme_picker_dialog.dart';
import 'package:flutter/material.dart';

/// Separate language and theme icon buttons for the app bar / header.
class AppSettingsIcons extends StatelessWidget {
  const AppSettingsIcons({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final iconColor = context.palette.subtleText;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: l10n.switchLanguage,
          icon: Icon(Icons.language, color: iconColor),
          onPressed: () => showLanguagePickerDialog(context),
        ),
        IconButton(
          tooltip: l10n.themeDialogTitle,
          icon: Icon(Icons.brightness_6_outlined, color: iconColor),
          onPressed: () => showThemePickerDialog(context),
        ),
      ],
    );
  }
}

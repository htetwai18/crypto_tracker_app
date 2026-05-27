import 'package:crypto_tracker_app/app/app_locale_controller.dart';
import 'package:crypto_tracker_app/core/theme/app_constant_text_style.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

Future<void> showLanguagePickerDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => const _LanguagePickerDialog(),
  );
}

class _LanguagePickerDialog extends StatelessWidget {
  const _LanguagePickerDialog();

  static const _english = Locale('en');
  static const _myanmar = Locale('my');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    final localeController = AppLocaleController.of(context);
    final current = Localizations.localeOf(context);

    return Dialog(
      backgroundColor: palette.screenBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.languageDialogTitle,
              style: context.appTextStyles.titleMedium,
            ),
            const SizedBox(height: 16),
            _LanguageOptionTile(
              label: 'English',
              selected: current.languageCode == _english.languageCode,
              onTap: () {
                localeController.setLocale(_english);
                Navigator.of(context).pop();
              },
            ),
            _LanguageOptionTile(
              label: 'မြန်မာ',
              selected: current.languageCode == _myanmar.languageCode,
              onTap: () {
                localeController.setLocale(_myanmar);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: selected ? palette.statCardBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? palette.positive : palette.border,
            ),
          ),
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: context.appTextStyles.titleSmall,
                ),
              ),
              if (selected)
                Icon(Icons.check_circle, color: palette.positive, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:crypto_tracker_app/app/app_theme_controller.dart';
import 'package:crypto_tracker_app/core/theme/app_constant_text_style.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

Future<void> showThemePickerDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => const _ThemePickerDialog(),
  );
}

class _ThemePickerDialog extends StatelessWidget {
  const _ThemePickerDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    final themeController = AppThemeController.of(context);
    final current = themeController.themeMode;

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
              l10n.themeDialogTitle,
              style: context.appTextStyles.titleMedium,
            ),
            const SizedBox(height: 16),
            _ThemeOptionTile(
              label: l10n.themeLight,
              icon: Icons.light_mode_outlined,
              selected: current == ThemeMode.light,
              onTap: () {
                themeController.setThemeMode(ThemeMode.light);
                Navigator.of(context).pop();
              },
            ),
            _ThemeOptionTile(
              label: l10n.themeDark,
              icon: Icons.dark_mode_outlined,
              selected: current == ThemeMode.dark,
              onTap: () {
                themeController.setThemeMode(ThemeMode.dark);
                Navigator.of(context).pop();
              },
            ),
            _ThemeOptionTile(
              label: l10n.themeSystem,
              icon: Icons.brightness_auto_outlined,
              selected: current == ThemeMode.system,
              onTap: () {
                themeController.setThemeMode(ThemeMode.system);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOptionTile extends StatelessWidget {
  const _ThemeOptionTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
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
              Icon(icon, color: palette.subtleText, size: 22),
              const SizedBox(width: 12),
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

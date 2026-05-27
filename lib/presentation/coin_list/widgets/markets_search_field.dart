import 'package:crypto_tracker_app/core/theme/app_constant_text_style.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MarketsSearchField extends StatelessWidget {
  const MarketsSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  static const _height = 48.0;
  static const _borderRadius = 24.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDark
        ? palette.statCardBackground
        : const Color(0xFFF5F3F0);
    final borderColor = isDark ? palette.border : const Color(0xFFE5E2DE);

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: BorderSide(color: borderColor),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: SizedBox(
        height: _height,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: fillColor,
            hintText: l10n.searchHint,
            hintStyle: AppConstantTextStyle.inputHint(palette),
            prefixIcon: Icon(Icons.search, size: 20, color: palette.subtleText),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 44,
              minHeight: _height,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            border: outlineBorder,
            enabledBorder: outlineBorder,
            focusedBorder: outlineBorder,
            disabledBorder: outlineBorder,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// A compact, interactive chip component for tags, filters, or selections.
///
/// [HivesChip] displays a small, self-contained widget that can represent
/// tags, filter options, or selections with optional leading/trailing icons.
///
/// Example:
/// ```dart
/// HivesChip(
///   label: 'Flutter',
///   onPressed: () {},
///   icon: Icon(Icons.check),
/// )
/// ```
class HivesChip extends StatelessWidget {
  /// The text label of the chip.
  final String label;

  /// Callback invoked when the chip is tapped.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the label.
  final Widget? icon;

  /// Whether the chip is in selected state.
  final bool isSelected;

  /// Whether the chip is enabled for interaction.
  final bool isEnabled;

  /// Custom background color.
  final Color? backgroundColor;

  /// Custom text color.
  final Color? textColor;

  /// Custom border color.
  final Color? borderColor;

  /// Padding inside the chip.
  final EdgeInsets? padding;

  /// Border radius of the chip.
  final double? borderRadius;

  const HivesChip({
    Key? key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isSelected = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finalBorderRadius = borderRadius ?? 16.0;
    final finalPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);

    final chipBackgroundColor =
        backgroundColor ??
        (isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.secondaryContainer);

    final chipTextColor =
        textColor ??
        (isSelected
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSecondaryContainer);

    final chipBorderColor =
        borderColor ??
        (isSelected ? theme.colorScheme.primary : theme.colorScheme.outline);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(finalBorderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: isEnabled
                ? chipBackgroundColor
                : chipBackgroundColor.withValues(alpha: 0.5),
            border: Border.all(
              color: chipBorderColor.withValues(alpha: isEnabled ? 1.0 : 0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(finalBorderRadius),
          ),
          padding: finalPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 6.0)],
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isEnabled
                      ? chipTextColor
                      : chipTextColor.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// A compact, interactive chip component for tags, filters, or selections.
///
/// [HivesChip] now uses Material [ChoiceChip] when [isSelected] is provided,
/// otherwise an [ActionChip]. Visuals are driven by [ChipTheme].
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

  /// Custom background color. Prefer theme.
  final Color? backgroundColor;

  /// Custom text color. Prefer theme.
  final Color? textColor;

  /// Custom border color. Prefer theme.
  final Color? borderColor;

  /// Padding inside the chip. Prefer theme.
  final EdgeInsets? padding;

  /// Border radius of the chip. Prefer theme.
  final double? borderRadius;

  const HivesChip({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveLabel = Text(
      label,
      style: theme.textTheme.labelMedium?.copyWith(color: textColor),
    );
    final shape = borderRadius == null && borderColor == null
        ? null
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(color: borderColor!),
          );

    // Non-interactive visual chip
    if (onPressed == null) {
      return ChoiceChip(
        label: effectiveLabel,
        selected: isSelected,
        onSelected: null,
        avatar: icon,
        visualDensity: VisualDensity.compact,
        backgroundColor: backgroundColor,
        shape: shape,
        labelPadding: padding,
      );
    }

    if (isSelected) {
      return ChoiceChip(
        label: effectiveLabel,
        selected: isSelected,
        onSelected: isEnabled ? (_) => onPressed!.call() : null,
        avatar: icon,
        visualDensity: VisualDensity.compact,
        backgroundColor: backgroundColor,
        shape: shape,
        labelPadding: padding,
      );
    }

    return ActionChip(
      label: effectiveLabel,
      avatar: icon,
      onPressed: isEnabled ? onPressed : null,
      visualDensity: VisualDensity.compact,
      backgroundColor: backgroundColor,
      shape: shape,
      labelPadding: padding,
    );
  }
}

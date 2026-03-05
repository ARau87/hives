import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_spacing.dart';

/// Secondary action button with outlined style.
///
/// [SecondaryButton] is used for secondary actions that are less prominent
/// than primary actions. It wraps a Material [OutlinedButton] and relies on
/// theme configuration for its appearance.
class SecondaryButton extends StatelessWidget {
  /// The text displayed on the button.
  final String label;

  /// Callback invoked when the button is pressed.
  final VoidCallback onPressed;

  /// Whether the button is in loading state.
  final bool isLoading;

  /// Whether the button is enabled for interaction.
  final bool isEnabled;

  /// Optional icon widget displayed in the button.
  final Widget? icon;

  /// Whether the icon is displayed before the label.
  final bool iconLeading;

  /// Custom width of the button, or null for flexible width.
  final double? width;

  /// Custom height of the button, or null for default height.
  final double? height;

  /// Custom text style for the button label.
  final TextStyle? textStyle;

  /// Optional content padding override. Prefer theming.
  final EdgeInsets? padding;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.iconLeading = false,
    this.width,
    this.height,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final baseStyle = OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(borderRadius: AppSpacing.buttonRadius),
      side: BorderSide(
        color: isEnabled
            ? theme.colorScheme.primary
            : theme.colorScheme.outlineVariant,
        width: 2,
      ),
      minimumSize: const Size(64, AppSpacing.buttonHeight),
    );

    final button = OutlinedButton.icon(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: ButtonStyle(
        padding: padding != null
            ? WidgetStateProperty.all<EdgeInsets>(padding!)
            : null,
        iconAlignment: iconLeading ? IconAlignment.start : IconAlignment.end,
      ).merge(baseStyle),
      icon: icon,
      label: Text(
        label,
        style: TextStyle(
          color: isEnabled
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
        ).merge(textStyle),
      ),
    );

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }
    return button;
  }
}

import 'package:flutter/material.dart';

/// Primary action button with prominent color.
///
/// [PrimaryButton] is used for the main call-to-action on a screen.
/// It now wraps a Material [FilledButton] and relies on Button theming.
/// Avoids custom gesture handling and inline styles per widget rules.
class PrimaryButton extends StatelessWidget {
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

  const PrimaryButton({
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
    final button = FilledButton.icon(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: ButtonStyle(
        padding: padding != null
            ? WidgetStateProperty.all<EdgeInsets>(padding!)
            : null,
        iconAlignment: iconLeading ? IconAlignment.start : IconAlignment.end,
      ),
      icon: icon ?? const SizedBox.shrink(),
      label: Text(
        label,
        style: TextStyle(color: theme.colorScheme.onPrimary).merge(textStyle),
      ),
    );

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }
    return button;
  }
}

import 'package:flutter/material.dart';

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

    final child = _buildChild(theme);

    final button = OutlinedButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: padding != null
          ? ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(padding!))
          : null,
      child: child,
    );

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }
    return button;
  }

  Widget _buildChild(ThemeData theme) {
    final iconWidget = icon;
    final effectiveText = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textStyle,
    );

    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(child: effectiveText),
        ],
      );
    }

    if (iconWidget == null) {
      return effectiveText;
    }

    final children = <Widget>[
      if (iconLeading) iconWidget,
      if (iconLeading) const SizedBox(width: 8.0),
      Flexible(child: effectiveText),
      if (!iconLeading) const SizedBox(width: 8.0),
      if (!iconLeading) iconWidget,
    ];

    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}

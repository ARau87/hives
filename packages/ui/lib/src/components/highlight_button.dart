import 'package:flutter/material.dart';

/// A legacy customizable button with highlight effects.
///
/// Deprecated: Prefer [PrimaryButton] or directly use [FilledButton] with
/// theme-driven styles. This widget now delegates to a [FilledButton]
/// to comply with the Material-first widget rules.
@Deprecated('Use PrimaryButton or FilledButton with theme instead.')
class HighlightButton extends StatelessWidget {
  /// The text label displayed on the button.
  final String label;

  /// Callback invoked when the button is tapped.
  final VoidCallback onPressed;

  /// Whether the button is displaying a loading indicator.
  final bool isLoading;

  /// Whether the button is enabled for interaction.
  final bool isEnabled;

  /// Custom padding for the button content.
  final EdgeInsets? padding;

  /// Fixed width of the button, or null for flexible width.
  final double? width;

  /// Fixed height of the button, or null to use default height.
  final double? height;

  /// Custom text style for the button label.
  final TextStyle? textStyle;

  /// Optional icon widget to display in the button.
  final Widget? icon;

  /// Whether the icon appears before (true) or after (false) the label.
  final bool iconLeading;

  /// Duration of the tap animation effect (no longer used).
  final Duration animationDuration;

  const HighlightButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.padding,
    this.width,
    this.height,
    this.textStyle,
    this.icon,
    this.iconLeading = true,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final child = _buildChild(theme);

    final button = FilledButton(
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
    final effectiveText = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textStyle,
      textAlign: TextAlign.center,
    );

    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(child: effectiveText),
        ],
      );
    }

    if (icon == null) {
      return effectiveText;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (iconLeading) ...[icon!, const SizedBox(width: 8.0)],
        Flexible(child: effectiveText),
        if (!iconLeading) ...[const SizedBox(width: 8.0), icon!],
      ],
    );
  }
}

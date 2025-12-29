import 'package:flutter/material.dart';

import '../../theme/button_theme.dart';
import '../../theme/hives_colors.dart';

/// A prominent call-to-action button with gradient background using FilledButton.
///
/// The gradient is provided via an outer [DecoratedBox], while the
/// [FilledButton] handles interaction, semantics, and overlay. Sizing and
/// spacing are driven by [ButtonThemeTokens], and colors by [HivesColors].
class HighlightButton extends StatelessWidget {
  /// The text label displayed on the button.
  final String label;

  /// Callback invoked when the button is tapped.
  final VoidCallback onPressed;

  /// Whether the button is displaying a loading indicator.
  final bool isLoading;

  /// Whether the button is enabled for interaction.
  final bool isEnabled;

  /// Custom padding for the button content. Prefer theme.
  final EdgeInsets? padding;

  /// Fixed width of the button, or null for flexible width.
  final double? width;

  /// Fixed height of the button, or null to use theme min height.
  final double? height;

  /// Custom text style for the button label.
  final TextStyle? textStyle;

  /// Optional icon widget to display in the button.
  final Widget? icon;

  /// Whether the icon appears before (true) or after (false) the label.
  final bool iconLeading;

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
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.hivesColors;
    final tokens =
        theme.extension<ButtonThemeTokens>() ?? ButtonThemeTokens.standard();
    final radius = BorderRadius.circular(tokens.borderRadius);

    final gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        isEnabled && !isLoading
            ? colors.honey
            : colors.honey.withValues(alpha: tokens.disabledOpacity),
        isEnabled && !isLoading
            ? colors.orange
            : colors.orange.withValues(alpha: tokens.disabledOpacity),
      ],
    );

    final button = FilledButton.icon(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style:
          FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: radius),
            padding: padding,
            iconAlignment: iconLeading
                ? IconAlignment.start
                : IconAlignment.end,
            iconColor: theme.colorScheme.onPrimary,
            minimumSize: Size(width ?? 64, height ?? tokens.minHeight),
          ).merge(
            ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.white.withValues(
                    alpha: tokens.highlightOpacity,
                  );
                }
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.focused)) {
                  return Colors.white.withValues(alpha: tokens.splashOpacity);
                }
                return null;
              }),
            ),
          ),
      icon: icon ?? const SizedBox.shrink(),
      label: Text(
        label,
        style: TextStyle(color: theme.colorScheme.onPrimary).merge(textStyle),
      ),
    );

    final decorated = DecoratedBox(
      decoration: BoxDecoration(gradient: gradient, borderRadius: radius),
      child: ClipRRect(borderRadius: radius, child: button),
    );

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: decorated);
    }

    return decorated;
  }
}

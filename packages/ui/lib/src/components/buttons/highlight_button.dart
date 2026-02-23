import 'package:flutter/material.dart';
import 'package:ui/src/theme/button_theme.dart';
import 'package:ui/src/theme/hives_colors.dart';

/// A prominent call-to-action button with gradient background using FilledButton.
///
/// The gradient is provided via an outer [DecoratedBox], while the
/// [FilledButton] handles interaction, semantics, and overlay. Sizing and
/// spacing are driven by [ButtonThemeTokens], and colors by [HivesColors].
///
/// When [isLoading] is true, displays a shimmering animation effect.
class HighlightButton extends StatefulWidget {
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
  State<HighlightButton> createState() => _HighlightButtonState();
}

class _HighlightButtonState extends State<HighlightButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _shimmerAnimation = Tween<double>(begin: -0.5, end: 1.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.linear),
    );

    if (widget.isLoading) {
      _shimmerController.repeat();
    }
  }

  @override
  void didUpdateWidget(HighlightButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      _shimmerController.repeat();
    } else if (!widget.isLoading && oldWidget.isLoading) {
      _shimmerController.stop();
      _shimmerController.reset();
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

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
        widget.isEnabled && !widget.isLoading
            ? colors.honey
            : colors.honey.withValues(alpha: tokens.disabledOpacity),
        widget.isEnabled && !widget.isLoading
            ? colors.orange
            : colors.orange.withValues(alpha: tokens.disabledOpacity),
      ],
    );

    final button = FilledButton.icon(
      onPressed: widget.isEnabled && !widget.isLoading
          ? widget.onPressed
          : null,
      style:
          FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: radius),
            padding: widget.padding,
            iconAlignment: widget.iconLeading
                ? IconAlignment.start
                : IconAlignment.end,
            iconColor: theme.colorScheme.onPrimary,
            minimumSize: Size(
              widget.width ?? 64,
              widget.height ?? tokens.minHeight,
            ),
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
      icon: widget.icon ?? const SizedBox.shrink(),
      label: Text(
        widget.label,
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
        ).merge(widget.textStyle),
      ),
    );

    // Base decorated box with gradient
    final baseDecoration = DecoratedBox(
      decoration: BoxDecoration(gradient: gradient, borderRadius: radius),
      child: ClipRRect(borderRadius: radius, child: button),
    );

    // Wrap with shimmer if loading
    final decorated = widget.isLoading
        ? ClipRRect(
            borderRadius: radius,
            child: _buildShimmerEffect(context, gradient, radius, button),
          )
        : baseDecoration;

    // Ensure consistent sizing
    if (widget.width != null || widget.height != null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: decorated,
      );
    }

    return decorated;
  }

  /// Builds the shimmer effect for the loading state.
  Widget _buildShimmerEffect(
    BuildContext context,
    Gradient gradient,
    BorderRadius radius,
    Widget button,
  ) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        final double progress = _shimmerAnimation.value;

        return DecoratedBox(
          decoration: BoxDecoration(gradient: gradient, borderRadius: radius),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              button,
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: radius,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.0),
                          Colors.white.withValues(alpha: 0.5),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                        stops: [
                          (progress - 0.3).clamp(0.0, 1.0),
                          progress.clamp(0.0, 1.0),
                          (progress + 0.3).clamp(0.0, 1.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

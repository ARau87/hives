import 'package:flutter/material.dart';

/// Primary action button with prominent color.
///
/// [PrimaryButton] is used for the main call-to-action on a screen.
/// It now wraps a Material [FilledButton] and relies on Button theming.
/// Avoids custom gesture handling and inline styles per widget rules.
///
/// When [isLoading] is true, displays a shimmering animation effect.
class PrimaryButton extends StatefulWidget {
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
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
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
  void didUpdateWidget(PrimaryButton oldWidget) {
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
    final button = FilledButton.icon(
      onPressed: widget.isEnabled && !widget.isLoading
          ? widget.onPressed
          : null,
      style: ButtonStyle(
        padding: widget.padding != null
            ? WidgetStateProperty.all<EdgeInsets>(widget.padding!)
            : null,
        iconAlignment: widget.iconLeading
            ? IconAlignment.start
            : IconAlignment.end,
      ),
      icon: widget.icon ?? const SizedBox.shrink(),
      label: Text(
        widget.label,
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
        ).merge(widget.textStyle),
      ),
    );

    // Apply shimmer effect when loading
    final decorated = widget.isLoading
        ? _buildShimmerEffect(context, button)
        : button;

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
  Widget _buildShimmerEffect(BuildContext context, Widget button) {
    final theme = Theme.of(context);
    final buttonStyle = theme.filledButtonTheme.style;
    final shape = buttonStyle?.shape?.resolve({}) as RoundedRectangleBorder?;
    final radius =
        shape?.borderRadius as BorderRadius? ?? BorderRadius.circular(20.0);

    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        final double progress = _shimmerAnimation.value;

        return ClipRRect(
          borderRadius: radius,
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

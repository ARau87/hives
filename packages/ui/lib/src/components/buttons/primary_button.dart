import 'package:flutter/material.dart';

/// Primary action button with prominent color.
///
/// [PrimaryButton] is used for the main call-to-action on a screen.
/// It uses the theme's primary color and provides visual feedback
/// on interaction with scale animation.
///
/// Example:
/// ```dart
/// PrimaryButton(
///   label: 'Get Started',
///   onPressed: () => Navigator.of(context).pushNamed('/home'),
/// )
/// ```
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

  /// Padding inside the button.
  final EdgeInsets? padding;

  const PrimaryButton({
    Key? key,
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
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.isEnabled && !widget.isLoading) {
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = !widget.isEnabled || widget.isLoading;
    final opacity = isDisabled ? 0.5 : 1.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.isEnabled && !widget.isLoading ? widget.onPressed : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.width,
          height: widget.height ?? 48.0,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(
                  alpha: 0.3 * opacity,
                ),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: null, // Handled by GestureDetector
              child: Padding(
                padding:
                    widget.padding ??
                    const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.isLoading)
                        SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.onPrimary,
                            ),
                          ),
                        )
                      else if (widget.icon != null && widget.iconLeading)
                        IconTheme(
                          data: IconThemeData(
                            color: theme.colorScheme.onPrimary,
                          ),
                          child: widget.icon!,
                        ),
                      if ((widget.isLoading || widget.icon != null) &&
                          !(!widget.iconLeading && widget.icon != null))
                        const SizedBox(width: 8.0),
                      if (!widget.isLoading)
                        Flexible(
                          child: Text(
                            widget.label,
                            style:
                                widget.textStyle ??
                                theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (!widget.isLoading &&
                          widget.icon != null &&
                          !widget.iconLeading)
                        const SizedBox(width: 8.0),
                      if (!widget.isLoading &&
                          widget.icon != null &&
                          !widget.iconLeading)
                        IconTheme(
                          data: IconThemeData(
                            color: theme.colorScheme.onPrimary,
                          ),
                          child: widget.icon!,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

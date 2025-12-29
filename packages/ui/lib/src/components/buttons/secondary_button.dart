import 'package:flutter/material.dart';

/// Secondary action button with outlined style.
///
/// [SecondaryButton] is used for secondary actions that are less prominent
/// than primary actions. It uses an outlined style with the theme's primary color.
///
/// Example:
/// ```dart
/// SecondaryButton(
///   label: 'Cancel',
///   onPressed: () => Navigator.of(context).pop(),
/// )
/// ```
class SecondaryButton extends StatefulWidget {
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

  const SecondaryButton({
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
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton>
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
            color: Colors.transparent,
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: opacity),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
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
                              theme.colorScheme.primary,
                            ),
                          ),
                        )
                      else if (widget.icon != null && widget.iconLeading)
                        IconTheme(
                          data: IconThemeData(
                            color: theme.colorScheme.primary.withValues(
                              alpha: opacity,
                            ),
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
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: opacity,
                                  ),
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
                            color: theme.colorScheme.primary.withValues(
                              alpha: opacity,
                            ),
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

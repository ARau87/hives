import 'package:flutter/material.dart';

import '../theme/button_theme.dart';
import '../theme/hives_colors.dart';
import '../theme/hives_spacings.dart';

/// A customizable button widget with highlight gradient and animation effects.
///
/// [HighlightButton] displays a button with a honey-to-orange gradient,
/// scale animation on tap, and support for loading and disabled states.
/// The button can optionally include an icon alongside the text.
class HighlightButton extends StatefulWidget {
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

  /// Duration of the tap animation effect.
  final Duration animationDuration;

  const HighlightButton({
    Key? key,
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
  }) : super(key: key);

  @override
  State<HighlightButton> createState() => _HighlightButtonState();
}

class _HighlightButtonState extends State<HighlightButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
  }

  void _initializeAnimation(double buttonScaleStart, double buttonScaleEnd) {
    _scaleAnimation =
        Tween<double>(begin: buttonScaleStart, end: buttonScaleEnd).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPressed() {
    if (widget.isEnabled && !widget.isLoading) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
      widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).hivesColors;
    final buttonTheme =
        Theme.of(context).extension<ButtonThemeTokens>() ??
        ButtonThemeTokens.standard();
    final spacings =
        Theme.of(context).extension<HivesSpacings>() ?? HivesSpacings.standard;
    final isDisabled = !widget.isEnabled || widget.isLoading;
    final buttonHeight = widget.height ?? buttonTheme.minHeight;

    // Initialize animation with theme values on first build
    _initializeAnimation(buttonTheme.scaleStart, buttonTheme.scaleEnd);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: widget.width,
          height: buttonHeight,
          child: Ink(
            decoration: BoxDecoration(
              gradient: isDisabled
                  ? LinearGradient(
                      colors: [
                        colors.honey.withValues(
                          alpha: buttonTheme.disabledOpacity,
                        ),
                        colors.orange.withValues(
                          alpha: buttonTheme.disabledOpacity,
                        ),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : LinearGradient(
                      colors: [colors.honey, colors.orange],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
              borderRadius: BorderRadius.circular(buttonTheme.borderRadius),
              boxShadow: isDisabled
                  ? null
                  : [
                      BoxShadow(
                        color: colors.honey.withValues(
                          alpha: buttonTheme.shadowOpacity,
                        ),
                        blurRadius: buttonTheme.shadowBlurRadius,
                        offset: buttonTheme.shadowOffset,
                      ),
                    ],
            ),
            child: InkWell(
              onTap: _onPressed,
              borderRadius: BorderRadius.circular(buttonTheme.borderRadius),
              splashColor: Colors.white.withValues(
                alpha: buttonTheme.splashOpacity,
              ),
              highlightColor: Colors.white.withValues(
                alpha: buttonTheme.highlightOpacity,
              ),
              child: Padding(
                padding:
                    widget.padding ??
                    EdgeInsets.symmetric(
                      horizontal: spacings.xxl,
                      vertical: spacings.lg,
                    ),
                child: widget.isLoading
                    ? Center(
                        child: SizedBox(
                          width: buttonTheme.loadingIndicatorSize,
                          height: buttonTheme.loadingIndicatorSize,
                          child: CircularProgressIndicator(
                            strokeWidth: buttonTheme.loadingStrokeWidth,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colors.honeyDark,
                            ),
                          ),
                        ),
                      )
                    : _buildContent(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final buttonTheme =
        Theme.of(context).extension<ButtonThemeTokens>() ??
        ButtonThemeTokens.standard();
    final textStyle =
        widget.textStyle ??
        Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        );

    if (widget.icon == null) {
      return Center(
        child: Text(
          widget.label,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Center(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.iconLeading) ...[
            widget.icon!,
            SizedBox(width: buttonTheme.iconTextSpacing),
          ],
          Flexible(
            child: Text(
              widget.label,
              style: textStyle,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!widget.iconLeading) ...[
            SizedBox(width: buttonTheme.iconTextSpacing),
            widget.icon!,
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_colors.dart';
import 'package:ui/src/theme/app_spacing.dart';

/// A destructive action button styled with urgent red fill.
///
/// Matches [PrimaryButton] sizing (54px height, 16px radius) but uses
/// `AppColors.urgentStatus` (`#EF4444`) as the background color with a
/// red-tinted drop shadow.
///
/// Supports `isLoading` (shows a white spinner) and `isEnabled` (reduces
/// opacity to 0.5) states.
class HivesDangerButton extends StatelessWidget {
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

  const HivesDangerButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.iconLeading = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveEnabled = isEnabled && !isLoading;

    final button = FilledButton(
      onPressed: effectiveEnabled ? onPressed : null,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.urgentStatus,
        disabledBackgroundColor: AppColors.urgentStatus,
        foregroundColor: Colors.white,
        disabledForegroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: AppSpacing.buttonRadius,
        ),
        minimumSize: const Size(120, AppSpacing.buttonHeight),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null && iconLeading) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                Text(label),
                if (icon != null && !iconLeading) ...[
                  const SizedBox(width: 8),
                  icon!,
                ],
              ],
            ),
    );

    Widget result = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppSpacing.buttonRadius,
        boxShadow: effectiveEnabled
            ? [
                BoxShadow(
                  color: AppColors.urgentStatus.withValues(alpha: 0.30),
                  offset: const Offset(0, 6),
                  blurRadius: 16,
                ),
              ]
            : null,
      ),
      child: button,
    );

    if (!isEnabled) {
      result = Opacity(opacity: 0.5, child: result);
    }

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: result);
    }
    return result;
  }
}

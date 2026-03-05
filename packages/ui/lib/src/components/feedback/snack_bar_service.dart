import 'package:flutter/material.dart';
import 'package:ui/src/extensions/context_extensions.dart';
import 'package:ui/src/theme/app_spacing.dart';

/// Service for showing branded snackbar messages.
///
/// All snackbars use floating behavior, 12px rounded corners ([AppSpacing.chipRadius]),
/// and status colors from [HivesColors]. Icon and text are always white on the
/// colored background.
///
/// Usage:
/// ```dart
/// SnackBarService.showSuccess(context, 'Hive saved successfully');
/// SnackBarService.showError(context, 'Failed to sync data');
/// SnackBarService.showInfo(context, 'Tap a hive to inspect');
/// ```
abstract final class SnackBarService {
  /// Shows a green success snackbar with a check icon. Visible for 3 seconds.
  static void showSuccess(BuildContext context, String message) => _show(
    context,
    message,
    context.colors.healthyStatus,
    Icons.check_circle,
    const Duration(seconds: 3),
  );

  /// Shows a red error snackbar with an error icon. Visible for 4 seconds.
  static void showError(BuildContext context, String message) => _show(
    context,
    message,
    context.colors.urgentStatus,
    Icons.error,
    const Duration(seconds: 4),
  );

  /// Shows an amber info snackbar with an info icon. Visible for 3 seconds.
  static void showInfo(BuildContext context, String message) => _show(
    context,
    message,
    context.colors.honey,
    Icons.info,
    const Duration(seconds: 3),
  );

  static void _show(
    BuildContext context,
    String message,
    Color backgroundColor,
    IconData icon,
    Duration duration,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: AppSpacing.chipRadius,
          ),
          duration: duration,
        ),
      );
  }
}

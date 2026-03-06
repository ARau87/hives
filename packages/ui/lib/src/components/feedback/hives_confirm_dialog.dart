import 'package:flutter/material.dart';
import 'package:ui/src/components/buttons/hives_danger_button.dart';
import 'package:ui/src/components/buttons/primary_button.dart';
import 'package:ui/src/components/buttons/text_button.dart';
import 'package:ui/src/components/surfaces/hives_bottom_sheet.dart';
import 'package:ui/src/theme/app_colors.dart';
import 'package:ui/src/theme/app_spacing.dart';
import 'package:ui/src/theme/app_typography.dart';

/// Variants for the [HivesConfirmDialog] widget.
enum HivesConfirmDialogVariant {
  /// Red-tinted destructive confirmation (delete, remove).
  danger,

  /// Amber-tinted warning confirmation (proceed with caution).
  warning,
}

/// A confirmation dialog rendered inside a bottom sheet.
///
/// Displays an icon, title, body text, and a pair of action buttons
/// (confirm + cancel). Use [HivesConfirmDialog.show] for convenient
/// one-liner invocation via [showHivesBottomSheet].
class HivesConfirmDialog extends StatelessWidget {
  /// The icon displayed at the top of the dialog.
  final IconData icon;

  /// The title text (18px SemiBold).
  final String title;

  /// The body text (15px Regular, onSurfaceVariant).
  final String body;

  /// The label for the confirm button.
  final String confirmLabel;

  /// Callback invoked when the confirm button is tapped.
  final VoidCallback onConfirm;

  /// Callback invoked when the cancel button is tapped.
  /// Defaults to popping the bottom sheet.
  final VoidCallback? onCancel;

  /// The visual variant: [danger] (red) or [warning] (amber).
  final HivesConfirmDialogVariant variant;

  /// Optional cancel button label. Defaults to "Cancel".
  final String cancelLabel;

  const HivesConfirmDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.confirmLabel,
    required this.onConfirm,
    this.onCancel,
    this.variant = HivesConfirmDialogVariant.danger,
    this.cancelLabel = 'Cancel',
  });

  /// Shows a [HivesConfirmDialog] inside a modal bottom sheet.
  ///
  /// Returns `true` if the user confirmed, `null` if dismissed.
  static Future<bool?> show({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String body,
    required String confirmLabel,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    HivesConfirmDialogVariant variant = HivesConfirmDialogVariant.danger,
    String cancelLabel = 'Cancel',
  }) {
    return showHivesBottomSheet<bool>(
      context: context,
      isDismissible: true,
      builder: (ctx) => HivesConfirmDialog(
        icon: icon,
        title: title,
        body: body,
        confirmLabel: confirmLabel,
        onConfirm: () {
          onConfirm();
          Navigator.of(ctx).pop(true);
        },
        onCancel: onCancel ?? () => Navigator.of(ctx).pop(),
        variant: variant,
        cancelLabel: cancelLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = variant == HivesConfirmDialogVariant.danger
        ? AppColors.urgentStatus
        : AppColors.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Icon(icon, size: 48, color: iconColor),
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            body,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          SizedBox(
            width: double.infinity,
            child: variant == HivesConfirmDialogVariant.danger
                ? HivesDangerButton(
                    label: confirmLabel,
                    onPressed: onConfirm,
                  )
                : PrimaryButton(
                    label: confirmLabel,
                    onPressed: onConfirm,
                  ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: PlainTextButton(
              label: cancelLabel,
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

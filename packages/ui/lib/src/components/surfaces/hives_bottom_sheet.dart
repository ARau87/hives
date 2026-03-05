import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_spacing.dart';

/// Shows a themed modal bottom sheet with Hives design language.
///
/// Uses [AppSpacing.modalTopRadius] (28px top corners) and includes
/// a drag handle bar. Returns `Future<T?>` from the modal.
///
/// Example:
/// ```dart
/// final result = await showHivesBottomSheet<String>(
///   context: context,
///   builder: (ctx) => const YourContent(),
/// );
/// ```
Future<T?> showHivesBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: AppSpacing.modalTopRadius,
    ),
    builder: (ctx) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: Container(
            width: AppSpacing.dragHandleWidth,
            height: AppSpacing.dragHandleHeight,
            decoration: BoxDecoration(
              color: Theme.of(ctx).colorScheme.outlineVariant,
              borderRadius: AppSpacing.dragHandleRadius,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        builder(ctx),
      ],
    ),
  );
}

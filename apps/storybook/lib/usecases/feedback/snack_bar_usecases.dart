import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Placeholder type for the snack bar service usecase annotation.
class SnackBarDemo extends StatelessWidget {
  const SnackBarDemo({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

/// Interactive demo with buttons triggering each snack bar variant.
@widgetbook.UseCase(
  name: 'All Variants',
  type: SnackBarDemo,
  path: 'components/feedback',
)
Widget snackBarAllVariants(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'Inspection saved successfully',
  );

  return Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Show Success',
            icon: const Icon(Icons.check_circle),
            iconLeading: true,
            onPressed: () => SnackBarService.showSuccess(context, message),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: 'Show Error',
            icon: const Icon(Icons.error),
            iconLeading: true,
            onPressed: () => SnackBarService.showError(context, message),
          ),
          const SizedBox(height: AppSpacing.lg),
          SecondaryButton(
            label: 'Show Info',
            icon: const Icon(Icons.info),
            iconLeading: true,
            onPressed: () => SnackBarService.showInfo(context, message),
          ),
        ],
      ),
    ),
  );
}

/// Demonstrates that new snack bars dismiss the current one.
@widgetbook.UseCase(
  name: 'Auto Dismiss',
  type: SnackBarDemo,
  path: 'components/feedback',
)
Widget snackBarAutoDismiss(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Tap buttons quickly to see auto-dismiss behavior'),
          const SizedBox(height: AppSpacing.xxl),
          PrimaryButton(
            label: 'Show First',
            onPressed: () =>
                SnackBarService.showSuccess(context, 'First message'),
          ),
          const SizedBox(height: AppSpacing.sm),
          SecondaryButton(
            label: 'Show Second',
            onPressed: () =>
                SnackBarService.showError(context, 'Second replaces first'),
          ),
        ],
      ),
    ),
  );
}

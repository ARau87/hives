import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Placeholder type for the bottom sheet usecase annotation.
class BottomSheetDemo extends StatelessWidget {
  const BottomSheetDemo({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

@widgetbook.UseCase(
  name: 'Default Content',
  type: BottomSheetDemo,
  path: 'components/surfaces',
)
Widget bottomSheetDefault(BuildContext context) {
  return Scaffold(
    body: Center(
      child: PrimaryButton(
        label: 'Show Bottom Sheet',
        onPressed: () => showHivesBottomSheet(
          context: context,
          builder: (ctx) => Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Bottom Sheet Title',
                    style: Theme.of(ctx).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'This is the Hives bottom sheet with a drag handle, '
                  '28px top corner radius, and themed surface color.',
                  style: Theme.of(ctx).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Scrollable Content',
  type: BottomSheetDemo,
  path: 'components/surfaces',
)
Widget bottomSheetScrollable(BuildContext context) {
  return Scaffold(
    body: Center(
      child: PrimaryButton(
        label: 'Show Scrollable Sheet',
        onPressed: () => showHivesBottomSheet(
          context: context,
          builder: (ctx) => SizedBox(
            height: MediaQuery.of(ctx).size.height * 0.6,
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              itemCount: 20,
              itemBuilder: (_, index) => HivesListTile(
                title: Text('Item ${index + 1}'),
                showDivider: true,
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Non-Dismissible',
  type: BottomSheetDemo,
  path: 'components/surfaces',
)
Widget bottomSheetNonDismissible(BuildContext context) {
  final isDismissible = context.knobs.boolean(
    label: 'Is Dismissible',
    initialValue: false,
  );
  final enableDrag = context.knobs.boolean(
    label: 'Enable Drag',
    initialValue: false,
  );

  return Scaffold(
    body: Center(
      child: PrimaryButton(
        label: 'Show Locked Sheet',
        onPressed: () => showHivesBottomSheet(
          context: context,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          builder: (ctx) => Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Locked Sheet',
                    style: Theme.of(ctx).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.lg),
                const Text(
                  'This sheet cannot be dismissed by tapping outside '
                  'or dragging down. Use the button to close.',
                ),
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: 'Close',
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

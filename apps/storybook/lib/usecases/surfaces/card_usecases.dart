import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: HivesCard)
Widget hivesCardDefault(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Card Title', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(
              'This is a card component with default styling and theme tokens.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Content', type: HivesCard)
Widget hivesCardWithContent(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hive Activity',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Status: Active',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Clickable', type: HivesCard)
Widget hivesCardClickable(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesCard(
        isClickable: true,
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Card tapped!')));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tap this card',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'This card responds to taps',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Elevation', type: HivesCard)
Widget hivesCardCustomElevation(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HivesCard(
            elevation: 0,
            child: Text(
              'Elevation: 0',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 16),
          HivesCard(
            elevation: 4,
            child: Text(
              'Elevation: 4',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 16),
          HivesCard(
            elevation: 8,
            child: Text(
              'Elevation: 8',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    ),
  );
}

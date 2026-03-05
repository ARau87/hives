import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: HivesListTile)
Widget hivesListTileDefault(BuildContext context) {
  return Center(
    child: HivesListTile(
      title: Text(
        context.knobs.string(label: 'Title', initialValue: 'Hive Alpha'),
      ),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'With Subtitle', type: HivesListTile)
Widget hivesListTileWithSubtitle(BuildContext context) {
  return Center(
    child: HivesListTile(
      title: const Text('Hive Alpha'),
      subtitle: const Text('Last inspected 2 days ago'),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'With Leading and Trailing', type: HivesListTile)
Widget hivesListTileWithLeadingTrailing(BuildContext context) {
  return Center(
    child: HivesListTile(
      title: const Text('Hive Alpha'),
      subtitle: const Text('Active'),
      leading: const Icon(Icons.hexagon_outlined),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'With Divider', type: HivesListTile)
Widget hivesListTileWithDivider(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      HivesListTile(
        title: const Text('First Item'),
        showDivider: true,
        onTap: () {},
      ),
      HivesListTile(
        title: const Text('Second Item'),
        showDivider: true,
        onTap: () {},
      ),
      HivesListTile(
        title: const Text('Last Item'),
        onTap: () {},
      ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: HivesListTile)
Widget hivesListTileDisabled(BuildContext context) {
  return Center(
    child: HivesListTile(
      title: const Text('Disabled Tile'),
      subtitle: const Text('This tile is not interactive'),
      leading: const Icon(Icons.block),
      isEnabled: false,
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Interactive', type: HivesListTile)
Widget hivesListTileInteractive(BuildContext context) {
  return Center(
    child: HivesListTile(
      title: Text(
        context.knobs.string(label: 'Title', initialValue: 'Hive Beta'),
      ),
      subtitle: const Text('Tap to interact'),
      showDivider: context.knobs.boolean(
        label: 'Show Divider',
        initialValue: false,
      ),
      isEnabled: context.knobs.boolean(
        label: 'Is Enabled',
        initialValue: true,
      ),
      leading: const Icon(Icons.hexagon_outlined),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    ),
  );
}

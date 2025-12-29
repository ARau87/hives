import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: HivesChip)
Widget hivesChipDefault(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 8,
      children: [
        HivesChip(label: 'Flutter', onPressed: () {}),
        HivesChip(label: 'Dart', onPressed: () {}),
        HivesChip(label: 'UI Kit', onPressed: () {}),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Selected', type: HivesChip)
Widget hivesChipSelected(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 8,
      children: [
        HivesChip(label: 'Selected', onPressed: () {}, isSelected: true),
        HivesChip(label: 'Not Selected', onPressed: () {}, isSelected: false),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'With Icons', type: HivesChip)
Widget hivesChipWithIcons(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 8,
      children: [
        HivesChip(
          label: 'Verified',
          onPressed: () {},
          icon: const Icon(Icons.check, size: 16),
          isSelected: true,
        ),
        HivesChip(
          label: 'Favorite',
          onPressed: () {},
          icon: const Icon(Icons.favorite, size: 16),
        ),
        HivesChip(
          label: 'Star',
          onPressed: () {},
          icon: const Icon(Icons.star, size: 16),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: HivesChip)
Widget hivesChipDisabled(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 8,
      children: [
        HivesChip(label: 'Disabled Chip', onPressed: null, isEnabled: false),
        HivesChip(label: 'Enabled Chip', onPressed: () {}, isEnabled: true),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Filter Tags', type: HivesChip)
Widget hivesChipFilterTags(BuildContext context) {
  final tags = ['Hive', 'Bee', 'Honey', 'Nature', 'Garden'];

  return Center(
    child: Wrap(
      spacing: 8,
      children: [
        for (final tag in tags)
          HivesChip(
            label: tag,
            onPressed: () {},
            isSelected: context.knobs.boolean(
              label: 'Select $tag',
              initialValue: tag == 'Hive',
            ),
          ),
      ],
    ),
  );
}

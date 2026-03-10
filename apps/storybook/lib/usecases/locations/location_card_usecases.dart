import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'With Image', type: HivesLocationCard)
Widget locationCardWithImage(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.screenMargin),
    child: HivesLocationCard(
      locationName: 'Meadow Apiary',
      statusSummary: '4 hives · All healthy',
      status: HivesLocationStatus.healthy,
      image: const AssetImage('assets/meadow_apiary.jpg'),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Healthy', type: HivesLocationCard)
Widget locationCardHealthy(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.screenMargin),
    child: HivesLocationCard(
      locationName: 'Meadow Apiary',
      statusSummary: '4 hives · All healthy',
      status: HivesLocationStatus.healthy,
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Attention', type: HivesLocationCard)
Widget locationCardAttention(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.screenMargin),
    child: HivesLocationCard(
      locationName: 'Forest Yard',
      statusSummary: '3 hives · 1 needs attention',
      status: HivesLocationStatus.attention,
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Urgent', type: HivesLocationCard)
Widget locationCardUrgent(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.screenMargin),
    child: HivesLocationCard(
      locationName: 'Hilltop Bees',
      statusSummary: '2 hives · 1 urgent',
      status: HivesLocationStatus.urgent,
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Empty', type: HivesLocationCard)
Widget locationCardEmpty(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.screenMargin),
    child: HivesLocationCard(
      locationName: 'New Spot',
      statusSummary: 'No hives yet',
      status: HivesLocationStatus.empty,
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Loading', type: HivesLocationCard)
Widget locationCardLoading(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.screenMargin),
    child: HivesLocationCard(
      locationName: 'Loading...',
      statusSummary: '',
      status: HivesLocationStatus.healthy,
      isLoading: true,
    ),
  );
}

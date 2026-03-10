import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'With Photo', type: HiveCard)
Widget hiveCardWithPhoto(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.screenMargin),
    child: HiveCard(
      hiveName: 'Hive Alpha',
      status: HivesHiveStatus.healthy,
      statusSummary: '3 days ago · Brood pattern good',
      image: const AssetImage('assets/hive.jpg'),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Placeholder', type: HiveCard)
Widget hiveCardPlaceholder(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.screenMargin),
    child: HiveCard(
      hiveName: 'Hive Beta',
      status: HivesHiveStatus.attention,
      statusSummary: '1 week ago · Low honey stores',
      onTap: () {},
    ),
  );
}

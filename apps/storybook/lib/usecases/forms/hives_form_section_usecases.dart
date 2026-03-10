import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Collapsed', type: HivesFormSection)
Widget hivesFormSectionCollapsed(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesFormSection(
        title: 'Additional Details',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Section content goes here'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Expanded', type: HivesFormSection)
Widget hivesFormSectionExpanded(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesFormSection(
        title: 'Hive Information',
        isInitiallyExpanded: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Queen status: Active'),
              SizedBox(height: 8),
              Text('Frames: 10'),
              SizedBox(height: 8),
              Text('Last inspection: 15 March 2025'),
            ],
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Required (Non-Collapsible)', type: HivesFormSection)
Widget hivesFormSectionRequired(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesFormSection.required(
        title: 'Basic Information',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('This section is always visible and cannot be collapsed'),
        ),
      ),
    ),
  );
}

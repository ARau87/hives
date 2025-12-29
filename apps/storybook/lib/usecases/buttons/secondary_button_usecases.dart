import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SecondaryButton)
Widget secondaryButtonDefault(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: SecondaryButton(
        label: context.knobs.string(label: 'Label', initialValue: 'Cancel'),
        onPressed: () {},
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Loading', type: SecondaryButton)
Widget secondaryButtonLoading(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: SecondaryButton(
        label: context.knobs.string(label: 'Label', initialValue: 'Loading...'),
        onPressed: () {},
        isLoading: context.knobs.boolean(
          label: 'Is Loading',
          initialValue: true,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: SecondaryButton)
Widget secondaryButtonDisabled(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: SecondaryButton(
        label: context.knobs.string(label: 'Label', initialValue: 'Disabled'),
        onPressed: () {},
        isEnabled: context.knobs.boolean(
          label: 'Is Enabled',
          initialValue: false,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Icon Leading', type: SecondaryButton)
Widget secondaryButtonWithIconLeading(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: SecondaryButton(
        label: context.knobs.string(label: 'Label', initialValue: 'Go Back'),
        onPressed: () {},
        icon: const Icon(Icons.arrow_back, size: 20),
        iconLeading: true,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Icon Trailing', type: SecondaryButton)
Widget secondaryButtonWithIconTrailing(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: SecondaryButton(
        label: context.knobs.string(label: 'Label', initialValue: 'Explore'),
        onPressed: () {},
        icon: const Icon(Icons.arrow_forward, size: 20),
        iconLeading: false,
      ),
    ),
  );
}

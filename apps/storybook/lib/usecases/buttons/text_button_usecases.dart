import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: PlainTextButton)
Widget plainTextButtonDefault(BuildContext context) {
  return Center(
    child: PlainTextButton(
      label: context.knobs.string(label: 'Label', initialValue: 'Cancel'),
      onPressed: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Loading', type: PlainTextButton)
Widget plainTextButtonLoading(BuildContext context) {
  return Center(
    child: PlainTextButton(
      label: context.knobs.string(label: 'Label', initialValue: 'Loading...'),
      onPressed: () {},
      isLoading: context.knobs.boolean(label: 'Is Loading', initialValue: true),
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: PlainTextButton)
Widget plainTextButtonDisabled(BuildContext context) {
  return Center(
    child: PlainTextButton(
      label: context.knobs.string(label: 'Label', initialValue: 'Disabled'),
      onPressed: () {},
      isEnabled: context.knobs.boolean(
        label: 'Is Enabled',
        initialValue: false,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Icon Leading', type: PlainTextButton)
Widget plainTextButtonWithIconLeading(BuildContext context) {
  return Center(
    child: PlainTextButton(
      label: context.knobs.string(label: 'Label', initialValue: 'Back'),
      onPressed: () {},
      icon: const Icon(Icons.arrow_back, size: 20),
      iconLeading: true,
    ),
  );
}

@widgetbook.UseCase(name: 'With Icon Trailing', type: PlainTextButton)
Widget plainTextButtonWithIconTrailing(BuildContext context) {
  return Center(
    child: PlainTextButton(
      label: context.knobs.string(label: 'Label', initialValue: 'Forward'),
      onPressed: () {},
      icon: const Icon(Icons.arrow_forward, size: 20),
      iconLeading: false,
    ),
  );
}

@widgetbook.UseCase(name: 'With Custom Width', type: PlainTextButton)
Widget plainTextButtonWithCustomWidth(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 200,
      child: PlainTextButton(
        label: context.knobs.string(label: 'Label', initialValue: 'Learn More'),
        onPressed: () {},
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Long Text', type: PlainTextButton)
Widget plainTextButtonLongText(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: PlainTextButton(
        label: context.knobs.string(
          label: 'Label',
          initialValue: 'This is a very long text that wraps to multiple lines',
        ),
        onPressed: () {},
      ),
    ),
  );
}

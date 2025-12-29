import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: PrimaryButton)
Widget primaryButtonDefault(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: PrimaryButton(
        label: context.knobs.string(
          label: 'Label',
          initialValue: 'Get Started',
        ),
        onPressed: () {},
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Loading', type: PrimaryButton)
Widget primaryButtonLoading(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: PrimaryButton(
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

@widgetbook.UseCase(name: 'Disabled', type: PrimaryButton)
Widget primaryButtonDisabled(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: PrimaryButton(
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

@widgetbook.UseCase(name: 'With Icon Leading', type: PrimaryButton)
Widget primaryButtonWithIconLeading(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: PrimaryButton(
        label: context.knobs.string(label: 'Label', initialValue: 'Continue'),
        onPressed: () {},
        icon: const Icon(Icons.arrow_forward, size: 20),
        iconLeading: true,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Icon Trailing', type: PrimaryButton)
Widget primaryButtonWithIconTrailing(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: PrimaryButton(
        label: context.knobs.string(label: 'Label', initialValue: 'Next'),
        onPressed: () {},
        icon: const Icon(Icons.arrow_forward, size: 20),
        iconLeading: false,
      ),
    ),
  );
}

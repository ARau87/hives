import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: HighlightButton)
Widget highlightButtonDefault(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: HighlightButton(
        label: context.knobs.string(
          label: 'Label',
          initialValue: 'Get Started',
        ),
        onPressed: () {},
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Loading', type: HighlightButton)
Widget highlightButtonLoading(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: HighlightButton(
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

@widgetbook.UseCase(name: 'Disabled', type: HighlightButton)
Widget highlightButtonDisabled(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: HighlightButton(
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

@widgetbook.UseCase(name: 'With Icon Leading', type: HighlightButton)
Widget highlightButtonWithIconLeading(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: HighlightButton(
        label: context.knobs.string(label: 'Label', initialValue: 'Continue'),
        onPressed: () {},
        icon: const Icon(Icons.arrow_forward, size: 20),
        iconLeading: true,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Icon Trailing', type: HighlightButton)
Widget highlightButtonWithIconTrailing(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 280,
      child: HighlightButton(
        label: context.knobs.string(
          label: 'Label',
          initialValue: 'Get Started',
        ),
        onPressed: () {},
        icon: const Icon(Icons.arrow_forward, size: 20),
        iconLeading: false,
      ),
    ),
  );
}

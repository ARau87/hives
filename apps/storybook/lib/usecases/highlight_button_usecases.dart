import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';

/// Use cases for the HighlightButton component.
final List<WidgetbookUseCase> highlightButtonUseCases = [
  WidgetbookUseCase(
    name: 'Default',
    builder: (context) => Center(
      child: SizedBox(
        width: 280,
        child: HighlightButton(label: 'Get Started', onPressed: () {}),
      ),
    ),
  ),
  WidgetbookUseCase(
    name: 'Loading',
    builder: (context) => Center(
      child: SizedBox(
        width: 280,
        child: HighlightButton(
          label: 'Loading...',
          onPressed: () {},
          isLoading: true,
        ),
      ),
    ),
  ),
  WidgetbookUseCase(
    name: 'Disabled',
    builder: (context) => Center(
      child: SizedBox(
        width: 280,
        child: HighlightButton(
          label: 'Disabled',
          onPressed: () {},
          isEnabled: false,
        ),
      ),
    ),
  ),
  WidgetbookUseCase(
    name: 'With Icon (Leading)',
    builder: (context) => Center(
      child: SizedBox(
        width: 280,
        child: HighlightButton(
          label: 'Continue',
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          iconLeading: true,
        ),
      ),
    ),
  ),
  WidgetbookUseCase(
    name: 'With Icon (Trailing)',
    builder: (context) => Center(
      child: SizedBox(
        width: 280,
        child: HighlightButton(
          label: 'Get Started',
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          iconLeading: false,
        ),
      ),
    ),
  ),
];

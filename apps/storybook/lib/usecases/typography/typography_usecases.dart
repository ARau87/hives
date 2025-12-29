import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'All Typography',
  type: TypographyGallery,
  path: 'components/typography',
)
Widget typographyGallery(BuildContext context) {
  return const TypographyGallery();
}

class TypographyGallery extends StatelessWidget {
  const TypographyGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          _Section(
            children: [
              HivesDisplayLarge('Display Large'),
              HivesDisplayMedium('Display Medium'),
              HivesDisplaySmall('Display Small'),
            ],
          ),
          _Section(
            children: [
              HivesHeadlineLarge('Headline Large'),
              HivesHeadlineMedium('Headline Medium'),
              HivesHeadlineSmall('Headline Small'),
              HivesTitleLarge('Title Large'),
              HivesTitleMedium('Title Medium'),
              HivesTitleSmall('Title Small'),
            ],
          ),
          _Section(
            children: [
              HivesBodyLarge('Body Large'),
              HivesBodyMedium('Body Medium'),
              HivesBodySmall('Body Small'),
              HivesLabelLarge('Label Large'),
              HivesLabelMedium('Label Medium'),
              HivesLabelSmall('Label Small'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final List<Widget> children;

  const _Section({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final child in children) ...[child, const SizedBox(height: 12)],
        ],
      ),
    );
  }
}

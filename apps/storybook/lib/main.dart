import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const HivesWidgetbook());
}

@widgetbook.App()
class HivesWidgetbook extends StatelessWidget {
  const HivesWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // Use generated directories from annotations
      directories: directories,

      // Available addons for testing components
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: AppTheme.lightTheme),
            WidgetbookTheme(name: 'Dark', data: AppTheme.darkTheme),
          ],
        ),
        // Device Frame Addon for mobile device previews
        ViewportAddon([
          IosViewports.iPhone13,
          AndroidViewports.samsungGalaxyNote20,
          Viewports.none,
        ]),
        ZoomAddon(),
        TextScaleAddon(min: 1.0, max: 2.0, initialScale: 1.0),
        LocalizationAddon(
          locales: [const Locale('en', 'US'), const Locale('de', 'DE')],
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
        ),
      ],
    );
  }
}

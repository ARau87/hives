import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HivesWidgetbook());
}

class HivesWidgetbook extends StatelessWidget {
  const HivesWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // Available addons for testing components
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData.light(useMaterial3: true),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData.dark(useMaterial3: true),
            ),
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

      // Component catalog
      directories: [
        WidgetbookCategory(
          name: 'Widgets',
          children: [
            WidgetbookFolder(
              name: 'Buttons',
              children: [
                WidgetbookComponent(
                  name: 'Button Examples',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Default Button',
                      builder: (context) => Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Click Me'),
                        ),
                      ),
                    ),
                    WidgetbookUseCase(
                      name: 'Outlined Button',
                      builder: (context) => Center(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('Click Me'),
                        ),
                      ),
                    ),
                    WidgetbookUseCase(
                      name: 'Text Button',
                      builder: (context) => Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Click Me'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            WidgetbookFolder(
              name: 'Text',
              children: [
                WidgetbookComponent(
                  name: 'Typography',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Headlines',
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Display Large',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Display Medium',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Display Small',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Headline Large',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Headline Medium',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    WidgetbookUseCase(
                      name: 'Body Text',
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Body Large',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Body Medium',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Body Small',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Add more categories here as you build more components
        WidgetbookCategory(
          name: 'Examples',
          children: [
            WidgetbookComponent(
              name: 'Sample Screen',
              useCases: [
                WidgetbookUseCase(
                  name: 'Home Screen',
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: const Text('Hives')),
                    body: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.hive, size: 64),
                          SizedBox(height: 16),
                          Text('Welcome to Hives'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

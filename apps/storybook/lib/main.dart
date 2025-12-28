import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
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

      // Component catalog
      directories: [
        WidgetbookCategory(
          name: 'Widgets',
          children: [
            WidgetbookFolder(
              name: 'Buttons',
              children: [
                WidgetbookFolder(
                  name: 'Highlight Button',
                  children: [
                    WidgetbookComponent(
                      name: 'Highlight Button States',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'Default',
                          builder: (context) => Center(
                            child: SizedBox(
                              width: 280,
                              child: HighlightButton(
                                label: 'Get Started',
                                onPressed: () {},
                              ),
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
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
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
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                iconLeading: false,
                              ),
                            ),
                          ),
                        ),
                        WidgetbookUseCase(
                          name: 'With Icon (Loading)',
                          builder: (context) => Center(
                            child: SizedBox(
                              width: 280,
                              child: HighlightButton(
                                label: 'Processing...',
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                isLoading: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

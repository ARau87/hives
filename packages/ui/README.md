# Hives UI Package

Ein gemeinsam genutztes UI-Paket für die Hives-Anwendung, das ein konsistentes Material Design Theme bereitstellt.

## Features

- 🎨 **Material 3 Design** - Modernes, ansprechendes Design-System
- 🌓 **Hell- und Dunkelmodus** - Vollständige Unterstützung für beide Themes
- 🎯 **Hives-Branding** - Farben inspiriert von Honig (Amber), Holz (Brown) und Natur (Green)
- 📱 **Responsive Komponenten** - Konsistente Button-, Card-, Input- und Dialog-Stile

## Verwendung

### Theme importieren

```dart
import 'package:ui/ui.dart';
```

### In einer Flutter-App verwenden

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  home: YourHomeScreen(),
)
```

### In Widgetbook verwenden

```dart
Widgetbook.material(
  addons: [
    MaterialThemeAddon(
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: AppTheme.lightTheme,
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: AppTheme.darkTheme,
        ),
      ],
    ),
  ],
  // ...
)
```

## Farbschema

### Primärfarben
- **Primary**: Amber (#FFC107) - repräsentiert Honig
- **Secondary**: Brown (#795548) - repräsentiert Bienenstock-Holz
- **Tertiary**: Light Green (#8BC34A) - repräsentiert Natur

### Design-Prinzipien
- Abgerundete Ecken (12px für Cards/Buttons, 28px für Dialogs)
- Material 3 Elevation und Schatten
- Konsistente Abstände und Polsterungen
- Barrierefreie Kontrastverhältnisse

## Struktur

```
lib/
  ├── ui.dart              # Haupt-Export-Datei
  └── src/
      └── theme/
          └── app_theme.dart  # Theme-Konfiguration
```

## Entwicklung

Um das Theme zu modifizieren, bearbeiten Sie `lib/src/theme/app_theme.dart` und passen Sie die:
- Farbschemata (`_lightColorScheme`, `_darkColorScheme`)
- Typografie (`_textTheme`)
- Komponenten-Themes (in den `lightTheme`/`darkTheme` Getters)

an.


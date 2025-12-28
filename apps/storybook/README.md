# Hives Storybook

Storybook für das Hives-Projekt, gebaut mit [Widgetbook](https://www.widgetbook.io/).

## Übersicht

Dieses Storybook verwendet Widgetbook-Annotationen zur automatischen Generierung der Komponentenkatalog-Struktur. Anstatt manuell Verzeichnisse und Use-Cases zu erstellen, werden diese aus annotierten Funktionen generiert.

## Verwendung

### Neue Use-Cases hinzufügen

1. Erstelle eine neue Datei in `lib/usecases/` (z.B. `my_component_usecases.dart`)
2. Importiere die notwendigen Pakete:
   ```dart
   import 'package:flutter/material.dart';
   import 'package:ui/ui.dart';
   import 'package:widgetbook/widgetbook.dart';
   import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
   ```
3. Erstelle Use-Case-Funktionen mit der `@widgetbook.UseCase` Annotation:
   ```dart
   @widgetbook.UseCase(
     name: 'Default',
     type: MyComponent,
   )
   Widget myComponentDefault(BuildContext context) {
     return MyComponent(
       title: context.knobs.string(
         label: 'Title',
         initialValue: 'Hello World',
       ),
     );
   }
   ```

### Knobs verwenden

Knobs ermöglichen interaktive Konfiguration der Komponenten:

- **String**: `context.knobs.string(label: 'Label', initialValue: 'Value')`
- **Boolean**: `context.knobs.boolean(label: 'Label', initialValue: true)`
- **Number**: `context.knobs.double.slider(label: 'Label', initialValue: 0.5, min: 0, max: 1)`
- **List**: `context.knobs.list(label: 'Label', options: ['A', 'B', 'C'])`

### Code generieren

Nach dem Hinzufügen oder Ändern von Use-Cases:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Oder für kontinuierliche Code-Generierung während der Entwicklung:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Storybook ausführen

```bash
flutter run -d chrome
```

Oder für andere Plattformen (iOS, Android, etc.).

## Struktur

- `lib/main.dart` - Haupt-Widgetbook-App mit @App Annotation
- `lib/usecases/` - Use-Case-Definitionen für Komponenten
- `lib/main.directories.g.dart` - Generierte Verzeichnisstruktur (nicht bearbeiten!)

## Addons

Das Storybook beinhaltet folgende Addons:

- **MaterialThemeAddon** - Wechseln zwischen Light/Dark Themes
- **ViewportAddon** - Testen auf verschiedenen Geräte-Größen
- **ZoomAddon** - Zoom-Level anpassen
- **TextScaleAddon** - Text-Skalierung für Barrierefreiheitstests
- **LocalizationAddon** - Wechseln zwischen Sprachen (EN/DE)

## Best Practices

1. **Halte Use-Cases fokussiert**: Jeder Use-Case sollte einen spezifischen Zustand oder eine Variante der Komponente zeigen
2. **Verwende Knobs sinnvoll**: Füge Knobs für wichtige Props hinzu, aber übertreibe es nicht
3. **Benenne Use-Cases klar**: Namen sollten den Zustand/Variante klar beschreiben (z.B. 'Loading', 'Disabled', 'With Icon')
4. **Zentriere Komponenten**: Verwende `Center` für eine bessere Darstellung
5. **Setze feste Breiten bei Bedarf**: Für Buttons und ähnliche Komponenten hilft ein `SizedBox` mit fester Breite

## Weitere Informationen

- [Widgetbook Dokumentation](https://docs.widgetbook.io/)
- [Widgetbook Annotations](https://docs.widgetbook.io/basics/code-generation)

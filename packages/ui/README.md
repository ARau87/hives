# UI Package with Widgetbook

Dies ist das UI-Paket für das Hives-Projekt mit integriertem Widgetbook 3.20.2.

## Setup

Das Paket verwendet Widgetbook zur Katalogisierung und Dokumentation von Flutter-Widgets.

### Widgetbook-Anwendung

Die Widgetbook-Anwendung befindet sich in `widgetbook/main.dart`. Diese wird als separate Flutter-App gebaut und ermöglicht die interaktive Dokumentation und Vorschau aller UI-Komponenten.

### Dependencies

- `widgetbook: ^3.20.2` - Das Widgetbook-Framework
- `widgetbook_annotation: ^3.20.2` - Annotationen für Widgetbook

## Verwendung

Um die Widgetbook-Anwendung zu starten:

```bash
cd packages/ui
flutter run -t widgetbook/main.dart
```

## Widgets hinzufügen

1. Erstellen Sie Ihre Widget-Komponenten in der `lib/`-Struktur
2. Erstellen Sie entsprechende Widgetbook-Aufzeichnungen in der `widgetbook/`-Struktur
3. Verwenden Sie die `@WidgetbookTest` Annotation um automatisch Widgetbook-Einträge zu generieren


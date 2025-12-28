# HivesColors Theme Extension

Eine benutzerdefinierte Theme Extension für das Hives Design System, die alle Markenfarben und zusätzliche Farben bereitstellt.

## Verfügbare Farben

### Honey (Amber) - Primärfarbe
```dart
context.theme.hivesColors.honey        // #FFC107 (Light), #FFD54F (Dark)
context.theme.hivesColors.honeyLight   // #FFECB3 (Light), #FFF59D (Dark)
context.theme.hivesColors.honeyDark    // #FFB300 (Light), #FFA000 (Dark)
```

### Hive Wood (Brown) - Sekundärfarbe
```dart
context.theme.hivesColors.hiveWood       // #795548 (Light), #BCAAA4 (Dark)
context.theme.hivesColors.hiveWoodLight  // #A1887F (Light), #D7CCC8 (Dark)
context.theme.hivesColors.hiveWoodDark   // #4E342E (Light), #795548 (Dark)
```

### Nature (Green) - Tertiärfarbe
```dart
context.theme.hivesColors.nature             // #8BC34A (Light), #AED581 (Dark)
context.theme.hivesColors.natureLightShade   // #C5E1A5 (Light), #DCEDCB (Dark)
context.theme.hivesColors.natureDarkShade    // #558B2F (Light), #8BC34A (Dark)
```

### Orange - Zusätzliche Akzentfarbe
```dart
context.theme.hivesColors.orange       // #FF9800 (Light), #FFBC4D (Dark)
context.theme.hivesColors.orangeLight  // #FFCC80 (Light), #FFE0B2 (Dark)
context.theme.hivesColors.orangeDark   // #F57C00 (Light), #FF9800 (Dark)
```

### Surface & Outline Farben
```dart
context.theme.hivesColors.surface
context.theme.hivesColors.surfaceVariant
context.theme.hivesColors.outline
context.theme.hivesColors.outlineVariant
```

## Verwendung in Widgets

### Einfache Verwendung
```dart
Container(
  color: Theme.of(context).hivesColors.honey,
  child: Text('Honey colored container'),
)
```

### Mit Extension Method
```dart
Widget build(BuildContext context) {
  final colors = Theme.of(context).hivesColors;
  
  return Column(
    children: [
      Container(color: colors.honey),
      Container(color: colors.hiveWood),
      Container(color: colors.orange),
    ],
  );
}
```

## Automatisches Theme-Switching

Die HivesColors werden automatisch zwischen Light und Dark Mode gewechselt:

```dart
// Light Theme
ThemeData(
  extensions: [HivesColors.light],
)

// Dark Theme
ThemeData(
  extensions: [HivesColors.dark],
)
```

## Erweiterung

Um neue Farben hinzuzufügen:

1. Füge das neue Feld zur `HivesColors` Klasse hinzu
2. Aktualisiere die `copyWith` Methode
3. Aktualisiere die `lerp` Methode
4. Definiere die Werte für `light` und `dark` Konstanten
5. Füge die Extension Method in `HivesColorsExtension` hinzu


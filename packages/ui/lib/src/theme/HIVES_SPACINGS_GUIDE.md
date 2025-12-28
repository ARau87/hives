# HivesSpacings Extension

Eine umfassende Theme Extension für konsistente Abstände (Margins und Paddings) im gesamten Hives Design System.

## Verfügbare Abstände

### Base Spacing Values
```dart
final double xs   = 4.0      // Minimal spacing
final double sm   = 8.0      // Small spacing
final double md   = 12.0     // Medium spacing
final double lg   = 16.0     // Large spacing
final double xl   = 20.0     // Extra large spacing
final double xxl  = 24.0     // Extra extra large spacing
final double xxxl = 32.0     // Massive spacing
```

## Padding Kombinationen

### Alle Seiten (symmetrisch)
```dart
spacings.paddingXs      // EdgeInsets.all(4.0)
spacings.paddingSm      // EdgeInsets.all(8.0)
spacings.paddingMd      // EdgeInsets.all(12.0)
spacings.paddingLg      // EdgeInsets.all(16.0)
spacings.paddingXl      // EdgeInsets.all(20.0)
spacings.paddingXxl     // EdgeInsets.all(24.0)
spacings.paddingXxxl    // EdgeInsets.all(32.0)
```

### Horizontales Padding
```dart
spacings.paddingHorizontalSm    // EdgeInsets.symmetric(horizontal: 8.0)
spacings.paddingHorizontalMd    // EdgeInsets.symmetric(horizontal: 12.0)
spacings.paddingHorizontalLg    // EdgeInsets.symmetric(horizontal: 16.0)
```

### Vertikales Padding
```dart
spacings.paddingVerticalSm      // EdgeInsets.symmetric(vertical: 8.0)
spacings.paddingVerticalMd      // EdgeInsets.symmetric(vertical: 12.0)
spacings.paddingVerticalLg      // EdgeInsets.symmetric(vertical: 16.0)
```

## Margin Kombinationen

### Alle Seiten (symmetrisch)
```dart
spacings.marginXs       // EdgeInsets.all(4.0)
spacings.marginSm       // EdgeInsets.all(8.0)
spacings.marginMd       // EdgeInsets.all(12.0)
spacings.marginLg       // EdgeInsets.all(16.0)
spacings.marginXl       // EdgeInsets.all(20.0)
spacings.marginXxl      // EdgeInsets.all(24.0)
spacings.marginXxxl     // EdgeInsets.all(32.0)
```

### Horizontale Margins
```dart
spacings.marginHorizontalSm     // EdgeInsets.symmetric(horizontal: 8.0)
spacings.marginHorizontalMd     // EdgeInsets.symmetric(horizontal: 12.0)
spacings.marginHorizontalLg     // EdgeInsets.symmetric(horizontal: 16.0)
```

### Vertikale Margins
```dart
spacings.marginVerticalSm       // EdgeInsets.symmetric(vertical: 8.0)
spacings.marginVerticalMd       // EdgeInsets.symmetric(vertical: 12.0)
spacings.marginVerticalLg       // EdgeInsets.symmetric(vertical: 16.0)
```

## Vordefinierte Container Abstände

```dart
spacings.containerPadding   // EdgeInsets.all(16.0) - für interne Container
spacings.screenPadding      // EdgeInsets.all(16.0) - für Screen-Padding
```

## Verwendungsbeispiele

### Mit raw Spacing Values
```dart
SizedBox(height: Theme.of(context).spacings.lg)  // 16.0
```

### Mit Padding
```dart
Padding(
  padding: Theme.of(context).spacings.paddingMd,
  child: Text('Centered content'),
)
```

### Mit Container Margin
```dart
Container(
  margin: Theme.of(context).spacings.marginLg,
  padding: Theme.of(context).spacings.paddingLg,
  child: Text('Card content'),
)
```

### Mit horizontaler Padding
```dart
Padding(
  padding: Theme.of(context).spacings.paddingHorizontalLg,
  child: TextField(),
)
```

### Mit vertikaler Margin
```dart
Column(
  children: [
    Text('Item 1'),
    SizedBox(height: Theme.of(context).spacings.lg),
    Text('Item 2'),
  ],
)
```

## Automatische Theme Integration

Die HivesSpacings werden automatisch in beide Themes (light/dark) eingebunden:

```dart
// Light Theme
ThemeData(
  extensions: [HivesColors.light, HivesSpacings.standard],
)

// Dark Theme
ThemeData(
  extensions: [HivesColors.dark, HivesSpacings.standard],
)
```

Da Abstände unabhängig vom Modus sind, verwendet beide Themes `HivesSpacings.standard`.

## Erweiterung

Um neue Spacing-Werte hinzuzufügen:

1. Füge das neue Feld zur `HivesSpacings` Klasse hinzu
2. Aktualisiere den Konstruktor
3. Aktualisiere die `copyWith` Methode
4. Aktualisiere die `lerp` Methode (falls notwendig)
5. Füge den Wert zur `standard` Konstante hinzu


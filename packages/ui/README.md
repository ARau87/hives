# Hives UI Component Library

Eine umfassende, Material Design 3-konforme Flutter UI-Komponentenbibliothek für das Hives-Projekt, organisiert nach Kategorien mit vollständiger Widgetbook-Integration.

## 📚 Überblick

Die **UI-Bibliothek** bietet:

- ✅ **Kategorisierte Komponenten**: Buttons, Inputs, Surfaces, Feedback
- ✅ **Theme-System**: Zentrale Design-Token und ThemeExtensions
- ✅ **Widgetbook Integration**: Interaktive Storybook für alle Komponenten
- ✅ **Effective Dart**: Vollständig nach [Effective Dart](https://dart.dev/effective-dart) dokumentiert
- ✅ **Barrierefreiheit**: Material Design 3 Standards und semantische Widgets
- ✅ **Dark/Light Mode**: Vollständige Theme-Unterstützung

## 🎨 Komponenten

### Buttons (`src/components/buttons/`)

#### PrimaryButton
Hauptaktion-Button mit hervorgehobener Farbe.

```dart
PrimaryButton(
  label: 'Get Started',
  onPressed: () {},
  isLoading: false,
  isEnabled: true,
  icon: Icons.arrow_forward,
  iconLeading: false,
)
```

**Use-Cases im Widgetbook**: Default, Loading, Disabled, Mit Icon (Leading/Trailing), Custom Size

#### SecondaryButton
Sekundäraktion-Button mit Outline-Stil.

```dart
SecondaryButton(
  label: 'Cancel',
  onPressed: () {},
  icon: Icons.arrow_back,
)
```

**Use-Cases im Widgetbook**: Default, Loading, Disabled, Mit Icon (Leading/Trailing)

---

### Input-Komponenten (`src/components/inputs/`)

#### HivesTextField
Angepasstes TextField mit Theme-Tokens und Validierung.

```dart
HivesTextField(
  label: 'Email',
  hint: 'Enter your email',
  keyboardType: TextInputType.emailAddress,
  errorText: errorMessage,
  isPassword: false,
  onChanged: (value) => email = value,
)
```

**Features**:
- Label und Hint-Text
- Fehlervalidierung
- Password-Toggle
- Prefix/Suffix-Icons
- Multiline-Support

**Use-Cases im Widgetbook**: Default, Mit Fehler, Password-Feld, Mit Icons, Disabled, Multiline

---

### Surface-Komponenten (`src/components/surfaces/`)

#### HivesCard
Material Design Card mit Theme-Integration.

```dart
HivesCard(
  elevation: 2.0,
  isClickable: true,
  onTap: () {},
  child: Column(
    children: [
      Text('Card Title'),
      Text('Card Content'),
    ],
  ),
)
```

**Use-Cases im Widgetbook**: Default, Mit Content, Clickable, Custom Elevation

---

### Feedback-Komponenten (`src/components/feedback/`)

#### HivesChip
Kompakte, interaktive Chip für Tags und Filter.

```dart
HivesChip(
  label: 'Flutter',
  isSelected: true,
  icon: Icons.check,
  onPressed: () {},
)
```

**Use-Cases im Widgetbook**: Default, Selected, Mit Icons, Disabled, Filter Tags

---

## 🎨 Theme-System

### Theme Extensions

#### ButtonThemeTokens
Button-spezifische Design-Werte.

```dart
final buttonTokens = Theme.of(context).extension<ButtonThemeTokens>();
print(buttonTokens?.minHeight); // 48.0
```

#### InputThemeTokens
Input-Field-spezifische Design-Werte.

```dart
final inputTokens = Theme.of(context).extension<InputThemeTokens>();
print(inputTokens?.borderRadius); // 8.0
```

#### SurfaceThemeTokens
Card- und Surface-spezifische Design-Werte.

```dart
final surfaceTokens = Theme.of(context).extension<SurfaceThemeTokens>();
print(surfaceTokens?.cardElevation); // 2.0
```

### App Theme

```dart
// Light Theme
final lightTheme = AppTheme.lightTheme;

// Dark Theme
final darkTheme = AppTheme.darkTheme;

// Farben (Color Scheme)
// Primary: Amber (Honig)
// Secondary: Brown (Holz)
// Tertiary: Green (Natur)
```

### Spacing System

```dart
final spacings = Theme.of(context).extension<HivesSpacings>();
print(spacings?.xs);   // 4px
print(spacings?.sm);   // 8px
print(spacings?.md);   // 12px
print(spacings?.lg);   // 16px
print(spacings?.xl);   // 20px
print(spacings?.xxl);  // 24px
print(spacings?.xxxl); // 32px
```

---

## 📖 Widgetbook Integration

### Storybook starten

```bash
cd apps/storybook
flutter run
```

### Struktur

Alle Komponenten sind im **Widgetbook** interaktiv testbar:

```
Components
├── HighlightButton (Legacy)
├── buttons
│   ├── PrimaryButton
│   └── SecondaryButton
├── feedback
│   └── HivesChip
├── inputs
│   └── HivesTextField
└── surfaces
    └── HivesCard
```

### Interaktive Features

- **Theme-Toggle**: Light/Dark Mode
- **Device Preview**: iPhone 13, Samsung Galaxy Note 20
- **Text Scaling**: 1.0x bis 2.0x
- **Localization**: Englisch, Deutsch
- **Knobs**: Interaktive Parameter anpassen

---

## 📦 Export-Struktur

### Hauptexport (`lib/ui.dart`)

```dart
// Themes
export 'src/theme/app_theme.dart';
export 'src/theme/button_theme.dart';
export 'src/theme/hives_colors.dart';
export 'src/theme/hives_component_theme.dart';
export 'src/theme/hives_spacings.dart';
export 'src/theme/input_theme.dart';
export 'src/theme/surface_theme.dart';

// Components
export 'src/components/buttons/buttons.dart';
export 'src/components/feedback/feedback.dart';
export 'src/components/inputs/inputs.dart';
export 'src/components/surfaces/surfaces.dart';
```

### Verwendung in Anwendungen

```dart
import 'package:ui/ui.dart';

// Komponenten verwenden
PrimaryButton(label: 'Click', onPressed: () {})
SecondaryButton(label: 'Cancel', onPressed: () {})
HivesCard(child: Text('Content'))
HivesTextField(label: 'Input')
HivesChip(label: 'Tag')

// Themes
ThemeData theme = AppTheme.lightTheme;

// Design Tokens
ButtonThemeTokens tokens = Theme.of(context).extension<ButtonThemeTokens>()!;
```

---

## 🏗️ Architektur

### Ordnerstruktur

```
packages/ui/
├── lib/
│   ├── ui.dart (Main Export)
│   └── src/
│       ├── components/
│       │   ├── buttons/
│       │   │   ├── primary_button.dart
│       │   │   ├── secondary_button.dart
│       │   │   └── buttons.dart
│       │   ├── inputs/
│       │   │   ├── hives_text_field.dart
│       │   │   └── inputs.dart
│       │   ├── surfaces/
│       │   │   ├── hives_card.dart
│       │   │   └── surfaces.dart
│       │   ├── feedback/
│       │   │   ├── hives_chip.dart
│       │   │   └── feedback.dart
│       │   ├── components.dart
│       │   └── highlight_button.dart (Legacy)
│       └── theme/
│           ├── app_theme.dart
│           ├── button_theme.dart
│           ├── input_theme.dart
│           ├── surface_theme.dart
│           ├── hives_colors.dart
│           ├── hives_component_theme.dart
│           └── hives_spacings.dart
```

---

## ✅ Best Practices

### Komponenten verwenden

1. **Immer `const` verwenden** wenn möglich
   ```dart
   const PrimaryButton(label: 'Click', onPressed: onPressed)
   ```

2. **Theme-Tokens nutzen** statt Hardcoding
   ```dart
   // ✅ Gut
   Color color = Theme.of(context).colorScheme.primary;
   
   // ❌ Schlecht
   Color color = Color(0xFFFFC107);
   ```

3. **Spacing-System verwenden**
   ```dart
   // ✅ Gut
   SizedBox(height: spacings.md)
   
   // ❌ Schlecht
   SizedBox(height: 12)
   ```

4. **Accessible Semantics**
   ```dart
   Semantics(
     button: true,
     label: 'Submit form',
     child: PrimaryButton(label: 'Submit', onPressed: onSubmit),
   )
   ```

### Neue Komponente hinzufügen

1. Komponente in `src/components/{kategorie}/` erstellen
2. Export in `{kategorie}.dart` hinzufügen
3. Use-Cases in `apps/storybook/lib/usecases/{kategorie}/` erstellen
4. `build_runner` laufen lassen: `melos run build`
5. In `lib/ui.dart` exportieren

---

## 🧪 Testing

### Komponenten-Tests schreiben

```dart
void main() {
  testWidgets('PrimaryButton shows loading indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: PrimaryButton(
            label: 'Click',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

---

## 📋 Checkliste für neue Komponenten

- [ ] Komponente implementiert mit vollständiger Dokumentation (`///`)
- [ ] All Props dokumentiert mit Effective Dart Guidelines
- [ ] Theme-Tokens integriert (keine Hardcoded Values)
- [ ] Use-Cases für Widgetbook erstellt (min. 3 Varianten)
- [ ] Accessibility berücksichtigt (Semantics, Labels)
- [ ] `const` Konstruktor wo möglich
- [ ] Tests geschrieben
- [ ] Export in `{kategorie}.dart` hinzugefügt
- [ ] Export in `lib/ui.dart` hinzugefügt
- [ ] `melos run build` ausgeführt
- [ ] Im Widgetbook überprüft

---

## 🔗 Ressourcen

- [Material Design 3](https://m3.material.io/)
- [Effective Dart](https://dart.dev/effective-dart)
- [Widgetbook Docs](https://www.widgetbook.io/)
- [Flutter Theme Documentation](https://flutter.dev/docs/cookbook/design/themes)

---

## 📝 Lizenz

Teil des Hives-Projekts. Siehe Hauptprojekt-Lizenz.


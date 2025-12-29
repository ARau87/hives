# Widgetbook Storybook Guide

Interaktive Vorschau und Test aller Hives UI-Komponenten.

## 🚀 Storybook starten

```bash
# Von Projekt-Root
cd apps/storybook
flutter run

# Oder mit Melos
melos run storybook:run
```

Öffnet die Storybook-App auf Desktop oder emuliertem Gerät.

---

## 📖 Navigation

Die Komponenten sind hierarchisch organisiert:

```
Components
├── HighlightButton (Komponente)
│   ├── Default (Use-Case)
│   ├── Loading
│   ├── Disabled
│   ├── With Icon Leading
│   └── With Icon Trailing
├── buttons (Kategorie-Ordner)
│   ├── PrimaryButton
│   │   ├── Default
│   │   ├── Loading
│   │   ├── Disabled
│   │   ├── With Icon Leading
│   │   ├── With Icon Trailing
│   │   └── Custom Size
│   └── SecondaryButton
│       ├── Default
│       ├── Loading
│       ├── Disabled
│       ├── With Icon Leading
│       └── With Icon Trailing
├── feedback
│   └── HivesChip
│       ├── Default
│       ├── Selected
│       ├── With Icons
│       ├── Disabled
│       └── Filter Tags
├── inputs
│   └── HivesTextField
│       ├── Default
│       ├── With Error
│       ├── Password Field
│       ├── With Icons
│       ├── Disabled
│       └── Multiline
└── surfaces
    └── HivesCard
        ├── Default
        ├── With Content
        ├── Clickable
        └── Custom Elevation
```

---

## 🎨 Top Bar Addons

### Material Theme Addon

**Light/Dark Mode wechseln**

- Oben rechts "Light" / "Dark" auswählen
- Alle Komponenten reagieren auf Theme-Änderungen
- Perfekt zum Testen von Farbkontrast und Accessibility

### Viewport Addon

**Device-Größen testen**

- iPhone 13
- Samsung Galaxy Note 20
- Keine Rahmen (Viewport.none)

Sehr hilfreich für Responsive Design!

### Zoom Addon

**Komponenten vergrößern/verkleinern**

Guter Test für skalierbare Komponenten.

### Text Scale Addon

**Text-Größe anpassen (1.0x - 2.0x)**

Testet Accessibility für Benutzer mit schlechterer Sicht.

### Localization Addon

**Sprache ändern**

- English (en_US)
- Deutsch (de_DE)

Wichtig für i18n-Tests!

---

## 🎛️ Knobs (Interaktive Parameter)

Jeder Use-Case hat interaktive **Knobs** zum Anpassen von Parametern:

### Text Knobs

```dart
context.knobs.string(
  label: 'Label',
  initialValue: 'Get Started',
)
```

Textfeld zum Bearbeiten von String-Werten in Echtzeit.

### Boolean Knobs

```dart
context.knobs.boolean(
  label: 'Is Loading',
  initialValue: false,
)
```

Toggle zum An/Ausschalten von Boolean-Werten.

### Slider Knobs

```dart
context.knobs.slider(
  label: 'Width',
  initialValue: 200,
  min: 100,
  max: 400,
)
```

Schieberegler für numerische Werte.

---

## 📝 Beispiel: PrimaryButton Testen

### Use-Case: "Default"

1. **Storybook öffnen**
2. **Components > buttons > PrimaryButton > Default auswählen**
3. **Knobs verwenden:**
   - `Label` Text ändern
   - Theme wechseln (Light/Dark)
   - Device-Größe anpassen
4. **Button klicken** → Keine Aktion (onPressed ist leer)

### Use-Case: "Loading"

1. **Components > buttons > PrimaryButton > Loading auswählen**
2. **`Is Loading` Toggle** an/aus schalten
3. **Label ändern** (Standard: "Loading...")
4. Beobachte den Loading-Spinner

### Use-Case: "Custom Size"

1. **Components > buttons > PrimaryButton > Custom Size auswählen**
2. **Width Slider** bewegen (100 - 400)
3. **Height Slider** bewegen (40 - 80)
4. Button passt sich Größe an

---

## 🐛 Bugs in Widgetbook testen

### Scenario: Button-Label überläuft bei langen Texten

1. **Custom Size Use-Case öffnen**
2. **Width auf Minimum (100) setzen**
3. **Label auf langen Text setzen**: "This is a very long button label"
4. **Beobachte**: Text sollte ellipsis (...) haben, nicht overflow

```dart
Text(
  widget.label,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
)
```

---

## 📸 Screenshots speichern

Die Widgetbook ermöglicht Golden Tests:

```bash
# In Flutter-Projekt
flutter test --update-goldens
```

Perfekt für visuelles Regression Testing!

---

## ✨ Best Practices beim Testen

1. **Alle Themes durchgehen** (Light + Dark)
2. **Alle Device-Größen testen** (Mobile, Tablet, Desktop)
3. **Text Scaling** (1.0x, 1.5x, 2.0x) testen
4. **Verschiedene Sprachen** testen (wenn relevant)
5. **Edge Cases testen**:
   - Leere Strings
   - Sehr lange Strings
   - Null-Werte
   - Extreme Werte (Sliders)

---

## 🔧 Use-Cases hinzufügen

### 1. Use-Case Datei erstellen

```dart
// apps/storybook/lib/usecases/buttons/primary_button_usecases.dart

@widgetbook.UseCase(name: 'Custom Variant', type: PrimaryButton)
Widget primaryButtonCustomVariant(BuildContext context) {
  return Center(
    child: PrimaryButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'My Variant',
      ),
      onPressed: () {},
    ),
  );
}
```

### 2. Build regenerieren

```bash
melos run build
```

### 3. Im Widgetbook sofort sichtbar!

Die `main.directories.g.dart` wird automatisch aktualisiert.

---

## 🎯 Häufige Aufgaben

### Theme für Komponente prüfen

```dart
// Im Use-Case
BuildContext context; // Zugriff auf aktuelles Theme

final theme = Theme.of(context);
final primary = theme.colorScheme.primary;
final spacing = theme.extension<HivesSpacings>();
```

### Komponente in verschiedenen Größen zeigen

```dart
@widgetbook.UseCase(name: 'Sizes', type: PrimaryButton)
Widget primaryButtonSizes(BuildContext context) {
  return Column(
    children: [
      PrimaryButton(label: 'Small', onPressed: () {}, height: 40),
      PrimaryButton(label: 'Medium', onPressed: () {}, height: 48),
      PrimaryButton(label: 'Large', onPressed: () {}, height: 56),
    ],
  );
}
```

### Fehlerstate zeigen

```dart
@widgetbook.UseCase(name: 'Error State', type: HivesTextField)
Widget hivesTextFieldError(BuildContext context) {
  return HivesTextField(
    label: 'Email',
    errorText: context.knobs.boolean(
      label: 'Show Error',
      initialValue: true,
    ) ? 'Invalid email format' : null,
  );
}
```

---

## 📚 Ressourcen

- [Widgetbook Official Docs](https://www.widgetbook.io/docs)
- [Widgetbook Annotation Package](https://pub.dev/packages/widgetbook_annotation)
- [Build Runner](https://pub.dev/packages/build_runner)

---

## 🆘 Troubleshooting

### Widgetbook zeigt neue Use-Cases nicht?

```bash
# Build regenerieren
melos run build

# oder
cd apps/storybook
flutter pub run build_runner build
```

### Theme wird nicht angewendet?

Stelle sicher, dass die Komponente `Theme.of(context)` nutzt:

```dart
final theme = Theme.of(context); // ✅
final colors = theme.colorScheme;
```

### Knobs funktionieren nicht?

Überprüfe den Parameter-Namen:

```dart
context.knobs.string(label: 'Label', initialValue: 'default')
// Verwende denselben Namen für denselben Knob
```

---

Viel Spaß beim Testen der Hives UI-Komponenten! 🐝


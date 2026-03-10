import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/src/theme/app_spacing.dart';
import 'package:ui/src/theme/input_theme.dart';

/// A date picker field that visually matches [HivesTextField] styling.
///
/// Read-only tap-triggered field that opens [showDatePicker] on tap.
/// Formats the selected date as "d MMMM yyyy".
class HivesDatePicker extends StatelessWidget {
  const HivesDatePicker({
    super.key,
    this.label,
    this.hint = 'Select date',
    this.selectedDate,
    this.onDateSelected,
    this.isEnabled = true,
    this.errorText,
    this.firstDate,
    this.lastDate,
  });

  /// Label text displayed above the field.
  final String? label;

  /// Hint text displayed when no date is selected.
  final String hint;

  /// The currently selected date.
  final DateTime? selectedDate;

  /// Callback invoked when a date is selected.
  final ValueChanged<DateTime>? onDateSelected;

  /// Whether the field is enabled.
  final bool isEnabled;

  /// Error message displayed below the field.
  final String? errorText;

  /// The earliest selectable date.
  final DateTime? firstDate;

  /// The latest selectable date.
  final DateTime? lastDate;

  String? get _formattedDate {
    if (selectedDate == null) return null;
    return DateFormat('d MMMM yyyy').format(selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTokens = theme.extension<InputThemeTokens>();

    final displayText = _formattedDate;
    final hasError = errorText != null && errorText!.isNotEmpty;

    final field = ConstrainedBox(
      constraints: BoxConstraints(minHeight: inputTokens?.minHeight ?? 48.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? () => _showPicker(context) : null,
          borderRadius: AppSpacing.inputRadius,
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: hint,
              errorText: hasError ? errorText : null,
              suffixIcon: Icon(
                Icons.calendar_today,
                color: theme.colorScheme.onSurfaceVariant,
                semanticLabel: 'Select date',
              ),
              filled: !isEnabled,
              fillColor: !isEnabled ? Colors.grey.withValues(alpha: 0.1) : null,
            ),
            isEmpty: displayText == null,
            child: displayText != null
                ? Text(displayText, style: theme.textTheme.bodyLarge)
                : null,
          ),
        ),
      ),
    );

    if (label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(label!, style: theme.textTheme.titleSmall),
        ),
        field,
      ],
    );
  }

  Future<void> _showPicker(BuildContext context) async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );
    if (result != null) {
      onDateSelected?.call(result);
    }
  }
}

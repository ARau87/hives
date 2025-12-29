import 'package:flutter/material.dart';

import '../../theme/input_theme.dart';

/// A customized text input field following Hives design system.
///
/// [HivesTextField] provides a Material Design text input field with
/// theme-based styling, validation, and customizable behavior.
///
/// Example:
/// ```dart
/// HivesTextField(
///   label: 'Email',
///   hint: 'Enter your email',
///   onChanged: (value) => email = value,
/// )
/// ```
class HivesTextField extends StatefulWidget {
  /// The label text displayed above the input field.
  final String? label;

  /// The hint text displayed when the field is empty.
  final String? hint;

  /// Callback invoked when the input value changes.
  final ValueChanged<String>? onChanged;

  /// Callback invoked when the input field is submitted.
  final VoidCallback? onSubmitted;

  /// The initial value of the text field.
  final String? initialValue;

  /// Whether this input field is enabled.
  final bool isEnabled;

  /// Whether this is a password field.
  final bool isPassword;

  /// Error message displayed below the input field.
  final String? errorText;

  /// Number of lines for the input field (1 for single line).
  final int maxLines;

  /// Maximum number of characters allowed.
  final int? maxLength;

  /// Input type for keyboard selection.
  final TextInputType keyboardType;

  /// Optional prefix icon.
  final Widget? prefixIcon;

  /// Optional suffix icon.
  final Widget? suffixIcon;

  /// Custom text input action.
  final TextInputAction textInputAction;

  /// Text editing controller.
  final TextEditingController? controller;

  /// Custom input decoration.
  final InputDecoration? decoration;

  const HivesTextField({
    Key? key,
    this.label,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.initialValue,
    this.isEnabled = true,
    this.isPassword = false,
    this.errorText,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.decoration,
  }) : super(key: key);

  @override
  State<HivesTextField> createState() => _HivesTextFieldState();
}

class _HivesTextFieldState extends State<HivesTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTokens = theme.extension<InputThemeTokens>();
    final hasError = widget.errorText?.isNotEmpty ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.label!,
              style: theme.textTheme.titleSmall?.copyWith(
                color: hasError
                    ? theme.colorScheme.error
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: widget.isEnabled,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword && !_isPasswordVisible,
          onChanged: widget.onChanged,
          onSubmitted: (_) => widget.onSubmitted?.call(),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: inputTokens?.hintFontSize ?? 16.0,
          ),
          decoration:
              widget.decoration ??
              InputDecoration(
                hintText: widget.hint,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: inputTokens?.hintFontSize ?? 16.0,
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      )
                    : widget.suffixIcon,
                errorText: widget.errorText,
                filled: true,
                fillColor: widget.isEnabled
                    ? Colors.transparent
                    : Colors.grey.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    inputTokens?.borderRadius ?? 8.0,
                  ),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: inputTokens?.borderWidth ?? 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    inputTokens?.borderRadius ?? 8.0,
                  ),
                  borderSide: BorderSide(
                    color: hasError
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                    width: inputTokens?.focusedBorderWidth ?? 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    inputTokens?.borderRadius ?? 8.0,
                  ),
                  borderSide: BorderSide(
                    color: hasError
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                    width: inputTokens?.borderWidth ?? 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    inputTokens?.borderRadius ?? 8.0,
                  ),
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                    width: inputTokens?.borderWidth ?? 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    inputTokens?.borderRadius ?? 8.0,
                  ),
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                    width: inputTokens?.focusedBorderWidth ?? 2.0,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    inputTokens?.borderRadius ?? 8.0,
                  ),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: inputTokens?.borderWidth ?? 1.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: inputTokens?.paddingHorizontal ?? 16.0,
                  vertical: inputTokens?.paddingVertical ?? 12.0,
                ),
              ),
        ),
      ],
    );
  }
}

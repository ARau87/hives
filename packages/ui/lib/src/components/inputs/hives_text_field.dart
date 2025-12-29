import 'package:flutter/material.dart';

import '../../theme/input_theme.dart';

/// A customized text input field following Hives design system.
///
/// [HivesTextField] leverages the app's [InputDecorationTheme] instead of
/// restyling borders and paddings inline. Only functional props are set here.
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

  /// Custom input decoration. Prefer theme.
  final InputDecoration? decoration;

  const HivesTextField({
    super.key,
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
  });

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

    final field = TextField(
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
      style: theme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: (theme.textTheme.bodyLarge?.fontSize ?? 16) + 2,
      ),
      decoration: _buildDecoration(theme, inputTokens),
    );

    if (widget.label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(widget.label!, style: theme.textTheme.titleSmall),
        ),
        field,
      ],
    );
  }

  InputDecoration _buildDecoration(
    ThemeData theme,
    InputThemeTokens? inputTokens,
  ) {
    final suffix = widget.isPassword
        ? IconButton(
            onPressed: () =>
                setState(() => _isPasswordVisible = !_isPasswordVisible),
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
          )
        : widget.suffixIcon;

    final base = (widget.decoration ?? const InputDecoration()).copyWith(
      hintText: widget.hint,
      prefixIcon: widget.prefixIcon,
      suffixIcon: suffix,
      errorText: widget.errorText,
      hintStyle: theme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: (theme.textTheme.bodyLarge?.fontSize ?? 16) + 2,
      ),
      filled: false,
      fillColor: Colors.transparent,
      contentPadding: inputTokens == null
          ? null
          : EdgeInsets.symmetric(
              horizontal: inputTokens.paddingHorizontal,
              vertical: inputTokens.paddingVertical,
            ),
    );

    if (!widget.isEnabled) {
      return base.copyWith(
        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.1),
      );
    }
    return base;
  }
}

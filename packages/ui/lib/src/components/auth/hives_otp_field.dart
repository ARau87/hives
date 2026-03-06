import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/src/theme/app_colors.dart';

/// A 6-digit OTP input field with auto-advance, paste support, and error state.
///
/// Renders 6 individual 52px cells with 12px border radius and 10px gap.
/// Supports auto-advancing focus, pasting a 6-digit code, and a shake
/// animation with red border on error.
class HivesOTPField extends StatefulWidget {
  const HivesOTPField({
    super.key,
    this.onComplete,
    this.hasError = false,
  });

  /// Called when all 6 digits have been entered.
  final ValueChanged<String>? onComplete;

  /// Whether the field is in an error state.
  ///
  /// When true, cells show a red border and a shake animation plays.
  final bool hasError;

  @override
  State<HivesOTPField> createState() => HivesOTPFieldState();
}

/// State for [HivesOTPField], exposed to allow calling [clear] externally.
class HivesOTPFieldState extends State<HivesOTPField>
    with SingleTickerProviderStateMixin {
  static const _digitCount = 6;
  static const _cellSize = 52.0;
  static const _cellRadius = 12.0;
  static const _cellGap = 10.0;

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  late final AnimationController _shakeController;
  late final Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _digitCount,
      (_) => TextEditingController(),
    );
    _focusNodes = List.generate(_digitCount, (_) {
      final node = FocusNode();
      node.addListener(_onFocusChange);
      return node;
    });

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(begin: Offset.zero, end: const Offset(0.03, 0)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(0.03, 0),
          end: const Offset(-0.03, 0),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(-0.03, 0),
          end: const Offset(0.02, 0),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0.02, 0), end: Offset.zero),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(HivesOTPField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasError && !oldWidget.hasError) {
      _shakeController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.removeListener(_onFocusChange);
      f.dispose();
    }
    _shakeController.dispose();
    super.dispose();
  }

  /// Clears all cells and returns focus to the first cell.
  void clear() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
  }

  void _onChanged(int index, String value) {
    // Handle paste of multi-digit string
    if (value.length > 1) {
      _handlePaste(value);
      return;
    }

    if (value.isNotEmpty && index < _digitCount - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    _checkComplete();
  }

  void _handlePaste(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    for (var i = 0; i < _digitCount && i < digits.length; i++) {
      _controllers[i].text = digits[i];
    }
    final lastIndex =
        (digits.length < _digitCount ? digits.length : _digitCount) - 1;
    if (lastIndex >= 0 && lastIndex < _digitCount) {
      _focusNodes[lastIndex].requestFocus();
    }
    _checkComplete();
  }

  KeyEventResult _onKeyEvent(int index, FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _checkComplete() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == _digitCount) {
      widget.onComplete?.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SlideTransition(
      position: _shakeAnimation,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_digitCount, (index) {
          final isActive = _focusNodes[index].hasFocus;
          final borderColor = widget.hasError
              ? AppColors.urgentStatus
              : isActive
                  ? AppColors.primary
                  : AppColors.outline;

          return Padding(
            padding: EdgeInsets.only(
              right: index < _digitCount - 1 ? _cellGap : 0,
            ),
            child: SizedBox(
              width: _cellSize,
              height: _cellSize,
              child: Focus(
                onKeyEvent: (node, event) => _onKeyEvent(index, node, event),
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(_cellRadius),
                      borderSide: BorderSide(color: borderColor, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(_cellRadius),
                      borderSide: BorderSide(color: borderColor, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(_cellRadius),
                      borderSide: BorderSide(
                        color: widget.hasError
                            ? AppColors.urgentStatus
                            : AppColors.primary,
                        width: 2.5,
                      ),
                    ),
                  ),
                  onChanged: (value) => _onChanged(index, value),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

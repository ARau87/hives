import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Interactive',
  type: HivesPasswordStrengthIndicator,
)
Widget passwordStrengthInteractive(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: _PasswordStrengthDemo(
        initialPassword: context.knobs.string(
          label: 'Password',
          initialValue: '',
        ),
      ),
    ),
  );
}

class _PasswordStrengthDemo extends StatefulWidget {
  const _PasswordStrengthDemo({required this.initialPassword});

  final String initialPassword;

  @override
  State<_PasswordStrengthDemo> createState() => _PasswordStrengthDemoState();
}

class _PasswordStrengthDemoState extends State<_PasswordStrengthDemo> {
  late String _password;

  @override
  void initState() {
    super.initState();
    _password = widget.initialPassword;
  }

  @override
  void didUpdateWidget(_PasswordStrengthDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPassword != oldWidget.initialPassword) {
      _password = widget.initialPassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HivesTextField(
          label: 'Password',
          hint: 'Type to see strength',
          isPassword: true,
          onChanged: (value) => setState(() => _password = value),
        ),
        const SizedBox(height: 16),
        HivesPasswordStrengthIndicator(password: _password),
      ],
    );
  }
}

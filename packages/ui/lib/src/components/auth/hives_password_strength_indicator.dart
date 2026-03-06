import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_colors.dart';
import 'package:ui/src/theme/app_spacing.dart';

/// Displays password strength validation rules with animated color feedback.
///
/// Accepts a [password] string and shows 4 rule rows:
/// - 8+ characters
/// - At least one uppercase letter
/// - At least one lowercase letter
/// - At least one digit
///
/// Each rule animates from gray to green over 200ms when fulfilled.
class HivesPasswordStrengthIndicator extends StatelessWidget {
  const HivesPasswordStrengthIndicator({super.key, required this.password});

  /// The password string to evaluate against strength rules.
  final String password;

  static final _uppercaseRegex = RegExp(r'[A-Z]');
  static final _lowercaseRegex = RegExp(r'[a-z]');
  static final _digitRegex = RegExp(r'[0-9]');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _RuleRow(
          label: '8+ characters',
          isSatisfied: password.length >= 8,
        ),
        const SizedBox(height: AppSpacing.xs),
        _RuleRow(
          label: 'One uppercase letter (A-Z)',
          isSatisfied: _uppercaseRegex.hasMatch(password),
        ),
        const SizedBox(height: AppSpacing.xs),
        _RuleRow(
          label: 'One lowercase letter (a-z)',
          isSatisfied: _lowercaseRegex.hasMatch(password),
        ),
        const SizedBox(height: AppSpacing.xs),
        _RuleRow(
          label: 'One digit (0-9)',
          isSatisfied: _digitRegex.hasMatch(password),
        ),
      ],
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.label, required this.isSatisfied});

  final String label;
  final bool isSatisfied;

  @override
  Widget build(BuildContext context) {
    const satisfiedColor = AppColors.healthyStatus;
    const unsatisfiedColor = AppColors.onSurfaceVariant;
    final targetColor = isSatisfied ? satisfiedColor : unsatisfiedColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<Color?>(
          tween: ColorTween(
            begin: unsatisfiedColor,
            end: targetColor,
          ),
          duration: const Duration(milliseconds: 200),
          builder: (context, color, _) => Icon(
            isSatisfied ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: color ?? targetColor,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: targetColor,
          ),
          child: Text(label),
        ),
      ],
    );
  }
}

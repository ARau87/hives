import 'package:flutter/material.dart';

/// A section header with a title and an optional action label.
///
/// Renders an 18px SemiBold title with an optional 14px Medium action
/// text in a space-between row.
class HivesSectionHeader extends StatelessWidget {
  const HivesSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  /// The section title.
  final String title;

  /// Optional action label displayed on the right.
  final String? actionLabel;

  /// Callback invoked when the action label is tapped.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        if (actionLabel != null)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onAction,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 2.0,
                ),
                child: Text(
                  actionLabel!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

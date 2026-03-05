import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Shows all four status badge variants side by side.
@widgetbook.UseCase(name: 'All Variants', type: StatusBadge)
Widget statusBadgeAllVariants(BuildContext context) {
  return const Center(
    child: Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.lg,
      children: [
        _LabeledBadge('Healthy', HivesStatusVariant.healthy),
        _LabeledBadge('Attention', HivesStatusVariant.attention),
        _LabeledBadge('Urgent', HivesStatusVariant.urgent),
        _LabeledBadge('Unknown', HivesStatusVariant.unknown),
      ],
    ),
  );
}

/// Single badge with interactive variant and size knobs.
@widgetbook.UseCase(name: 'Interactive', type: StatusBadge)
Widget statusBadgeInteractive(BuildContext context) {
  final variant = context.knobs.object.dropdown(
    label: 'Variant',
    options: HivesStatusVariant.values,
    labelBuilder: (v) => v.name,
    initialOption: HivesStatusVariant.healthy,
  );
  final size = context.knobs.double.slider(
    label: 'Size',
    initialValue: 24,
    min: 16,
    max: 64,
  );

  return Center(
    child: StatusBadge(variant: variant, size: size),
  );
}

/// Demonstrates custom sizing of the badge.
@widgetbook.UseCase(name: 'Size Comparison', type: StatusBadge)
Widget statusBadgeSizeComparison(BuildContext context) {
  return const Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatusBadge(variant: HivesStatusVariant.healthy, size: 16),
        SizedBox(width: AppSpacing.sm),
        StatusBadge(variant: HivesStatusVariant.healthy, size: 24),
        SizedBox(width: AppSpacing.sm),
        StatusBadge(variant: HivesStatusVariant.healthy, size: 32),
        SizedBox(width: AppSpacing.sm),
        StatusBadge(variant: HivesStatusVariant.healthy, size: 48),
      ],
    ),
  );
}

class _LabeledBadge extends StatelessWidget {
  const _LabeledBadge(this.label, this.variant);

  final String label;
  final HivesStatusVariant variant;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatusBadge(variant: variant),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: context.textTheme.labelSmall),
      ],
    );
  }
}

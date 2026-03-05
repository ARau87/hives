import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Gallery widget displaying all AppSpacing constants and BorderRadius presets.
///
/// Visualizes the 4px grid spacing scale, semantic aliases, and shape tokens.
@widgetbook.UseCase(
  name: 'All Spacing',
  type: SpacingGallery,
  path: 'tokens/spacing',
)
Widget spacingGallery(BuildContext context) {
  return const SpacingGallery();
}

class SpacingGallery extends StatelessWidget {
  const SpacingGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        children: [
          Text('Base Spacing Scale (4px grid)',
              style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          const _SpacingRow('xs', AppSpacing.xs),
          const _SpacingRow('sm', AppSpacing.sm),
          const _SpacingRow('md', AppSpacing.md),
          const _SpacingRow('lg', AppSpacing.lg),
          const _SpacingRow('xl', AppSpacing.xl),
          const _SpacingRow('xxl', AppSpacing.xxl),
          const _SpacingRow('xxxl', AppSpacing.xxxl),
          const SizedBox(height: AppSpacing.xxl),
          Text('Semantic Aliases', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          const _SpacingRow('cardPadding', AppSpacing.cardPadding),
          const _SpacingRow('sectionGap', AppSpacing.sectionGap),
          const _SpacingRow('screenMargin', AppSpacing.screenMargin),
          const _SpacingRow('touchTargetMin', AppSpacing.touchTargetMin),
          const _SpacingRow('buttonHeight', AppSpacing.buttonHeight),
          const _SpacingRow('fabDiameter', AppSpacing.fabDiameter),
          const SizedBox(height: AppSpacing.xxl),
          Text('Dimensions', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          const _SpacingRow('dragHandleWidth', AppSpacing.dragHandleWidth),
          const _SpacingRow('dragHandleHeight', AppSpacing.dragHandleHeight),
          const _SpacingRow('dividerSpace', AppSpacing.dividerSpace),
          const SizedBox(height: AppSpacing.xxl),
          Text('BorderRadius Presets', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          const Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.lg,
            children: [
              _RadiusDemo('buttonRadius\n(16)', AppSpacing.buttonRadius),
              _RadiusDemo('cardRadius\n(24)', AppSpacing.cardRadius),
              _RadiusDemo('chipRadius\n(12)', AppSpacing.chipRadius),
              _RadiusDemo('inputRadius\n(14)', AppSpacing.inputRadius),
              _RadiusDemo('modalTopRadius\n(28 top)', AppSpacing.modalTopRadius),
              _RadiusDemo('dragHandleRadius\n(2)', AppSpacing.dragHandleRadius),
            ],
          ),
        ],
      ),
    );
  }
}

class _SpacingRow extends StatelessWidget {
  const _SpacingRow(this.label, this.value);

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label (${value.toInt()}px)',
              style: context.textTheme.bodySmall,
            ),
          ),
          Container(
            width: value,
            height: 24,
            decoration: BoxDecoration(
              color: context.colors.honey.withValues(alpha: 0.6),
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadiusDemo extends StatelessWidget {
  const _RadiusDemo(this.label, this.radius);

  final String label;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: context.colors.honey.withValues(alpha: 0.3),
            borderRadius: radius,
            border: Border.all(color: context.colors.honey, width: 2),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: context.textTheme.labelSmall, textAlign: TextAlign.center),
      ],
    );
  }
}

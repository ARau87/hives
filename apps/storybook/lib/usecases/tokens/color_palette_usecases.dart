import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Gallery widget displaying all Hives design system colors.
///
/// Shows both the Material ColorScheme colors and the custom
/// HivesColors ThemeExtension tokens used throughout the app.
@widgetbook.UseCase(
  name: 'All Colors',
  type: ColorPaletteGallery,
  path: 'tokens/colors',
)
Widget colorPaletteGallery(BuildContext context) {
  return const ColorPaletteGallery();
}

class ColorPaletteGallery extends StatelessWidget {
  const ColorPaletteGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final scheme = context.colorScheme;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        children: [
          Text('Brand Colors', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _Swatch('honey', colors.honey),
              _Swatch('honeyLight', colors.honeyLight),
              _Swatch('honeyDark', colors.honeyDark),
              _Swatch('secondary', colors.secondary),
              _Swatch('secondaryLight', colors.secondaryLight),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text('Nature / Accent Colors', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _Swatch('nature', colors.nature),
              _Swatch('natureLightShade', colors.natureLightShade),
              _Swatch('natureDarkShade', colors.natureDarkShade),
              _Swatch('orange', colors.orange),
              _Swatch('orangeLight', colors.orangeLight),
              _Swatch('orangeDark', colors.orangeDark),
              const _Swatch('teal', AppColors.teal),
              const _Swatch('tealLight', AppColors.tealLight),
              const _Swatch('blue', AppColors.blue),
              const _Swatch('blueLight', AppColors.blueLight),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text('Status Colors', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _Swatch('healthyStatus', colors.healthyStatus),
              _Swatch('healthyFill', colors.healthyFill),
              _Swatch('attentionStatus', colors.attentionStatus),
              _Swatch('attentionFill', colors.attentionFill),
              _Swatch('urgentStatus', colors.urgentStatus),
              _Swatch('urgentFill', colors.urgentFill),
              _Swatch('unknownStatus', colors.unknownStatus),
              _Swatch('unknownFill', colors.unknownFill),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text('Surface / Outline', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _Swatch('surface', colors.surface),
              _Swatch('surfaceVariant', colors.surfaceVariant),
              const _Swatch('background', AppColors.background),
              _Swatch('outline', colors.outline),
              _Swatch('outlineVariant', colors.outlineVariant),
              const _Swatch('onSurfaceVariant', AppColors.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text('Material ColorScheme', style: context.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _Swatch('primary', scheme.primary),
              _Swatch('onPrimary', scheme.onPrimary),
              _Swatch('secondary', scheme.secondary),
              _Swatch('onSecondary', scheme.onSecondary),
              _Swatch('tertiary', scheme.tertiary),
              _Swatch('error', scheme.error),
              _Swatch('surface', scheme.surface),
              _Swatch('onSurface', scheme.onSurface),
            ],
          ),
        ],
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // Use white text on dark colors, black text on light colors.
    final luminance = color.computeLuminance();
    final textColor = luminance > 0.5 ? Colors.black87 : Colors.white;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppSpacing.chipRadius,
            border: Border.all(color: context.colors.outline),
          ),
          alignment: Alignment.center,
          child: Text(
            '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
            style: context.textTheme.labelSmall?.copyWith(
              color: textColor,
              fontSize: 9,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: context.textTheme.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

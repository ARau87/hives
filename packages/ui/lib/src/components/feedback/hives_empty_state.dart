import 'package:flutter/material.dart';
import 'package:ui/src/components/buttons/primary_button.dart';
import 'package:ui/src/theme/app_colors.dart';
import 'package:ui/src/theme/app_spacing.dart';
import 'package:ui/src/theme/app_typography.dart';

/// Variants for the [HivesEmptyState] widget.
enum HivesEmptyStateVariant {
  /// No locations have been created yet.
  noLocations,

  /// No hives exist at the current location.
  noHives,

  /// No tasks need attention.
  noTasks,

  /// Search or filter returned no results.
  noResults,
}

/// An empty-state placeholder shown when a list or screen has no content.
///
/// Renders a vertically centered column with an illustration, title, subtitle,
/// and an optional CTA button. Use the named factory constructors for
/// pre-configured variants, or the default constructor for full customization.
class HivesEmptyState extends StatelessWidget {
  /// The illustration widget displayed at the top (rendered at 96px).
  final Widget illustration;

  /// The primary message (18px SemiBold).
  final String title;

  /// The secondary message (15px Regular, onSurfaceVariant).
  final String subtitle;

  /// Optional call-to-action button label.
  final String? ctaLabel;

  /// Optional callback when the CTA button is tapped.
  final VoidCallback? onCta;

  const HivesEmptyState({
    super.key,
    required this.illustration,
    required this.title,
    required this.subtitle,
    this.ctaLabel,
    this.onCta,
  });

  /// No locations have been created yet.
  factory HivesEmptyState.noLocations({
    Key? key,
    String? ctaLabel,
    VoidCallback? onCta,
  }) {
    return HivesEmptyState(
      key: key,
      illustration: const Icon(
        Icons.location_off,
        size: 96,
        color: AppColors.onSurfaceVariant,
        semanticLabel: 'No locations',
      ),
      title: 'No locations yet',
      subtitle: 'Add your first apiary to get started',
      ctaLabel: ctaLabel,
      onCta: onCta,
    );
  }

  /// No hives exist at the current location.
  factory HivesEmptyState.noHives({
    Key? key,
    String? ctaLabel,
    VoidCallback? onCta,
  }) {
    return HivesEmptyState(
      key: key,
      illustration: const Icon(
        Icons.hive,
        size: 96,
        color: AppColors.onSurfaceVariant,
        semanticLabel: 'No hives',
      ),
      title: 'No hives here',
      subtitle: 'Add your first hive to this location',
      ctaLabel: ctaLabel,
      onCta: onCta,
    );
  }

  /// No tasks need attention.
  factory HivesEmptyState.noTasks({
    Key? key,
    String? ctaLabel,
    VoidCallback? onCta,
  }) {
    return HivesEmptyState(
      key: key,
      illustration: const Icon(
        Icons.check_circle_outline,
        size: 96,
        color: AppColors.healthyStatus,
        semanticLabel: 'All caught up',
      ),
      title: 'All caught up!',
      subtitle: 'No tasks need your attention right now',
      ctaLabel: ctaLabel,
      onCta: onCta,
    );
  }

  /// Search or filter returned no results.
  factory HivesEmptyState.noResults({
    Key? key,
    String? ctaLabel,
    VoidCallback? onCta,
  }) {
    return HivesEmptyState(
      key: key,
      illustration: const Icon(
        Icons.search_off,
        size: 96,
        color: AppColors.onSurfaceVariant,
        semanticLabel: 'No results',
      ),
      title: 'No results found',
      subtitle: 'Try adjusting your search or filters',
      ctaLabel: ctaLabel,
      onCta: onCta,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 96, height: 96, child: illustration),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (ctaLabel != null && onCta != null) ...[
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(label: ctaLabel!, onPressed: onCta!),
            ],
          ],
        ),
      ),
    );
  }
}

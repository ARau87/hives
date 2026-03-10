import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_colors.dart';
import 'package:ui/src/theme/app_spacing.dart';
import 'package:ui/src/theme/app_typography.dart';

/// Location health status variants for [HivesLocationCard].
///
/// Uses location-specific colors: teal for healthy (not green),
/// amber for attention, red for urgent, gray for empty (no hives).
enum HivesLocationStatus {
  /// Location hives are all healthy — teal icon.
  healthy,

  /// One or more hives need attention — amber icon.
  attention,

  /// One or more hives need urgent care — red icon.
  urgent,

  /// Location has no hives yet — gray icon.
  empty,
}

/// A full-bleed image location card with a gradient overlay and status icon.
///
/// Renders full-width × 160px with the [image] as background (or a placeholder
/// landscape icon when no image is provided). A dark gradient fades in at the
/// bottom, with white text for [locationName] and [statusSummary]. A status
/// icon in the top-right corner indicates [status]. Supports a shimmer loading
/// variant via [isLoading].
class HivesLocationCard extends StatefulWidget {
  /// The location name displayed as the primary text.
  final String locationName;

  /// Secondary text showing hive count and status summary.
  final String statusSummary;

  /// The aggregate health status controlling the status icon.
  final HivesLocationStatus status;

  /// Optional background image. When null, a placeholder is displayed.
  final ImageProvider? image;

  /// Whether the card is in a loading/shimmer state.
  final bool isLoading;

  /// Callback invoked when the card is tapped.
  final VoidCallback? onTap;

  const HivesLocationCard({
    super.key,
    required this.locationName,
    required this.statusSummary,
    required this.status,
    this.image,
    this.isLoading = false,
    this.onTap,
  });

  @override
  State<HivesLocationCard> createState() => _HivesLocationCardState();
}

class _HivesLocationCardState extends State<HivesLocationCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;
  late final Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _shimmerAnimation = Tween<double>(begin: -0.5, end: 1.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.linear),
    );
    if (widget.isLoading) {
      _shimmerController.repeat();
    }
  }

  @override
  void didUpdateWidget(HivesLocationCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      _shimmerController.repeat();
    } else if (!widget.isLoading && oldWidget.isLoading) {
      _shimmerController.stop();
      _shimmerController.reset();
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Color get _statusColor => switch (widget.status) {
    HivesLocationStatus.healthy => AppColors.teal,
    HivesLocationStatus.attention => AppColors.attentionStatus,
    HivesLocationStatus.urgent => AppColors.urgentStatus,
    HivesLocationStatus.empty => AppColors.onSurfaceVariant,
  };

  IconData get _statusIcon => switch (widget.status) {
    HivesLocationStatus.healthy => Icons.check_circle,
    HivesLocationStatus.attention => Icons.warning_rounded,
    HivesLocationStatus.urgent => Icons.error,
    HivesLocationStatus.empty => Icons.add_circle_outline,
  };

  String get _statusLabel => switch (widget.status) {
    HivesLocationStatus.healthy => 'Healthy',
    HivesLocationStatus.attention => 'Needs attention',
    HivesLocationStatus.urgent => 'Urgent',
    HivesLocationStatus.empty => 'No hives',
  };

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _buildShimmer();
    }
    return _buildCard();
  }

  Widget _buildCard() {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image or placeholder
            if (widget.image != null)
              Image(
                image: widget.image!,
                fit: BoxFit.cover,
                semanticLabel: '${widget.locationName} photo',
              )
            else
              Container(
                color: AppColors.tealLight,
                child: const Icon(
                  Icons.landscape_outlined,
                  color: AppColors.teal,
                  size: 48,
                  semanticLabel: 'Location placeholder',
                ),
              ),

            // Dark gradient overlay at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 96,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.0),
                      Colors.black.withValues(alpha: 0.65),
                    ],
                  ),
                ),
              ),
            ),

            // Type icon — top left
            Positioned(
              top: AppSpacing.sm,
              left: AppSpacing.sm,
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.white.withValues(alpha: 0.9),
                size: 20,
              ),
            ),

            // Status icon — top right
            Positioned(
              top: AppSpacing.sm,
              right: AppSpacing.sm,
              child: Icon(
                _statusIcon,
                color: _statusColor,
                size: 24,
                semanticLabel: _statusLabel,
              ),
            ),

            // Text content at the bottom
            Positioned(
              left: AppSpacing.lg,
              right: AppSpacing.md,
              bottom: AppSpacing.lg,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.locationName,
                          style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          widget.statusSummary,
                          style: AppTypography.label.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 20,
                  ),
                ],
              ),
            ),

            // Tap handler
            if (widget.onTap != null)
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onTap,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return SizedBox(
      height: 200,
      child: AnimatedBuilder(
        animation: _shimmerAnimation,
        builder: (context, child) {
          final progress = _shimmerAnimation.value;
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: const Color(0xFFF5F5F4)),
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.4),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                          stops: [
                            (progress - 0.3).clamp(0.0, 1.0),
                            progress.clamp(0.0, 1.0),
                            (progress + 0.3).clamp(0.0, 1.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

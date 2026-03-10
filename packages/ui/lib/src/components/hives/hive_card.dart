import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_colors.dart';
import 'package:ui/src/theme/app_spacing.dart';
import 'package:ui/src/theme/app_typography.dart';
import 'package:ui/src/components/hives/hives_hive_status.dart';

/// A full-bleed image hive card with a gradient overlay and status icon.
///
/// Renders full-width × 160px with [image] as background (or a warm honey
/// placeholder when no image is provided). A dark gradient fades in at the
/// bottom, with white text for [hiveName] and an optional [statusSummary].
/// A status icon in the top-right corner indicates [status]. Supports a
/// shimmer loading state via [isLoading].
///
/// Example:
/// ```dart
/// HiveCard(
///   hiveName: 'Hive Alpha',
///   status: HivesHiveStatus.healthy,
///   statusSummary: '3 days ago',
///   image: AssetImage('assets/hive.jpg'),
///   onTap: () {},
/// )
/// ```
class HiveCard extends StatefulWidget {
  const HiveCard({
    super.key,
    required this.hiveName,
    required this.status,
    this.statusSummary,
    this.image,
    this.isLoading = false,
    this.onTap,
  });

  /// The hive name displayed as the primary text.
  final String hiveName;

  /// Optional secondary text (e.g. last inspected date or observation).
  final String? statusSummary;

  /// The health status controlling the status icon and placeholder tint.
  final HivesHiveStatus status;

  /// Optional background image. When null, a honey placeholder is displayed.
  final ImageProvider? image;

  /// Whether the card is in a loading/shimmer state.
  final bool isLoading;

  /// Callback invoked when the card is tapped.
  final VoidCallback? onTap;

  @override
  State<HiveCard> createState() => _HiveCardState();
}

class _HiveCardState extends State<HiveCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;
  late final Animation<double> _shimmerAnimation;

  static const double _height = 160;
  static const double _radius = 20;

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
  void didUpdateWidget(HiveCard oldWidget) {
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
    HivesHiveStatus.healthy => AppColors.healthyStatus,
    HivesHiveStatus.attention => AppColors.attentionStatus,
    HivesHiveStatus.urgent => AppColors.urgentStatus,
    HivesHiveStatus.unknown => AppColors.onSurfaceVariant,
  };

  IconData get _statusIcon => switch (widget.status) {
    HivesHiveStatus.healthy => Icons.check_circle,
    HivesHiveStatus.attention => Icons.warning_rounded,
    HivesHiveStatus.urgent => Icons.error,
    HivesHiveStatus.unknown => Icons.help_outline,
  };

  String get _statusLabel => switch (widget.status) {
    HivesHiveStatus.healthy => 'Healthy',
    HivesHiveStatus.attention => 'Needs attention',
    HivesHiveStatus.urgent => 'Urgent',
    HivesHiveStatus.unknown => 'Unknown',
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
      height: _height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_radius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image or warm honey placeholder
            if (widget.image != null)
              Image(
                image: widget.image!,
                fit: BoxFit.cover,
                semanticLabel: '${widget.hiveName} photo',
              )
            else
              Container(
                color: AppColors.primaryLight,
                child: const Icon(
                  Icons.hexagon_outlined,
                  color: AppColors.primary,
                  size: 48,
                  semanticLabel: 'Hive placeholder',
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
                Icons.hexagon_outlined,
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
                          widget.hiveName,
                          style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.statusSummary != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            widget.statusSummary!,
                            style: AppTypography.label.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
                    borderRadius: BorderRadius.circular(_radius),
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
      height: _height,
      child: AnimatedBuilder(
        animation: _shimmerAnimation,
        builder: (context, child) {
          final progress = _shimmerAnimation.value;
          return ClipRRect(
            borderRadius: BorderRadius.circular(_radius),
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

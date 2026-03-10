import 'package:flutter/material.dart';
import 'package:ui/src/theme/app_colors.dart';
import 'package:ui/src/theme/app_spacing.dart';
import 'package:ui/src/theme/app_typography.dart';

/// A map preview widget displaying a location pin or "no pin set" placeholder.
///
/// Renders full-width × 160px with 20px border radius. When [hasPin] is true,
/// displays a teal pin marker centered over the [mapContent] background.
/// When false, shows a gray placeholder with "Tap to set location".
/// Supports a shimmer loading variant via [isLoading].
class HivesMapPreviewWidget extends StatefulWidget {
  /// Whether a map pin is placed. When false, shows the "no pin" placeholder.
  final bool hasPin;

  /// Optional map tile background widget. Defaults to a light gray placeholder.
  final Widget? mapContent;

  /// Whether the widget is in a loading/shimmer state.
  final bool isLoading;

  /// Callback invoked when the widget is tapped.
  final VoidCallback? onTap;

  const HivesMapPreviewWidget({
    super.key,
    this.hasPin = true,
    this.mapContent,
    this.isLoading = false,
    this.onTap,
  });

  @override
  State<HivesMapPreviewWidget> createState() => _HivesMapPreviewWidgetState();
}

class _HivesMapPreviewWidgetState extends State<HivesMapPreviewWidget>
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
  void didUpdateWidget(HivesMapPreviewWidget oldWidget) {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background
            if (widget.isLoading)
              Container(color: const Color(0xFFF5F5F4))
            else if (!widget.hasPin)
              _buildNoPinPlaceholder()
            else
              widget.mapContent ??
                  Container(color: const Color(0xFFE8EDF2)),

            // Pin marker
            if (widget.hasPin && !widget.isLoading)
              const Center(
                child: Icon(
                  Icons.location_pin,
                  color: AppColors.teal,
                  size: 36,
                  semanticLabel: 'Map pin',
                ),
              ),

            // Shimmer overlay
            if (widget.isLoading) _buildShimmerOverlay(),

            // Tap handler
            if (widget.onTap != null && !widget.isLoading)
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(onTap: widget.onTap),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoPinPlaceholder() {
    return Container(
      color: AppColors.outline,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 32,
            color: AppColors.onSurfaceVariant,
            semanticLabel: 'No location set',
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Tap to set location',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerOverlay() {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        final progress = _shimmerAnimation.value;
        return Positioned.fill(
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
        );
      },
    );
  }
}

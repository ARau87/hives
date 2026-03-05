import 'package:flutter/material.dart';
import 'package:ui/src/extensions/context_extensions.dart';

/// A branded circular loading indicator using the Hives honey/amber color.
///
/// Uses [HivesColors.honey] (`#F59E0A`) as the indicator color.
/// Optionally constrained to a specific [size] via a [SizedBox].
///
/// Example:
/// ```dart
/// // Unconstrained — fills available space
/// HivesLoadingIndicator()
///
/// // Fixed 48px square
/// HivesLoadingIndicator(size: 48)
/// ```
class HivesLoadingIndicator extends StatelessWidget {
  /// Stroke width of the circular indicator. Defaults to 3.
  final double strokeWidth;

  /// Optional fixed diameter in logical pixels.
  /// When null, the indicator is unconstrained (caller must provide sizing).
  final double? size;

  const HivesLoadingIndicator({
    super.key,
    this.strokeWidth = 3.0,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final indicator = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(context.colors.honey),
      strokeWidth: strokeWidth,
      semanticsLabel: 'Loading',
    );

    if (size == null) return indicator;
    return SizedBox(width: size, height: size, child: indicator);
  }
}

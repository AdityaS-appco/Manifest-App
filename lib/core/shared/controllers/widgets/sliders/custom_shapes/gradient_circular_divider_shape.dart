import 'package:manifest/helper/import.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// Custom divider shape with gradient support for sliders
class GradientCircularDividerShape extends SfDividerShape {
  /// The gradient to apply to active dividers
  final LinearGradient gradient;

  /// Base size for dividers
  final double dividerRadius;

  /// Whether to use gradient only for active dividers
  final bool useGradientOnlyForActive;

  /// Color for inactive dividers when not using gradient
  final Color inactiveDividerColor;

  GradientCircularDividerShape({
    required this.gradient,
    this.dividerRadius = 6.0,
    this.useGradientOnlyForActive = true,
    this.inactiveDividerColor =
        const Color(0x4DFFFFFF), // Default semi-transparent white
  });

  @override
  void paint(PaintingContext context, Offset center, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection}) {
    final Canvas canvas = context.canvas;

    bool isActive = false;

    // For regular slider
    if (thumbCenter != null) {
      final bool isRtl = textDirection == TextDirection.rtl;
      isActive =
          isRtl ? center.dx >= thumbCenter.dx : center.dx <= thumbCenter.dx;
    }

    // Adjust radius based on active state
    final double radius = isActive
        ? themeData.activeDividerRadius ?? 0.0
        : themeData.inactiveDividerRadius ?? 0.0;

    // Create shader from gradient for the divider
    final Rect dividerRect =
        Rect.fromCircle(center: center, radius: dividerRadius);

    final Paint dividerPaint = Paint()..style = PaintingStyle.fill;

    if (isActive || !useGradientOnlyForActive) {
      // Use gradient for active dividers (or all if useGradientOnlyForActive is false)
      dividerPaint.shader = gradient.createShader(dividerRect);
    } else {
      // Use solid color for inactive dividers
      dividerPaint.color = inactiveDividerColor;
    }

    // Draw divider
    canvas.drawCircle(center, radius, dividerPaint);
  }
}

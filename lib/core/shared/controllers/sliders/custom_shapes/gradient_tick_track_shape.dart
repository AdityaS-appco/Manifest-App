import 'package:manifest/helper/import.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// Custom track shape with gradient for the purple slider
class GradientTickTrackShape extends SfTrackShape {
  final LinearGradient gradient;
  final double trackHeight;
  final double thumbRadius;
  final double thumbBorderPadding;

  GradientTickTrackShape({
    required this.gradient,
    this.trackHeight = 20.0,
    this.thumbRadius = 8.0,
    this.thumbBorderPadding = 2.0,
  });

  @override
  void paint(PaintingContext context, Offset offset, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
      SfRangeValues? currentValues,
      required SfSliderThemeData themeData,
      dynamic currentValue,
      required Animation<double> enableAnimation,
      required Paint? inactivePaint,
      required Paint? activePaint,
      required TextDirection textDirection}) {
    // For regular slider (not range), we need to handle the case
    final Offset actualThumbCenter = endThumbCenter ?? thumbCenter ?? offset;

    // Calculate track position
    final double trackVerticalCenter = offset.dy + parentBox.size.height / 2;

    // Full track rectangle (background)
    final Rect trackRect = Rect.fromLTWH(
      offset.dx,
      trackVerticalCenter - trackHeight / 2,
      parentBox.size.width,
      trackHeight,
    );

    // Draw inactive track (background)
    final Paint inactiveTrackPaint = Paint()
      ..color = AppColors.inactiveTrackColor
      ..style = PaintingStyle.fill;

    // Draw rounded rectangle for inactive track
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, Radius.circular(trackHeight / 2)),
      inactiveTrackPaint,
    );

    // Active track rectangle (with gradient)
    final bool isRtl = textDirection == TextDirection.rtl;
    final double activeStart = offset.dx;
    final double activeEnd = isRtl
        ? parentBox.size.width -
            actualThumbCenter.dx +
            thumbRadius +
            thumbBorderPadding
        : actualThumbCenter.dx + thumbRadius + thumbBorderPadding;

    final Rect activeTrackRect = Rect.fromLTWH(
      activeStart,
      trackVerticalCenter - trackHeight / 2,
      activeEnd - activeStart,
      trackHeight,
    );

    // Create gradient shader for active track
    final Paint activeTrackPaint = Paint()
      ..shader = gradient.createShader(activeTrackRect)
      ..style = PaintingStyle.fill;

    // Draw active track with rounded corners
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
          activeTrackRect, Radius.circular(trackHeight / 2)),
      activeTrackPaint,
    );
  }
}

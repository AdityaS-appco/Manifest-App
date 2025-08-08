import 'package:manifest/helper/import.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// Custom track shape with gradient support
class GradientRectangularTrackShape extends SfTrackShape {
  final LinearGradient gradient;
  final double trackHeight;

  GradientRectangularTrackShape({
    required this.gradient,
    this.trackHeight = 6.0,
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
    final Offset actualThumbCenter = thumbCenter ?? offset;

    // Calculate track position
    final double trackVerticalCenter = offset.dy + parentBox.size.height / 2;

    // Full track rectangle (background)
    final Rect trackRect = Rect.fromLTWH(
      offset.dx,
      trackVerticalCenter - trackHeight * 2,
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
        ? parentBox.size.width - actualThumbCenter.dx
        : actualThumbCenter.dx;

    final Rect activeTrackRect = Rect.fromLTWH(
      activeStart,
      trackVerticalCenter - trackHeight * 2,
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

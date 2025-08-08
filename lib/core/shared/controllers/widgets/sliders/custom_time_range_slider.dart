import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

// Custom track shape with gradient support
class GradientRectangularTrackShape extends SfTrackShape {
  final LinearGradient gradient;
  final double trackHeight;

  GradientRectangularTrackShape({
    required this.gradient,
    this.trackHeight = 12.0,
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
    if (startThumbCenter == null || endThumbCenter == null) return;

    // Calculate track vertical center position
    // This is the key change to align the track with the thumbs
    final double trackVerticalCenter = offset.dy + 4;

    final Rect trackRect = Rect.fromLTWH(
      offset.dx,
      trackVerticalCenter - trackHeight / 2, // Center the track vertically
      parentBox.size.width,
      trackHeight,
    );

    // Inactive track (background)
    final Paint inactiveTrackPaint = Paint()
      ..color = themeData.inactiveTrackColor ?? Colors.grey.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw inactive track with rounded corners
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, Radius.circular(trackHeight / 4)),
      inactiveTrackPaint,
    );

    // Active track rectangle (with gradient)
    final double activeStart = startThumbCenter.dx;
    final double activeEnd = endThumbCenter.dx;

    if (activeEnd > activeStart) {
      final Rect activeTrackRect = Rect.fromLTWH(
        activeStart,
        trackVerticalCenter -
            trackHeight / 2, // Center the active track vertically
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
}

class CustomTimeRangeSlider extends StatelessWidget {
  final double? min;
  final double? max;
  final SfRangeValues values;
  final ValueChanged<SfRangeValues> onChanged;
  final LinearGradient? activeGradient;
  final Color? inactiveColor;
  final Color? thumbColor;
  final double trackHeight;

  const CustomTimeRangeSlider({
    Key? key,
    this.min,
    this.max,
    required this.values,
    required this.onChanged,
    this.activeGradient,
    this.inactiveColor,
    this.thumbColor,
    this.trackHeight = 6.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRangeSliderTheme(
      data: SfRangeSliderThemeData(
        activeTrackHeight: trackHeight,
        inactiveTrackHeight: trackHeight,
        thumbRadius: 12,
        thumbColor: thumbColor ?? Colors.white,
        inactiveTrackColor: inactiveColor ?? Colors.white.withOpacity(0.1),
        overlayRadius: 20,
      ),
      child: SfRangeSlider(
        min: min ?? 0,
        max: max ?? 24 * 60 - 1, // 24 hours in minutes
        values: values,
        interval: 3,
        minorTicksPerInterval: 1,
        thumbShape: const SfThumbShape(),
        onChanged: onChanged,
        trackShape: GradientRectangularTrackShape(
          gradient: activeGradient ??
              const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 183, 143, 251),
                  Color.fromARGB(255, 116, 44, 255),
                ],
              ),
          trackHeight: trackHeight,
        ),
      ),
    );
  }
}

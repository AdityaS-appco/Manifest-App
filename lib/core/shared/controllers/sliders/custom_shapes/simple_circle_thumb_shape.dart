import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// Simple white circle thumb shape with border padding
class SimpleCircleThumbShape extends SfThumbShape {
  /// Radius of the thumb
  final double radius;

  /// Elevation of the thumb
  final double elevation;

  /// Border padding around the thumb
  final double borderPadding;

  /// Creates a simple circle thumb shape
  const SimpleCircleThumbShape({
    this.radius = 8.0,
    this.elevation = 0.0,
    this.borderPadding = 2.0,
  });

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    final Canvas canvas = context.canvas;

    // Draw outer circle (border/padding)
    final Paint outerPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius + borderPadding, outerPaint);

    // Draw shadow if elevation is greater than 0
    if (elevation > 0) {
      final Path shadowPath = Path()
        ..addOval(Rect.fromCircle(center: center, radius: radius));

      canvas.drawShadow(shadowPath, Colors.black, elevation, true);
    }

    // Draw the white circle
    final Paint thumbPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, thumbPaint);
  }
}

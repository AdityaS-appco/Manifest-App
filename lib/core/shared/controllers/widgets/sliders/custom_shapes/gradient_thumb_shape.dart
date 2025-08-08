import 'package:manifest/helper/import.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// Custom thumb shape with gradient support
class GradientThumbShape extends SfThumbShape {
  final double radius;
  final LinearGradient gradient;
  final double? elevation;
  final Color? shadowColor;

  const GradientThumbShape({
    this.radius = 10.0,
    required this.gradient,
    this.elevation = 2.0,
    this.shadowColor,
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

    // Draw shadow
    if (elevation != null && elevation! > 0) {
      final Path shadowPath = Path()
        ..addOval(Rect.fromCircle(center: center, radius: radius));

      canvas.drawShadow(
        shadowPath,
        shadowColor ?? Colors.black.withOpacity(0.3),
        elevation!,
        true,
      );
    }

    // Create gradient for thumb
    final Rect thumbRect = Rect.fromCircle(center: center, radius: radius);
    final Paint thumbPaint = Paint()
      ..shader = gradient.createShader(thumbRect)
      ..style = PaintingStyle.fill;

    // Draw thumb
    canvas.drawCircle(center, radius, thumbPaint);

    // // Draw border
    // final Paint borderPaint = Paint()
    //   ..color = Colors.white.withOpacity(0.5)
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 1.0;

    // canvas.drawCircle(center, radius, borderPaint);
  }
}
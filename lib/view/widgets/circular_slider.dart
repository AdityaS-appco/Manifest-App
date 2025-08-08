import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'dart:math' as math;


class CircularSliderWidget extends StatelessWidget {
  const CircularSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SleekCircularSlider(
          initialValue: 35, // Initial value
          max: 100, // Maximum value
          appearance: CircularSliderAppearance(
            customColors: CustomSliderColors(

              progressBarColors:
              [const Color.fromRGBO(222, 122, 243, 1),
                const Color.fromRGBO(255, 226, 153, 1),
                const Color.fromRGBO(222, 122, 243, 1),
                const Color.fromRGBO(158, 145, 230, 1),
                const Color.fromRGBO(129, 74, 255, 1),],
              trackColor: Colors.grey,
            ),
            customWidths: CustomSliderWidths(
              handlerSize: 0.0,
              progressBarWidth: 22, // Set progress bar width
              trackWidth: 22, // Set track width
              shadowWidth: 0, // Set shadow width
            ),
            size: 200, // Set the slider's size
            startAngle: 180, // Set the starting angle
            angleRange: 0, // Set the angle range
            infoProperties: InfoProperties(
              // Customize label style
              bottomLabelStyle: const TextStyle(fontSize: 24, color: Colors.blue),

              modifier: (double value) {
                // Display value as a percentage
                return '${value.toStringAsFixed(0)}%';
              },
            ),
            spinnerMode: false, // Disable spinner mode
            animationEnabled: true, // Enable animation
          ),
          onChange: (double value) {
            // Handle value change here
          },
        ),
      ),
    );
  }
}




class CircularProgressBar extends StatelessWidget {
  final double progress;
  final Color color;
  final double strokeWidth;
  final List<Color> progressBarColors;
  final Color trackColor;

  const CircularProgressBar({super.key, 
    this.progress = 0.5,
    this.color = Colors.blue,
    this.strokeWidth = 8.0,
    this.progressBarColors = const [
      Color.fromRGBO(222, 122, 243, 1),
      Color.fromRGBO(255, 226, 153, 1),
      Color.fromRGBO(222, 122, 243, 1),
      Color.fromRGBO(158, 145, 230, 1),
      Color.fromRGBO(129, 74, 255, 1),
    ],
    this.trackColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularProgressBarPainter(
        progress: progress,
        color: color,
        strokeWidth: strokeWidth,
        progressBarColors: progressBarColors,
        trackColor: trackColor,
      ),
      size: const Size.square(200),
    );
  }
}

class _CircularProgressBarPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final List<Color> progressBarColors;
  final Color trackColor;

  _CircularProgressBarPainter({
    this.progress = 0.0,
    this.color = Colors.blue,
    this.strokeWidth = 8.0,
    this.progressBarColors = const [
      Color.fromRGBO(222, 122, 243, 1),
      Color.fromRGBO(255, 226, 153, 1),
      Color.fromRGBO(222, 122, 243, 1),
      Color.fromRGBO(158, 145, 230, 1),
      Color.fromRGBO(129, 74, 255, 1),
    ],
    this.trackColor = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = math.min(centerX, centerY) - strokeWidth / 2;

    const double startAngle = math.pi; // Start angle is 180 degrees
    final double sweepAngle = math.pi * progress; // Sweep angle is proportional to progress

    // Draw the track
    paint.color = trackColor;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      0,
      math.pi * 2,
      false,
      paint,
    );

    // Draw the progress arc
    paint.color = getColor(progress);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  Color getColor(double progress) {
    if (progress < 0.2) {
      return progressBarColors[0];
    } else if (progress < 0.4) {
      return progressBarColors[1];
    } else if (progress < 0.6) {
      return progressBarColors[2];
    } else if (progress < 0.8) {
      return progressBarColors[3];
    } else {
      return progressBarColors[4];
    }
  }

  @override
  bool shouldRepaint(_CircularProgressBarPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.progressBarColors != progressBarColors ||
        oldDelegate.trackColor != trackColor;
  }
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressBar(
            progress: 0.7, // Update the progress value here
            color: Colors.green,
            strokeWidth: 12.0,
          ),
        ),
      ),
    );
  }
}
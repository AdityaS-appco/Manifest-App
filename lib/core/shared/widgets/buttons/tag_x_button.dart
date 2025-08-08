import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifest/core/constants/assets/icons_constants.dart';

/// A custom close button with the exact shape from the provided path
class TagXButton extends StatelessWidget {
  const TagXButton({
    Key? key,
    this.backgroundColor = Colors.white,
    this.backgroundOpacity = 0.05,
    this.iconColor = const Color(0xFFFF6B6B),
    this.svgPath,
    this.borderColor = Colors.white,
    this.borderOpacity = 0.05,
    this.borderWidth = 1.0,
    this.splashColor,
    this.highlightColor,
    this.width = 40,
    this.height = 30,
    required this.onTap,
  }) : super(key: key);

  /// Background color of the button
  final Color backgroundColor;

  /// Opacity of the background fill
  final double backgroundOpacity;

  /// Color of the X icon
  final Color iconColor;

  /// Optional custom SVG path for the icon
  final String? svgPath;

  /// Color of the border
  final Color borderColor;

  /// Opacity of the border
  final double borderOpacity;

  /// Width of the border
  final double borderWidth;

  /// Splash color for the button tap effect
  final Color? splashColor;

  /// Highlight color for the button press effect
  final Color? highlightColor;

  /// Width of the button
  final double width;

  /// Height of the button
  final double height;

  /// Callback when button is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: Stack(
        children: [
          // The custom painted shape
          CustomPaint(
            size: Size(width.w, height.h),
            painter: ButtonShapePainter(
              backgroundColor: backgroundColor,
              backgroundOpacity: backgroundOpacity,
              borderColor: borderColor,
              borderOpacity: borderOpacity,
              borderWidth: borderWidth,
            ),
          ),

          // Transparent material for ink effects
          Material(
            color: Colors.transparent,
            // Custom shape for the ink response
            shape: ButtonBorder(),
            child: InkWell(
              splashColor: splashColor ?? Colors.white.withOpacity(0.1),
              highlightColor: highlightColor ?? Colors.transparent,
              onTap: onTap,
              // Ensure ink stays within the button shape
              customBorder: ButtonBorder(),
              // Center the icon
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SvgPicture.asset(
                    svgPath ?? IconAllConstants.xClose,
                    color: iconColor,
                    width: 20.r,
                    height: 20.r,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter that draws the button shape using the exact path provided
class ButtonShapePainter extends CustomPainter {
  final Color backgroundColor;
  final double backgroundOpacity;
  final Color borderColor;
  final double borderOpacity;
  final double borderWidth;

  ButtonShapePainter({
    required this.backgroundColor,
    required this.backgroundOpacity,
    required this.borderColor,
    required this.borderOpacity,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Background path
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2450333, size.height * 0.05448500);
    path_0.cubicTo(size.width * 0.2638700, size.height * 0.02023483,
        size.width * 0.2938200, 0, size.width * 0.3256750, 0);
    path_0.lineTo(size.width * 0.9000000, 0);
    path_0.cubicTo(size.width * 0.9552275, 0, size.width,
        size.height * 0.05969533, size.width, size.height * 0.1333333);
    path_0.lineTo(size.width, size.height * 0.8666667);
    path_0.cubicTo(size.width, size.height * 0.9403033, size.width * 0.9552275,
        size.height, size.width * 0.9000000, size.height);
    path_0.lineTo(size.width * 0.3256750, size.height);
    path_0.cubicTo(
        size.width * 0.2938200,
        size.height,
        size.width * 0.2638700,
        size.height * 0.9797667,
        size.width * 0.2450333,
        size.height * 0.9455167);
    path_0.lineTo(size.width * 0.04336675, size.height * 0.5788500);
    path_0.cubicTo(
        size.width * 0.01755400,
        size.height * 0.5319167,
        size.width * 0.01755400,
        size.height * 0.4680833,
        size.width * 0.04336675,
        size.height * 0.4211500);
    path_0.lineTo(size.width * 0.2450333, size.height * 0.05448500);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = backgroundColor.withOpacity(backgroundOpacity);
    canvas.drawPath(path_0, paint0Fill);

    // Border path
    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3256825, size.height * 0.01666667);
    path_1.lineTo(size.width * 0.9000000, size.height * 0.01666667);
    path_1.cubicTo(
        size.width * 0.9483250,
        size.height * 0.01666667,
        size.width * 0.9875000,
        size.height * 0.06890000,
        size.width * 0.9875000,
        size.height * 0.1333333);
    path_1.lineTo(size.width * 0.9875000, size.height * 0.8666667);
    path_1.cubicTo(
        size.width * 0.9875000,
        size.height * 0.9311000,
        size.width * 0.9483250,
        size.height * 0.9833333,
        size.width * 0.9000000,
        size.height * 0.9833333);
    path_1.lineTo(size.width * 0.3256825, size.height * 0.9833333);
    path_1.cubicTo(
        size.width * 0.2995575,
        size.height * 0.9833333,
        size.width * 0.2748875,
        size.height * 0.9677767,
        size.width * 0.2583250,
        size.height * 0.9411467);
    path_1.lineTo(size.width * 0.2551025, size.height * 0.9356433);
    path_1.lineTo(size.width * 0.05344250, size.height * 0.5689767);
    path_1.cubicTo(
        size.width * 0.03227250,
        size.height * 0.5304767,
        size.width * 0.03095625,
        size.height * 0.4789867,
        size.width * 0.04948725,
        size.height * 0.4388667);
    path_1.lineTo(size.width * 0.05344250, size.height * 0.4310233);
    path_1.lineTo(size.width * 0.2551025, size.height * 0.06435533);
    path_1.cubicTo(
        size.width * 0.2705525,
        size.height * 0.03626333,
        size.width * 0.2945575,
        size.height * 0.01892047,
        size.width * 0.3204600,
        size.height * 0.01686197);
    path_1.lineTo(size.width * 0.3256825, size.height * 0.01666667);
    path_1.close();

    Paint paint1Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    paint1Stroke.color = borderColor.withOpacity(borderOpacity);
    canvas.drawPath(path_1, paint1Stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// Custom shape border for the ink effect
class ButtonBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getButtonPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getButtonPath(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // No painting needed
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }

  Path _getButtonPath(Rect rect) {
    final Size size = Size(rect.width, rect.height);

    Path path = Path();
    path.moveTo(size.width * 0.2450333, size.height * 0.05448500);
    path.cubicTo(size.width * 0.2638700, size.height * 0.02023483,
        size.width * 0.2938200, 0, size.width * 0.3256750, 0);
    path.lineTo(size.width * 0.9000000, 0);
    path.cubicTo(size.width * 0.9552275, 0, size.width,
        size.height * 0.05969533, size.width, size.height * 0.1333333);
    path.lineTo(size.width, size.height * 0.8666667);
    path.cubicTo(size.width, size.height * 0.9403033, size.width * 0.9552275,
        size.height, size.width * 0.9000000, size.height);
    path.lineTo(size.width * 0.3256750, size.height);
    path.cubicTo(
        size.width * 0.2938200,
        size.height,
        size.width * 0.2638700,
        size.height * 0.9797667,
        size.width * 0.2450333,
        size.height * 0.9455167);
    path.lineTo(size.width * 0.04336675, size.height * 0.5788500);
    path.cubicTo(
        size.width * 0.01755400,
        size.height * 0.5319167,
        size.width * 0.01755400,
        size.height * 0.4680833,
        size.width * 0.04336675,
        size.height * 0.4211500);
    path.lineTo(size.width * 0.2450333, size.height * 0.05448500);
    path.close();

    return path.shift(rect.topLeft);
  }
}

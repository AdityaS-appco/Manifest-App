// lib/views/half_circle_progress.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/view/widgets/arc_progress_widget/arc_progress_widget/arc_custome_paint.dart';
import 'package:manifest/view/widgets/arc_progress_widget/arc_progress_widget_controller/arc_progress_controller.dart';


class HalfCircleProgress extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;
  final Widget? child; // Optional widget to display inside the half-circle

  const HalfCircleProgress({
    Key? key,
    this.size = 200.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.strokeWidth = 10.0,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the controller
    final ProgressController controller = Get.put(ProgressController());

    return SizedBox(
      width: size,
      height: size / 2 + strokeWidth, // Adjust height for stroke
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Arc
          CustomPaint(
            size: Size(size, size / 2 + strokeWidth),
            painter: HalfCircleProgressPainter(
              progress: 1.0, // Full background arc
              backgroundColor: backgroundColor,
              progressColor: backgroundColor, // Same as background
              strokeWidth: strokeWidth,
            ),
          ),
          // Progress Arc
          Obx(() {
            return CustomPaint(
              size: Size(size, size / 2 + strokeWidth),
              painter: HalfCircleProgressPainter(
                progress: controller.progress.value,
                backgroundColor: backgroundColor,
                progressColor: progressColor,
                strokeWidth: strokeWidth,
              ),
            );
          }),
          if (child != null)
            Positioned(
              bottom: 0,
              child: child!,
            ),
        ],
      ),
    );
  }
}

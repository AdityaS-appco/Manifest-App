import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/helper/import.dart';

class GradientProgressBar extends StatelessWidget {
  const GradientProgressBar({
    super.key,
    this.gradient,
    this.gradientColors,
    this.gradientBegin,
    this.gradientEnd,
    required this.progress,
    this.height = 4,
    this.borderRadius = 8,
  });

  final Gradient? gradient;
  final List<Color>? gradientColors;
  final AlignmentGeometry? gradientBegin;
  final AlignmentGeometry? gradientEnd;
  final double progress;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.maxWidth,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: constraints.maxWidth,
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: ShapeDecoration(
                  gradient: gradient ??
                      LinearGradient(
                        colors: gradientColors ?? AppColors.rainbowGradient,
                        begin: gradientBegin ?? Alignment.centerLeft,
                        end: gradientEnd ?? Alignment.centerRight,
                      ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

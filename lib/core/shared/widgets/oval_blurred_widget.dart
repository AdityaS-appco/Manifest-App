import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/helper/import.dart';

class OvalBlurredWidget extends StatelessWidget {
  const OvalBlurredWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -113,
          left: 26,
          child: Center(
            child: Opacity(
              opacity: 0.5,
              child: Container(
                width: 342,
                height: 342,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(-0.00, 0.38),
                    end: const Alignment(1.00, 0.40),
                    colors: AppColors.screenOvalRainbowGradient,
                  ),
                  shape: const OvalBorder(),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -113,
          child: Center(
            child: BlurContainer(
              blurAmount: 50,
              borderRadius: BorderRadius.circular(171),
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: 1000,
                  height: 1000,
                  decoration: const ShapeDecoration(
                    shape: OvalBorder(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

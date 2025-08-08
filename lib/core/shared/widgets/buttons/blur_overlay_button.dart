import 'package:manifest/core/shared/widgets/buttons/blur_button.dart';
import 'package:manifest/helper/import.dart';

class BlurOverlayButton extends StatelessWidget {
  const BlurOverlayButton({
    super.key,
    this.text,
    required this.onPressed,
    this.bottom = 16,
    this.left = 0,
    this.right = 0,
    this.top,
  });

  final String? text;
  final VoidCallback onPressed;
  final double? bottom;
  final double? right;
  final double? left;
  final double? top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      right: right,
      top: top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlurButton(
              text: text ?? 'Upload Audio',
              onPressed: onPressed,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12.5),
              backgroundColor: Colors.white.withOpacity(0.1),
              borderColor: Colors.white.withOpacity(0.1),
              radius: 50,
              textStyle: Get.appTextTheme.tileWithIconTitle.copyWith(
                fontSize: 15,
                height: 1,
                letterSpacing: 0.20,
              ),
              icon: IconAllConstants.upload02,
            ),
          ),
        ],
      ),
    );
  }
}

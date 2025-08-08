import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/helper/import.dart';

/// A reusable close button for dialogs and bottom sheets
class DialogCloseButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final EdgeInsets padding;

  const DialogCloseButton({
    Key? key,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.size = 24,
    this.padding = const EdgeInsets.all(5.5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding.r,
      child: SvgCircleButton(
        IconAllConstants.xClose,
        onPressed: onTap ?? () => Get.back(),
        iconSize: size.r,
        padding: padding.r,
        iconColor: Colors.white.withOpacity(0.3),
        enabledColor: backgroundColor ?? Colors.white.withOpacity(0.1),
      ),
    );
  }
}

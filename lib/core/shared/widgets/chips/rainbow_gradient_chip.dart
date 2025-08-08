import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/helper/import.dart';

class RainbowGradientChip extends StatelessWidget {
  const RainbowGradientChip(
    this.text, {
    this.style,
    this.iconPath,
    this.iconSize,
    this.iconColor,
    this.padding,
  });

  final String text;
  final String? iconPath;
  final double? iconSize;
  final Color? iconColor;
  final TextStyle? style;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // width: 51.w,
          // height: 22.h,
          padding: (padding ??
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2))
              .r,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColors.rainbowGradient),
              borderRadius: BorderRadius.circular(18.r), // Rounded corners
              border: Border.all(color: Colors.white.withOpacity(0.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (iconPath != null) ...[
                SvgPicture.asset(
                  iconPath!,
                  height: (iconSize ?? 12).r,
                  width: (iconSize ?? 12).r,
                  color: iconColor ?? Colors.white,
                ),
                6.width,
              ],
              Center(
                child: Text(
                  text,
                  style: style ??
                      Get.appTextTheme.bodyTiny.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/helper/import.dart';

enum IconAlignment { leading, trailing }

class PrimaryPageButton extends StatelessWidget {
  const PrimaryPageButton({
    required this.child,
    required this.onPressed,
    this.isEnabled = true,
    this.padding = const EdgeInsets.all(0),
    this.height,
    super.key,
    this.color,
  });

  factory PrimaryPageButton.text({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    bool isEnabled = true,
    Color? color,
    Color? textColor,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 16,
    ),
  }) {
    return PrimaryPageButton(
      key: key,
      onPressed: onPressed,
      isEnabled: isEnabled,
      padding: padding.r,
      color: color,
      child: Text(
        text,
        style: isEnabled
            ? Get.appTextTheme.buttonText.copyWith(color: textColor)
            : Get.appTextTheme.buttonInactiveText,
      ),
    );
  }

  factory PrimaryPageButton.icon({
    Key? key,
    required String text,
    IconData? icon,
    String? svgIcon,
    required VoidCallback onPressed,
    bool isEnabled = true,
    IconAlignment iconAlignment = IconAlignment.leading,
    EdgeInsets padding = const EdgeInsets.all(0),
    double? height,
    TextStyle? textStyle,
    double iconTextGap = 8,
    bool isSvgColored = false,
  }) {
    return PrimaryPageButton(
      key: key,
      onPressed: onPressed,
      isEnabled: isEnabled,
      padding: padding.r,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconAlignment == IconAlignment.leading) ...[
            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon,
                height: 20.r,
                width: 20.r,
                color: isSvgColored
                    ? null
                    : isEnabled
                        ? Colors.black
                        : Colors.white.withOpacity(0.2),
              )
            else if (icon != null)
              Icon(
                icon,
                size: 20,
                color: isEnabled ? Colors.black : Colors.white.withOpacity(0.2),
              ),
            iconTextGap.width,
          ],
          Text(
            text,
            style: textStyle ??
                Get.appTextTheme.buttonSmallText.copyWith(
                  color:
                      isEnabled ? Colors.black : Colors.white.withOpacity(0.2),
                ),
          ),
          if (iconAlignment == IconAlignment.trailing) ...[
            iconTextGap.width,
            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon,
                height: 18.r,
                width: 18.r,
                color: isSvgColored
                    ? null
                    : isEnabled
                        ? Colors.black
                        : Colors.white.withOpacity(0.2),
              )
            else if (icon != null)
              Icon(
                icon,
                size: 18.r,
                color: isEnabled ? Colors.black : Colors.white.withOpacity(0.2),
              ),
          ],
        ],
      ),
    );
  }

  final Widget child;
  final VoidCallback onPressed;
  final bool isEnabled;
  final EdgeInsetsGeometry padding;
  final double? height; // Declare height variable
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: height ?? 50,
      onPressed: isEnabled ? onPressed : null,
      color: color ?? (isEnabled ? Colors.white : const Color(0xFF282828)),
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(
          color: isEnabled
              ? Colors.white.withOpacity(0.1)
              : const Color(0xFF3E3E3E).withOpacity(0.1),
        ),
      ),
      elevation: 0,
      splashColor:
          isEnabled ? Colors.black.withOpacity(0.1) : Colors.transparent,
      highlightColor:
          isEnabled ? Colors.black.withOpacity(0.05) : Colors.transparent,
      child: child,
    );
  }
}

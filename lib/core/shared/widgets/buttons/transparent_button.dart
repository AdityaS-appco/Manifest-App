import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/helper/import.dart';

enum IconAlignment { leading, trailing }

class TransparentButton extends StatelessWidget {
  const TransparentButton({
    required this.child,
    required this.onPressed,
    this.isEnabled = true,
    this.padding = const EdgeInsets.all(0),
    this.height,
    super.key,
  });

  factory TransparentButton.text({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    bool isEnabled = true,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    double? height,
  }) {
    return TransparentButton(
      key: key,
      onPressed: onPressed,
      isEnabled: isEnabled,
      padding: padding,
      height: height,
      child: Text(
        text,
        style: helveticaPageTitleTextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          height: 1.25,
          color: isEnabled ? Colors.white : Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }

  factory TransparentButton.icon({
    Key? key,
    required String text,
    IconData? icon,
    String? svgIcon,
    required VoidCallback onPressed,
    bool isEnabled = true,
    IconAlignment iconAlignment = IconAlignment.leading,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    double? height,
    TextStyle? textStyle,
  }) {
    return TransparentButton(
      key: key,
      onPressed: onPressed,
      isEnabled: isEnabled,
      padding: padding,
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconAlignment == IconAlignment.leading) ...[
            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon,
                height: 20,
                width: 20,
                color: isEnabled ? Colors.white : Colors.white.withOpacity(0.2),
              )
            else if (icon != null)
              Icon(
                icon,
                size: 20,
                color: isEnabled ? Colors.white : Colors.white.withOpacity(0.2),
              ),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            textAlign: TextAlign.center,
            style: helveticaPageTitleTextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (iconAlignment == IconAlignment.trailing) ...[
            const SizedBox(width: 8),
            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon,
                height: 18.r,
                width: 18.r,
                color: isEnabled ? Colors.white : Colors.white.withOpacity(0.2),
              )
            else if (icon != null)
              Icon(
                icon,
                size: 18.r,
                color: isEnabled ? Colors.white : Colors.white.withOpacity(0.2),
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
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50.0),
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            borderRadius: BorderRadius.circular(50.0),
            splashColor:
                isEnabled ? Colors.white.withOpacity(0.1) : Colors.transparent,
            highlightColor:
                isEnabled ? Colors.white.withOpacity(0.05) : Colors.transparent,
            child: Ink(
              height: height ?? 30,
              padding: padding,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
 
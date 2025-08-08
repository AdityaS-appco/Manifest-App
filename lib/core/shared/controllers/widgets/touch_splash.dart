import 'package:manifest/helper/import.dart';

class TouchSplash extends StatelessWidget {
  const TouchSplash({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.splashColor,
    this.highlightColor,
    this.border,
    this.color,
    required this.onPressed,
    this.onLongPress,
    required this.child,
  });

  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? highlightColor;
  final Border? border;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius ?? BorderRadius.circular(50.0),
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        borderRadius: borderRadius ?? BorderRadius.circular(50.0),
        splashColor: splashColor ?? Colors.black.withOpacity(0.1),
        highlightColor: highlightColor ?? Colors.black.withOpacity(0.05),
        child: Ink(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius ?? BorderRadius.circular(50.0),
            border: border ??
                Border.all(
                  color: Colors.transparent,
                ),
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

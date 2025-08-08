import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/shared/widgets/touch_splash.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/import.dart';

class BlurButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double radius;
  final double borderWidth;
  final Color borderColor;
  final Color backgroundColor;
  final double backgroundOpacity;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final double blurAmount;
  final bool isEnabled;
  final String? icon;
  final double iconTextSpacing;
  final double iconSize;
  final Color? foregroundColor;

  const BlurButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.radius = 32.0,
    this.borderWidth = 1.0,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.backgroundOpacity = 0.05,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    this.blurAmount = 30.0,
    this.isEnabled = true,
    this.icon,
    this.iconTextSpacing = 8.0,
    this.iconSize = 20.0,
    this.foregroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Get.appTextTheme.bodySmall.copyWith(
      height: 1,
    );

    return TouchSplash(
      onPressed: isEnabled ? onPressed : () {},
      borderRadius: BorderRadius.circular(radius),
      splashColor: Colors.white.withOpacity(0.2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BlurContainer(
          child: Container(
            width: width?.w,
            padding: padding.r,
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(backgroundOpacity),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: borderColor.withOpacity(backgroundOpacity),
                width: borderWidth,
              ),
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  if (icon != null) ...[
                    SvgPicture.asset(
                      icon!,
                      width: (iconSize).r,
                      height: (iconSize).r,
                      color: foregroundColor,
                    ),
                    iconTextSpacing.width,
                  ],
                  Text(
                    text,
                    style: textStyle?.copyWith(color: foregroundColor) ??
                        defaultTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

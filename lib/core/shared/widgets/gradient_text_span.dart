import 'package:flutter/material.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/helper/import.dart';

class GradientTextSpan extends WidgetSpan {
  GradientTextSpan(
    String text, {
    double fontSize = 22,
    FontWeight fontWeight = FontWeight.w600,
    List<Color>? gradient,
    TextStyle? style,
  }) : super(
          baseline: TextBaseline.alphabetic,
          alignment: PlaceholderAlignment.baseline,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: gradient ?? AppColors.rainbowGradient,
              ).createShader(bounds);
            },
            child: Text(
              text,
              style: style ??
                  helveticaPageTitleTextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
            ),
          ),
        );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GradientTextSpan && super == other;
  }

  @override
  int get hashCode => super.hashCode;
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/shared/widgets/sliders/gradient_slider.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/constant.dart';

class VolumeSlider extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onChanged;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isStepper;
  final double minValue;
  final double maxValue;

  const VolumeSlider({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.isStepper = false,
    this.minValue = 0,
    this.maxValue = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bodyTextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        12.height,
        Row(
          children: [
            SvgPicture.asset(
              IconAllConstants.volumeMin,
              color: AppColors.light,
              height: 20.h,
              width: 20.w,
            ),
            8.width,
            Expanded(
              child: GradientSlider(
                value: value,
                min: minValue,
                max: maxValue,
                trackHeight: 4,
                thumbRadius: 8,
                thumbElevation: 2,
                trackGradient: LinearGradient(
                  colors: AppColors.topLightToBottomDarkPurpleGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                thumbGradient: LinearGradient(
                  colors: AppColors.topLightToBottomDarkPurpleGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                backgroundColor: Colors.white.withOpacity(0.2),
                onChanged: onChanged,
                showDividers: isStepper,
                interval: isStepper ? 1 : null,
              ),
            ),
            8.width,
            SvgPicture.asset(
              IconAllConstants.volumeMax,
              color: AppColors.light,
              height: 20.h,
              width: 20.w,
            ),
          ],
        ),
      ],
    );
  }
}

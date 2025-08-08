import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';

/// * A custom bottom sheet with sliver app bar support for collapsible headers
class CustomSliverBottomsheet extends StatelessWidget {
  const CustomSliverBottomsheet({
    Key? key,
    required this.slivers,
    this.collapsedAppBarHeight,
    this.expandedAppBarHeight,
    this.backgroundColor,
    this.isDismissible = true,
    this.showDragHandle = true,
    this.borderRadius,
    this.maxHeight,
    this.minHeight,
    this.onDismiss,
    this.blurAmount = 64.0,
    this.scrollController,
    this.gradientColors,
  }) : super(key: key);

  final List<Widget> slivers;
  final double? collapsedAppBarHeight;
  final double? expandedAppBarHeight;
  final Color? backgroundColor;
  final bool isDismissible;
  final bool showDragHandle;
  final BorderRadius? borderRadius;
  final double? maxHeight;
  final double? minHeight;
  final VoidCallback? onDismiss;
  final double blurAmount;
  final ScrollController? scrollController;
  final List<Color>? gradientColors;

  @override
  Widget build(BuildContext context) {
    // Calculate the max height of the bottom sheet
    final double calculatedMaxHeight = maxHeight ?? 0.9.sh;
    // Calculate the min height of the bottom sheet
    final double calculatedMinHeight = minHeight ?? 0.3.sh;

    return BlurContainer(
      blurAmount: blurAmount,
      borderRadius: borderRadius ??
          BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: calculatedMaxHeight,
          minHeight: calculatedMinHeight,
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius ??
              BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
          border: Border.all(
            width: 1,
            color: AppColors.light.withOpacity(0.1),
          ),
          gradient: LinearGradient(
            colors:
                (gradientColors)?.map((e) => e.withOpacity(0.2)).toList() ?? [],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            /// * Content with Slivers
            Positioned(
              child: CustomScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  ...slivers,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15.h, bottom: 30.h),
          width: 40.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ],
    );
  }
}

import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/core/shared/widgets/buttons/secondary_page_button.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';
import 'package:manifest/helper/import.dart';

/// A highly customizable bottom sheet widget that can be reused across the app
class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
    required this.body,
    this.title,
    this.titlePadding,
    this.titleStyle,
    this.titleAlignment = Alignment.centerLeft,
    this.hasBackButton = true,
    this.backButtonAlignment = Alignment.centerLeft,
    this.customHeader,
    this.backgroundColor,
    this.primaryButtonText,
    this.isPrimaryButtonEnabled = true,
    this.primaryButtonColor,
    this.primaryButtonTextColor,
    this.secondaryButtonText,
    this.isSecondaryButtonEnabled = true,
    this.secondaryButtonColor,
    this.secondaryButtonTextColor,
    this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.buttonsHorizontalPadding,
    this.isButtonEnabled = true,
    this.bottomPadding = 16.0,
    this.topPadding = 16.0,
    this.horizontalPadding = 16.0,
    this.isScrollable = true,
    this.isDismissible = true,
    this.showDragHandle = true,
    this.borderRadius,
    this.contentPadding,
    this.maxHeight,
    this.minHeight,
    this.onDismiss,
    this.blurAmount = 64.0,
    this.buttonsTopPadding,
    this.gradientColors,
  }) : super(key: key);

  final Widget body;
  final String? title;
  final EdgeInsets? titlePadding;
  final TextStyle? titleStyle;
  final Alignment titleAlignment;
  final bool hasBackButton;
  final Alignment backButtonAlignment;
  final Widget? customHeader;
  final Color? backgroundColor;
  final String? primaryButtonText;
  final bool isPrimaryButtonEnabled;
  final Color? primaryButtonColor;
  final Color? primaryButtonTextColor;
  final String? secondaryButtonText;
  final bool isSecondaryButtonEnabled;
  final Color? secondaryButtonColor;
  final Color? secondaryButtonTextColor;
  final VoidCallback? onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final double? buttonsHorizontalPadding;
  final bool isButtonEnabled;
  final double bottomPadding;
  final double topPadding;
  final double horizontalPadding;
  final bool isScrollable;
  final bool isDismissible;
  final bool showDragHandle;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final double? maxHeight;
  final double? minHeight;
  final VoidCallback? onDismiss;
  final double blurAmount;
  final double? buttonsTopPadding;
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
            // ! When applying backgroundColor then the blurRadius in other bottomsheet's gets effected.
            // color: backgroundColor,
            borderRadius: borderRadius ??
                BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
            gradient: gradientColors != null
                ? LinearGradient(
                    colors:
                        gradientColors!.map((e) => e.withOpacity(0.2)).toList(),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            border:
                Border.all(width: 1, color: AppColors.light.withOpacity(0.1))),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// * Drag Handle
              if (showDragHandle) _buildDragHandle(),

              /// * Header Section
              _buildHeader(context),

              /// * Content Section
              Flexible(
                child: Padding(
                  padding: contentPadding ??
                      EdgeInsets.symmetric(
                        horizontal: horizontalPadding.w,
                        vertical: 8.h,
                      ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: body,
                  ),
                ),
              ),

              /// * Buttons Section
              if (primaryButtonText != null || secondaryButtonText != null)
                _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    if (customHeader != null) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding.w,
          vertical: topPadding.h,
        ),
        child: customHeader!,
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: topPadding,
      ).r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back Button (if enabled)
          if (hasBackButton) ...[
            Align(
              alignment: backButtonAlignment,
              child: Transform.translate(
                offset: backButtonAlignment == Alignment.centerLeft
                    ? const Offset(-8, 0)
                    : const Offset(0, 0),
                child: TransparentSvgCircleButton(
                  IconAllConstants.arrowLeft,
                  iconSize: 24,
                  onPressed: () => Get.back(),
                  padding: const EdgeInsets.all(5.5).r,
                ),
              ),
            ),
            if (backButtonAlignment == Alignment.centerLeft) 12.width,
          ],

          // Title (if provided)
          if (title != null) ...[
            Container(
              padding:
                  (hasBackButton && backButtonAlignment == Alignment.centerLeft)
                      ? const EdgeInsets.only(left: (12.0 + 24)).r
                      : null,
              child: Align(
                alignment: titleAlignment,
                child: titlePadding != null
                    ? Padding(
                        padding: titlePadding!,
                        child: Text(
                          title!,
                          style:
                              titleStyle ?? Get.appTextTheme.titleLargeRounded,
                        ),
                      )
                    : Text(
                        title!,
                        textAlign: titleAlignment == Alignment.center
                            ? TextAlign.center
                            : TextAlign.start,
                        style: titleStyle ?? Get.appTextTheme.titleLargeRounded,
                      ),
              ),
            )
          ],
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: buttonsHorizontalPadding?.w ?? horizontalPadding.w,
        right: buttonsHorizontalPadding?.w ?? horizontalPadding.w,
        bottom: bottomPadding.h,
        top: buttonsTopPadding ?? 8.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// * Primary Button
          if (primaryButtonText != null)
            PrimaryPageButton.text(
              text: primaryButtonText!,
              isEnabled: isPrimaryButtonEnabled ?? isButtonEnabled,
              onPressed: onPrimaryButtonPressed ?? () => Get.back(),
              color: primaryButtonColor,
              textColor: primaryButtonTextColor,
            ),

          /// * Secondary Button (if provided)
          if (secondaryButtonText != null) ...[
            16.height,
            SecondaryPageButton.text(
              text: secondaryButtonText!,
              isEnabled: isSecondaryButtonEnabled ?? isButtonEnabled,
              onPressed: onSecondaryButtonPressed ?? () => Get.back(),
              color: secondaryButtonColor,
              textColor: secondaryButtonTextColor,
            ),
          ],
        ],
      ),
    );
  }
}

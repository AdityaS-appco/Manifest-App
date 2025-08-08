import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A highly customizable dialog widget that can be used throughout the app
class CustomDialog extends StatelessWidget {
  /// Main content of the dialog
  final Widget body;
  
  /// Optional title for the dialog
  final String? title;
  
  /// Style for the title text
  final TextStyle? titleStyle;
  
  /// Optional subtitle for the dialog
  final String? subtitle;
  
  /// Style for the subtitle text
  final TextStyle? subtitleStyle;
  
  /// Whether to show a close button
  final bool hasCloseButton;
  
  /// Position of the close button
  final Alignment closeButtonAlignment;
  
  /// Background color of the dialog
  final Color? backgroundColor;
  
  /// Primary button text (if any)
  final String? primaryButtonText;
  
  /// Secondary button text (if any)
  final String? secondaryButtonText;
  
  /// Callback for primary button
  final VoidCallback? onPrimaryButtonPressed;
  
  /// Callback for secondary button
  final VoidCallback? onSecondaryButtonPressed;
  
  /// Whether the primary button is enabled
  final bool isPrimaryButtonEnabled;
  
  /// Whether the dialog is dismissible by tapping outside
  final bool isDismissible;
  
  /// Border radius for the dialog
  final BorderRadius? borderRadius;
  
  /// Content padding
  final EdgeInsetsGeometry contentPadding;
  
  /// Dialog margin
  final EdgeInsetsGeometry margin;
  
  /// Whether to show a drag handle at the top
  final bool showDragHandle;
  
  /// Whether the content should be scrollable
  final bool isScrollable;
  
  /// Optional width constraint for the dialog
  final double? width;
  
  /// Optional height constraint for the dialog
  final double? height;
  
  /// Optional maximum width constraint
  final double? maxWidth;
  
  /// Optional maximum height constraint
  final double? maxHeight;
  
  /// Optional widget to display above the title
  final Widget? headerWidget;
  
  /// Optional widget to display at the bottom (instead of buttons)
  final Widget? footerWidget;
  
  /// Whether to apply a blur effect to the background
  final bool blurBackground;
  
  /// Blur intensity when blurBackground is true
  final double blurAmount;

  const CustomDialog({
    Key? key,
    required this.body,
    this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.hasCloseButton = true,
    this.closeButtonAlignment = Alignment.topRight,
    this.backgroundColor,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.isPrimaryButtonEnabled = true,
    this.isDismissible = true,
    this.borderRadius,
    this.contentPadding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
    this.showDragHandle = false,
    this.isScrollable = true,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.headerWidget,
    this.footerWidget,
    this.blurBackground = false,
    this.blurAmount = 5.0,
  }) : super(key: key);
  
  /// Helper method to show the dialog
  static Future<T?> show<T>({
    required Widget body,
    String? title,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subtitleStyle,
    bool hasCloseButton = true,
    Alignment closeButtonAlignment = Alignment.topRight,
    Color? backgroundColor,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryButtonPressed,
    VoidCallback? onSecondaryButtonPressed,
    bool isPrimaryButtonEnabled = true,
    bool isDismissible = true,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(16.0),
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
    bool showDragHandle = false,
    bool isScrollable = true,
    double? width,
    double? height,
    double? maxWidth,
    double? maxHeight,
    Widget? headerWidget,
    Widget? footerWidget,
    bool blurBackground = false,
    double blurAmount = 5.0,
  }) {
    return Get.dialog<T>(
      CustomDialog(
        body: body,
        title: title,
        titleStyle: titleStyle,
        subtitle: subtitle,
        subtitleStyle: subtitleStyle,
        hasCloseButton: hasCloseButton,
        closeButtonAlignment: closeButtonAlignment,
        backgroundColor: backgroundColor,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryButtonPressed: onPrimaryButtonPressed,
        onSecondaryButtonPressed: onSecondaryButtonPressed,
        isPrimaryButtonEnabled: isPrimaryButtonEnabled,
        isDismissible: isDismissible,
        borderRadius: borderRadius,
        contentPadding: contentPadding,
        margin: margin,
        showDragHandle: showDragHandle,
        isScrollable: isScrollable,
        width: width,
        height: height,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        headerWidget: headerWidget,
        footerWidget: footerWidget,
        blurBackground: blurBackground,
        blurAmount: blurAmount,
      ),
      barrierDismissible: isDismissible,
    );
  }
  
  /// Helper method to show the dialog with a blurred background
  static Future<T?> showBlurred<T>({
    required Widget body,
    String? title,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subtitleStyle,
    bool hasCloseButton = true,
    Alignment closeButtonAlignment = Alignment.topRight,
    Color? backgroundColor,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryButtonPressed,
    VoidCallback? onSecondaryButtonPressed,
    bool isPrimaryButtonEnabled = true,
    bool isDismissible = true,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(16.0),
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
    bool showDragHandle = false,
    bool isScrollable = true,
    double? width,
    double? height,
    double? maxWidth,
    double? maxHeight,
    Widget? headerWidget,
    Widget? footerWidget,
    double blurAmount = 10.0,
  }) {
    return show(
      body: body,
      title: title,
      titleStyle: titleStyle,
      subtitle: subtitle,
      subtitleStyle: subtitleStyle,
      hasCloseButton: hasCloseButton,
      closeButtonAlignment: closeButtonAlignment,
      backgroundColor: backgroundColor,
      primaryButtonText: primaryButtonText,
      secondaryButtonText: secondaryButtonText,
      onPrimaryButtonPressed: onPrimaryButtonPressed,
      onSecondaryButtonPressed: onSecondaryButtonPressed,
      isPrimaryButtonEnabled: isPrimaryButtonEnabled,
      isDismissible: isDismissible,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      margin: margin,
      showDragHandle: showDragHandle,
      isScrollable: isScrollable,
      width: width,
      height: height,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      headerWidget: headerWidget,
      footerWidget: footerWidget,
      blurBackground: true,
      blurAmount: blurAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialogContent = _buildDialogContent(context);

    // If blur is requested, wrap the dialog in a backdrop filter
    if (blurBackground) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: dialogContent,
      );
    }

    return dialogContent;
  }

  Widget _buildDialogContent(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: margin.resolve(TextDirection.ltr),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? MediaQuery.of(context).size.width,
          maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.85,
          minWidth: width ?? 0,
          minHeight: height ?? 0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xff1d2125),
            borderRadius: borderRadius ?? BorderRadius.circular(20.r),
          ),
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(20.r),
            child: _buildDialogLayout(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogLayout(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Drag handle (if enabled)
        if (showDragHandle) _buildDragHandle(),
        
        // Header widget (if provided)
        if (headerWidget != null) headerWidget!,
        
        // Title and subtitle section
        if (title != null || subtitle != null) _buildHeaderSection(),
        
        // Main content
        isScrollable
            ? Flexible(
                child: SingleChildScrollView(
                  padding: contentPadding,
                  physics: const BouncingScrollPhysics(),
                  child: body,
                ),
              )
            : Padding(
                padding: contentPadding,
                child: body,
              ),
        
        // Footer or buttons
        if (footerWidget != null)
          footerWidget!
        else if (primaryButtonText != null || secondaryButtonText != null)
          _buildButtonsSection(context),
      ],
    );
  }

  Widget _buildDragHandle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 16.h,
            bottom: subtitle != null ? 8.h : 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Padding(
                  padding: EdgeInsets.only(right: hasCloseButton ? 32.w : 0),
                  child: Text(
                    title!,
                    style: titleStyle ?? TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (subtitle != null) ...[
                SizedBox(height: 8.h),
                Text(
                  subtitle!,
                  style: subtitleStyle ?? TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ],
          ),
        ),
        
        // Close button
        if (hasCloseButton)
          Positioned(
            right: 8.w,
            top: 8.h,
            child: _buildCloseButton(),
          ),
      ],
    );
  }

  Widget _buildCloseButton() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.close,
            size: 18.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: Column(
        children: [
          if (primaryButtonText != null)
            _buildPrimaryButton(context),
          if (primaryButtonText != null && secondaryButtonText != null)
            SizedBox(height: 12.h),
          if (secondaryButtonText != null)
            _buildSecondaryButton(context),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isPrimaryButtonEnabled
            ? (onPrimaryButtonPressed ?? () => Get.back())
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          disabledBackgroundColor: Colors.grey.withOpacity(0.3),
          disabledForegroundColor: Colors.white.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        child: Text(
          primaryButtonText!,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onSecondaryButtonPressed ?? () => Get.back(),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white.withOpacity(0.5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        child: Text(
          secondaryButtonText!,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
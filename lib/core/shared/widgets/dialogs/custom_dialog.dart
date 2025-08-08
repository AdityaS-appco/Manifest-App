import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifest/core/theme/app_text_styles.dart';
import 'package:manifest/core/shared/widgets/buttons/blur_button.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/shared/widgets/dialogs/dialog_close_button.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/constant.dart';

/// A customizable dialog component that supports different visual styles
/// based on the designs shown in the images
class CustomDialog extends StatelessWidget {
  /// Optional title text for the dialog
  final String? title;

  /// Style for the title text
  final TextStyle? titleStyle;

  /// Optional subtitle/description text
  final String? subtitle;

  /// Style for the subtitle text
  final TextStyle? subtitleStyle;

  /// Main content widget of the dialog
  final Widget? content;

  /// Optional header widget (image, video, etc)
  final Widget? headerWidget;

  /// Whether to show the close button
  final bool hasCloseButton;

  /// Border color for the dialog
  final Color borderColor;

  /// Border opacity
  final double borderOpacity;

  /// Border width
  final double borderWidth;

  /// Border radius for the dialog
  final double borderRadius;

  /// Padding for the content area
  final EdgeInsets? contentPadding;

  /// Padding for the dialog inside
  final EdgeInsets? dialogInsidePadding;

  /// Blur amount when blur is enabled
  final double blurAmount;

  /// Optional dialog button text
  final String? dialogButtonText;

  /// Optional dialog button press callback
  final VoidCallback? onDialogButtonPressed;

  /// Padding for the title area
  final EdgeInsets? titlePadding;

  const CustomDialog({
    Key? key,
    this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.content,
    this.headerWidget,
    this.hasCloseButton = true,
    this.borderColor = Colors.white,
    this.borderOpacity = 0.1,
    this.borderWidth = 1.0,
    this.borderRadius = 20.0,
    this.contentPadding =
        const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 30),
    this.dialogInsidePadding,
    this.blurAmount = 30.0,
    this.dialogButtonText,
    this.onDialogButtonPressed,
    this.titlePadding, // Accepting titlePadding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Center(child: _buildDialogContainer()),
    );
  }

  Widget _buildDialogContainer() {
    return BlurContainer(
      blurAmount: blurAmount,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: dialogInsidePadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor.withOpacity(borderOpacity),
            width: borderWidth,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: _buildDialogLayout(),
        ),
      ),
    );
  }

  Widget _buildDialogLayout() {
    return Stack(
      children: [
        // Content
        Container(
          padding: contentPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (headerWidget != null)
                headerWidget!
              else
                const SizedBox(height: 50),
              if (title != null) ...[
                Padding(
                  padding: titlePadding ??
                      const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    title!,
                    style: Get.appTextTheme.dialogTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              if (subtitle != null) ...[
                14.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    subtitle!,
                    style: Get.appTextTheme.dialogSubtitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              if (content != null) ...[
                20.height,
                content!,
              ],
              if (dialogButtonText != null &&
                  onDialogButtonPressed != null) ...[
                20.height,
                Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlurButton(
                        text: dialogButtonText!,
                        onPressed: onDialogButtonPressed!,
                        textStyle: Get.appTextTheme.dialogButtonText,
                        padding: const EdgeInsets.symmetric(horizontal: 30.5, vertical: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        // Close button
        if (hasCloseButton)
           Positioned(
            top: 15.5.h,
            right: 14.25.w,
            child: DialogCloseButton(),
          ),
      ],
    );
  }

  /// Helper method to show dialog
  static Future<T?> show<T>({
    String? title,
    String? subtitle,
    Widget? content,
    Widget? headerWidget,
    EdgeInsets? contentPadding,
    String? dialogButtonText,
    VoidCallback? onDialogButtonPressed,
    bool isDismissible = true,
    EdgeInsets? dialogInsidePadding,
    EdgeInsets? titlePadding, // Accepting titlePadding
  }) {
    return Get.dialog<T>(
      CustomDialog(
        headerWidget: headerWidget,
        title: title,
        subtitle: subtitle,
        content: content,
        contentPadding: contentPadding,
        dialogButtonText: dialogButtonText,
        onDialogButtonPressed: onDialogButtonPressed,
        dialogInsidePadding: dialogInsidePadding,
        titlePadding: titlePadding, // Passing titlePadding
      ),
      barrierDismissible: isDismissible,
      transitionCurve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}

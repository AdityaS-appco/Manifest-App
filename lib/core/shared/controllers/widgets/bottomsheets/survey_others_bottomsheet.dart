import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/utils/extensions/get_context.extension.dart';

/// A bottom sheet widget to collect information about how users found the app
class SurveyOthersBottomsheet extends StatelessWidget {
  final Function(String)? onSavePressed;

  const SurveyOthersBottomsheet({
    this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return CustomBottomSheet(
      title: "Tell us where did you find us",
      hasBackButton: true,
      primaryButtonText: "Save",
      horizontalPadding: 20,
      onPrimaryButtonPressed: () {
        Get.back();
        onSavePressed?.call(textController.text);
      },
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8).r,
            ),
            child: AppTextField(
              controller: textController,
              maxLines: 8,
              hintText: 'Write how did you find us',
            ),
          ),
        ],
      ),
    );
  }
}

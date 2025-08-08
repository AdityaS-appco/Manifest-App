import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/constant.dart';

class AppBottomSheet {
  static Future<void> show(Widget bottomSheet) async {
    await Get.bottomSheet(
      bottomSheet,
      isScrollControlled: true,
    );
  }

  static void showNamingBottomSheet({
    String? title,
    required String existingTitle,
    required Function(String) onConfirm,
  }) {
    final nameController = TextEditingController();
    show(
      Container(
        height: kSize.height * 0.88,
        width: kSize.width,
        decoration: const BoxDecoration(
          color: Color(0xff1d2125),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? 'Rename your track',
                  style: helveticaPageTitleTextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                32.height,
                TextField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  style: secondaryWhiteTextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: existingTitle,
                    hintStyle:
                        customTextStyle(fontSize: 16.0, color: greyColor),
                  ),
                ),
                32.height,
                OutlinedButton(
                  onPressed: () => onConfirm(nameController.text),
                  style: OutlinedButton.styleFrom(
                    // Ensure the button has transparent border color
                    side: const BorderSide(color: Colors.transparent),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 33.5.w,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: AlignmentDirectional.topEnd,
                        colors: [
                          Color(0xFFA28DF6),
                          Color(0xFF5B4A9F)
                        ], // Example gradient colors
                      ),
                      border: Border.all(color: Colors.transparent),
                      // Ensure border is transparent
                      borderRadius: BorderRadius.circular(
                          24), // You can adjust the radius as needed
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor: AppColors.light.withOpacity(0.1),
                  child: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.light,
                    ),
                    onPressed: () => Get.back(),
                  ),
                )),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.mediumGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ]), //singleChildScroll
        ), //Padding
      ),
    );
  }

  static void showWithDragHandler(Widget bottomSheet) {
    Get.bottomSheet(
      bottomSheet,
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      enterBottomSheetDuration: const Duration(milliseconds: 500),
      exitBottomSheetDuration: const Duration(milliseconds: 500),
    );
  }
}

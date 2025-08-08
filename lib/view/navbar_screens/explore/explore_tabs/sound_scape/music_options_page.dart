import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

import '../../../../../helper/icons_and_images_path.dart';

class MusicOptionsPage extends StatelessWidget {
  const MusicOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.musicBackground,
                        height: 150.0,
                        width: 150.0,
                      ),
                      12.height,
                      Text(
                        'MP3 1',
                        style: secondaryWhiteTextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      10.height,
                      Text(
                        '03:20',
                        style:
                            customTextStyle(fontSize: 16.0, color: greyColor),
                      ),
                    ],
                  )),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: showSvgIconWidget(iconPath: AppIcons.smallPlayButton),
                title: Text(
                  'Play Now',
                  style: secondaryWhiteTextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: kWhiteColor),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading:
                    showSvgIconWidget(iconPath: AppIcons.addToMySoundscape),
                title: Text(
                  'Add to my soundscape',
                  style: secondaryWhiteTextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: kWhiteColor),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: showSvgIconWidget(iconPath: AppIcons.renameMP3),
                title: Text(
                  'Rename MP3',
                  style: secondaryWhiteTextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: kWhiteColor),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: showSvgIconWidget(iconPath: AppIcons.deleteBin),
                title: Text(
                  'Delete MP3',
                  style: secondaryWhiteTextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: kWhiteColor),
                ),
              ),
              Gap(kSize.height * 0.2),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  'Close',
                  style: secondaryWhiteTextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: kWhiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/controllers/affirmation_controller.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/by_you/edit_by_you/edit_by_you.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/divider_widget.dart';

import '../../../../helper/icons_and_images_path.dart';
import '../../playlist/tabs/download/download_playlist_option.dart';

class Download extends StatelessWidget {
  const Download({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AffirmationController>(
        init: AffirmationController(),
        builder: (c) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: false,
              title: Text(
                'Downloads',
                style: appBarTitleTextStyle(
                    color: kWhiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.white, size: 18),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  customDivider(thickNess: 0.3),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      children: [
                        // const Gap(20),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: DummyData.dummyData.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const EditRecordedAffirmations(),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                                image: AssetImage(index == 4
                                                    ? AppImages.myCollection
                                                    : AppImages
                                                        .musicBackground),
                                                fit: BoxFit.cover)),
                                      ),
                                      const Gap(20),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            index == 1
                                                ? 'Heavenly Body'
                                                : index == 2
                                                    ? 'Good Times'
                                                    : 'Creative Mind ${index + 1}',
                                            style: secondaryWhiteTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            index == 4
                                                ? '100 affirmation 1:20:00'
                                                : '12 tracks',
                                            style: customTextStyle(
                                                color: descriptionLightColor,
                                                fontSize: 12),
                                          )
                                        ],
                                      )),
                                      GestureDetector(
                                          onTap: () {
                                            if (index == 4) {
                                              Get.to(() =>
                                                  const DownloadPlayListOptions());
                                            } else {
                                              Get.to(() =>
                                                  const EditRecordedAffirmations());
                                            }
                                          },
                                          child: Icon(
                                            index == 4
                                                ? Icons.more_vert
                                                : Icons
                                                    .arrow_forward_ios_outlined,
                                            size: 20,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        Gap(kSize.height * 0.12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/controllers/affirmation_controller.dart';
import 'package:manifest/view/widgets/divider_widget.dart';
import 'package:manifest/helper/import.dart';

class Recents extends StatelessWidget {
  const Recents({super.key});

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
                'Recents',
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
                        GridView.builder(
                          shrinkWrap: true,
                          scrollDirection:
                              Axis.vertical, // Change to vertical if needed
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                2, // Set the number of columns as needed
                            crossAxisSpacing:
                                kDefaultMargin, // Adjust spacing between columns
                            mainAxisSpacing:
                                kDefaultMargin, // Adjust spacing between rows
                            childAspectRatio:
                                0.7, // Adjust aspect ratio as needed
                          ),
                          itemCount: DummyData.dummyData.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = DummyData.dummyData[index];
                            return GestureDetector(
                              onTap: () {
                                if (index == 0) {
                                  // Get.to(() => const MyPlaylistDetailPage());
                                } else {
                                  // Get.to(() => const HomeMediaPlayer());
                                }
                              },
                              child: SizedBox(
                                width: 180, // Adjust width of each grid item
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: kSize.height * 0.20,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: item.imageUrl,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        if (index == 0)
                                          Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: cardColor),
                                              child: Center(
                                                child: Icon(
                                                  Icons.layers,
                                                  size: 16.0,
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item.title,
                                              style: secondaryWhiteTextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                            item.description,
                                            style: primaryWhiteTextStyle(
                                                fontSize: 13.0,
                                                color: Colors.white38,
                                                fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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

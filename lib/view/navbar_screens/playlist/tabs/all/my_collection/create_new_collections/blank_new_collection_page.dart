import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/create_new_collections/add_affirmations_to_collection.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/helper/import.dart';

import '../../../../../../../helper/icons_and_images_path.dart';

class NewCollectionPage extends StatelessWidget {
  final int? collectionID;

  const NewCollectionPage({this.collectionID,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.ios_share,
                color: kWhiteColor,
              ),
              padding: EdgeInsets.zero),
          IconButton(
              onPressed: () {
                // showModalBottomSheet(
                //   context: context,
                //   builder: (context) {
                //     return const PlayListMusicBottomSheet();
                //   },
                // );
              },
              icon: Icon(
                Icons.more_horiz,
                color: kWhiteColor,
              ),
              padding: EdgeInsets.zero),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: kSize.height * 0.30,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: CachedNetworkImage(
              imageUrl: DummyData.dummyData.last.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const Gap(25),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Text(
                    'New Collection',
                    style: customTextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: kWhiteColor),
                  ),
                  const Gap(10),
                  showSvgIconWidget(iconPath: AppIcons.edit)
                ],
              ),
            ),
          ),
          Gap(kSize.height * 0.06),
          Text(
            'Click on the add button to add new\n affirmations to the collection list',
            style: customTextStyle(fontSize: 16.0, color: lightGreyColor),
            textAlign: TextAlign.center,
          ),
          Gap(kSize.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: lightGreyColor, width: 1.0),
                ),
                child: Center(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(50),
                  onPressed: () {
                    Get.bottomSheet(
                      AddAffirmationsToCollections(createdCollectionID: collectionID),
                      isScrollControlled: true,
                      enableDrag: true,
                      enterBottomSheetDuration: const Duration(milliseconds: 500),
                    );
                  },
                  child: const Icon(Icons.add,color: Colors.white),
                )
                ),
              ),
              const Gap(15),
              Text(
                'Add',
                style: secondaryWhiteTextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

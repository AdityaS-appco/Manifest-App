import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

import '../../../../../../helper/dummy_data.dart';
import '../../../../../../helper/icons_and_images_path.dart';
import '../../../../../../helper/import.dart';


class NewPlayListPage extends StatelessWidget {
  const NewPlayListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PlaylistTabController c = Get.find<PlaylistTabController>();
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppIcons.backArrow)
        ),
        actions: [
          TextButton(onPressed: () {},
              child: Text('Edit',
                  style: customTextStyle(
                      letterSpacing: 0.2,
                      color: kWhiteColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700))),
          Icon(
            Icons.more_horiz,
            color: kWhiteColor,
          ),
          22.width,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                Text(
                  'New Playlist',
                  style: customTextStyle(
                      letterSpacing: 0.4,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: kWhiteColor),
                ),
                const Gap(10),
                showSvgIconWidget(iconPath: AppIcons.edit)
              ],
            ),
          ),
          Gap(kSize.height * 0.16),
          Text(
            'Click on the add button to add new\n track to the playlist',
            style: customTextStyle(
                fontSize: 16.0,
                color: descriptionColor,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4
            ),
            textAlign: TextAlign.center,
          ),
          24.height,
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
                        // Get.bottomSheet(
                        //   const AddTracksToPlaylist(),
                        //   isScrollControlled: true,
                        //   enableDrag: true,
                        //   enterBottomSheetDuration: const Duration(milliseconds: 500),
                        // );
                      },
                      child: const Icon(Icons.add,color: Colors.white),
                    )
                ),
              ),
              10.width,
              Text(
                'Add',
                style: customTextStyle(
                    color: kWhiteColor,
                    fontSize: 20.0,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

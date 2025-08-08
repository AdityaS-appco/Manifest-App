import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/helper/import.dart';

import '../../../../../../helper/icons_and_images_path.dart';

class PlayListMusicBottomSheet extends StatelessWidget {
  const PlayListMusicBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 8.0,
        sigmaY: 8.0,
      ),
      child: Container(
        height: kSize.height * 0.62,
        width: kSize.width,
        decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ListTile(
                        onTap: () {},
                        leading: SizedBox(
                            height: 60,
                            width: 60,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(7.0),
                                    child: Image.asset(
                                      AppImages.musicBackground,
                                      fit: BoxFit.cover,
                                      colorBlendMode: BlendMode.darken,
                                      color: Colors.black45,
                                    )),
                              ],
                            )),
                        title: Text(
                          'I am in charge of my Life',
                          style: secondaryWhiteTextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '6 tracks | 8:10:15',
                          style:
                              customTextStyle(fontSize: 16.0, color: greyColor),
                        ),
                      ),
                    ),
                    const Gap(20),
                    ListTile(
                      leading: const Icon(
                        Icons.ios_share,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      title: Text(
                        'Share',
                        style: secondaryWhiteTextStyle(),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.file_download_outlined,
                        color: lightGreyColor,
                        size: 30.0,
                      ),
                      title: Text(
                        'Download',
                        style: secondaryWhiteTextStyle(),
                      ),
                    ),
                    ListTile(
                      leading: showSvgIconWidget(iconPath: AppIcons.addMusic),
                      title: Text(
                        'Add to another playlist',
                        style: secondaryWhiteTextStyle(),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.favorite_border,
                        size: 30.0,
                        color: kWhiteColor,
                      ),
                      title: Text(
                        'Add to favorite playlist',
                        style: secondaryWhiteTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff394239),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: kWhiteColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: mediumGrey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ]), //Stack
          ), //singleChildScroll
        ), //Padding
      ),
    ); //Container
  }
}

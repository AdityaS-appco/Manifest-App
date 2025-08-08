// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:manifest/controllers/home_controller_two.dart';
// import 'package:manifest/view/widgets/dots_wave_loading.dart';
// import 'package:manifest/helper/constant.dart';
// import 'package:manifest/view/navbar_screens/explore/explore_tabs/sound_scape/soundscape_premium_page.dart';
// import 'package:manifest/view/navbar_screens/home/models/home_data_model_by_alok.dart';
// import 'package:manifest/view/navbar_screens/home/media_player/home_media_player.dart';

// class PlaylistSection extends StatelessWidget {
//   final HomeTwoController controller;

//   const PlaylistSection({
//     required this.controller,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final containerHeight = controller.containerHeight.value;
//       final splitPoint = containerHeight / 2;

//       return Container(
//         decoration: BoxDecoration(
//           color: Colors.red,
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: controller.themeController.themeApply.value
//                 ? [
//                     controller.themeController.gradientOne,
//                     controller.themeController.gradientTwo,
//                   ]
//                 : [
//                     controller.themeController.gradientOne,
//                     controller.themeController.gradientTwo,
//                     controller.themeController.gradientThree,
//                     controller.themeController.gradientFour,
//                   ],
//           ),
//         ),
//         child: controller.homeDataModel.value.playList == null
//             ? const SizedBox()
//             : _buildPlaylistContent(splitPoint),
//       );
//     });
//   }

//   Widget _buildPlaylistContent(double splitPoint) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: controller.homeDataModel.value.playList?.length ?? 0,
//       itemBuilder: (context, index) {
//         final playlist = controller.homeDataModel.value.playList?[index];
//         const itemHeight = 75.0;
//         final itemPosition = index * itemHeight;
//         final textColor = itemPosition < splitPoint
//             ? controller.themeController.gradientOneText
//             : controller.themeController.gradientTwoText;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSectionHeader(playlist, textColor),
//             const SizedBox(height: 20),
//             _buildPlaylistGrid(playlist, textColor),
//           ],
//         );
//       },
//     ).paddingOnly(bottom: 38.0);
//   }

//   Widget _buildSectionHeader(PlayList? playlist, Color textColor) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           playlist?.type ?? '',
//           style: primaryWhiteHelveticaRoundedBoldTextStyle(
//             fontSize: 20.0,
//             color: textColor,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           'Savor mixed affirmations with music',
//           style: secondaryWhiteTextStyle(
//             fontSize: 13,
//             color: textColor,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ],
//     ).paddingOnly(left: kDefaultPadding);
//   }

//   Widget _buildPlaylistGrid(PlayList? playlist, Color textColor) {
//     return SizedBox(
//       height: kSize.height * 0.34,
//       child: ListView.builder(
//         padding: EdgeInsets.only(left: kDefaultPadding, right: 8.0),
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount: playlist?.tracks?.length ?? 0,
//         itemBuilder: (context, index) {
//           final track = playlist?.tracks?[index];
//           return _buildPlaylistItem(track, index, textColor);
//         },
//       ),
//     );
//   }

//   Widget _buildPlaylistItem(dynamic track, int index, Color textColor) {
//     return GestureDetector(
//       onTap: () {
//         index != 0
//             ? Get.bottomSheet(
//                 const SoundScapePremiumPage(),
//                 isScrollControlled: true,
//                 enableDrag: true,
//                 enterBottomSheetDuration: const Duration(milliseconds: 500),
//               )
//             : Get.to(() => HomeMediaPlayer(track));
//       },
//       child: Container(
//         margin: EdgeInsets.only(right: kDefaultMargin),
//         width: 272.w,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTrackImage(track, index),
//             const SizedBox(height: 12),
//             _buildTrackInfo(track, textColor),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTrackImage(dynamic track, int index) {
//     return Stack(
//       children: [
//         Container(
//           height: 183.h,
//           width: double.infinity,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
//           child: CachedNetworkImage(
//             imageUrl: track.image.toString(),
//             imageBuilder: (context, imageProvider) => Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 image: DecorationImage(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             placeholder: (context, url) => Center(child: dotsWaveLoading()),
//             errorWidget: (context, url, error) => const Icon(Icons.error),
//           ),
//         ),
//         if (index != 0)
//           Positioned(
//             top: 10,
//             right: 10,
//             child: Container(
//               height: 30,
//               width: 30,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: cardColor,
//               ),
//               child: const Center(
//                 child: Icon(
//                   Icons.lock,
//                   size: 16.0,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         Positioned(
//           bottom: 10,
//           left: 10,
//           child: Container(
//             height: 30,
//             decoration: BoxDecoration(
//               color: cardColor,
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.music_note_rounded,
//                       color: Colors.white,
//                       size: 15.0,
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       track.duration ?? '',
//                       style: primaryWhiteTextStyle(),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTrackInfo(dynamic track, Color textColor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           track.name ?? '',
//           style: primaryWhiteSFPRoundedRegularTextStyle(
//             fontWeight: FontWeight.w400,
//             color: textColor,
//             fontSize: 17.0,
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         Text(
//           '${track.affirmationsCount ?? 0} Affirmations',
//           style: primaryWhiteTextStyle(
//             fontSize: 13.0,
//             color: textColor,
//             fontWeight: FontWeight.w400,
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         )
//       ],
//     );
//   }
// } 
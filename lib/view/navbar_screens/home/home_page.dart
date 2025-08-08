// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:manifest/controllers/profile_controller.dart';
// import 'package:manifest/features/notification/views/notifications_list_screen.dart';
// import 'package:manifest/helper/icons_and_images_path.dart';
// import 'package:manifest/view/navbar_screens/playlist/tabs/all/playlist/favorite_affirmations_playlist/favorite_playlist.dart';
// import 'package:manifest/view/widgets/dots_wave_loading.dart';
// import 'package:manifest/controllers/home_controller_two.dart';
// // import 'package:manifest/view/navbar_screens/explore/explore_tabs/sound_scape/soundscape_premium_page.dart';
// import 'package:manifest/view/navbar_screens/home/gift_page/gift_card_page.dart';
// import 'package:manifest/view/navbar_screens/home/media_player/home_media_player.dart';
// import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/my_collection_page.dart';
// import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
// import '../../../controllers/recent_played.dart';
// import 'scene_page/scene_settings.dart';

// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});
// //
// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }
// //
// // class _HomePageState extends State<HomePage> {
// //   bool isAppBarVisible = true;
// //   double topEleven = 0;
// //   bool isScrollingUp = false;
// //   bool isColorVisible = false;
// //   HomeTwoController c = Get.put(HomeTwoController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return LayoutBuilder(
// //         builder: (context, constraints)  {
// //           c.updateContainerHeight(constraints.maxHeight);
// //           return NotificationListener<ScrollNotification>(
// //             onNotification: (notify) {
// //               if (notify is ScrollUpdateNotification) {
// //                 if (notify.scrollDelta == null) return true;
// //                 if (notify.metrics.axis == Axis.vertical) {
// //                   setState(() {
// //                     if (notify.metrics.pixels > MediaQuery.of(context).size.height * 0.38) {
// //                       isAppBarVisible = false;
// //                     } else {
// //                       isAppBarVisible = true;
// //                     }
// //                     //
// //                     topEleven -= notify.scrollDelta! / 1;
// //                     if (notify.scrollDelta! >= 0) {
// //                       isScrollingUp = true;
// //                       isColorVisible = true;
// //                     } else {
// //                       isScrollingUp = false;
// //                       if (notify.metrics.pixels >= notify.metrics.extentTotal) {
// //                         isColorVisible = false;
// //                       } else {
// //                         Future.delayed(const Duration(milliseconds: 200), () {
// //                           setState(() {
// //                             isColorVisible = false;
// //                           });
// //                         });
// //                       }
// //                     }
// //                   });
// //                 }
// //               }
// //               return true;
// //             },
// //             child: Stack(
// //               children: [
// //                 SingleChildScrollView(
// //                   physics: const ClampingScrollPhysics(),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Obx(() => c.isLoading.value || c.homeModel.data == null
// //                           ? Center(child: dotsWaveLoading())
// //                           : Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           SizedBox(
// //                             height: kSize.height * 0.58,
// //                             child: Stack(
// //                               fit: StackFit.expand,
// //                               children: [
// //                                 Stack(
// //                                   children: [
// //                                     c.themeController.changedImage.isEmpty
// //                                         ? Container(
// //                                       decoration: const BoxDecoration(
// //                                         image: DecorationImage(
// //                                           image: AssetImage('assets/images/HomePage_image.jpeg'),
// //                                           // image: NetworkImage(DummyData.dummyData[0].imageUrl),
// //                                           fit: BoxFit.cover,
// //                                         ),
// //                                       ),
// //                                     )
// //                                         : CachedNetworkImage(
// //                                       imageUrl: c.themeController.changedImage.toString(),
// //                                       imageBuilder: (context, imageProvider) => Container(
// //                                         decoration: BoxDecoration(
// //                                           borderRadius: const BorderRadius.only(
// //                                               topLeft: Radius.circular(30.0),
// //                                               topRight: Radius.circular(30.0)),
// //                                           border: Border.all(width: 1,color: Colors.white),
// //                                           image: DecorationImage(
// //                                             image: imageProvider,
// //                                             fit: BoxFit.cover,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       placeholder: (context, url) => Center(child: dotsWaveLoading()),
// //                                       errorWidget: (context, url, error) => const Icon(Icons.error),
// //                                     ),
// //                                     Container(
// //                                       decoration: BoxDecoration(
// //                                         gradient: LinearGradient(
// //                                           begin: Alignment.topCenter,
// //                                           end: Alignment.bottomCenter,
// //                                           colors: [
// //                                             Colors.transparent,
// //                                             c.themeController.gradientOne,
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 Positioned(
// //                                   bottom: 4.0,
// //                                   left: 0.0,
// //                                   right: 0.0,
// //                                   child: Column(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                     children: [
// //                                       // User name and day
// //                                       RichText(
// //                                         textAlign: TextAlign.center,
// //                                         text: TextSpan(
// //                                           style: customTextStyle(color: lightGreyColor, fontSize: 20.0),
// //                                           children: <TextSpan>[
// //                                             TextSpan(
// //                                                 text: 'Good Morning,',
// //                                                 style: primaryWhiteSFPRoundedRegularTextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20.0, fontWeight: FontWeight.w400)),
// //                                             TextSpan(
// //                                               text: ' Leo 🌞',
// //                                               style: primaryWhiteHelveticaRoundedBoldTextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ),
// //                                       10.height,
// //                                       // Favorites and Collection Option
// //                                       Row(
// //                                         children: [
// //                                           Expanded(
// //                                             child: GestureDetector(
// //                                               onTap: () {Get.to(() => const FavoriteAffirmationPlaylist());},
// //                                               child: Container(
// //                                                 decoration: BoxDecoration(
// //                                                   border: Border.all(color:  const Color.fromRGBO(194, 194, 194, 0.5), strokeAlign: 0.2),
// //                                                   borderRadius: BorderRadius.circular(12.0),
// //                                                   color: const Color.fromRGBO(62, 60, 67, 0.2),
// //                                                 ),
// //                                                 child: Padding(
// //                                                   padding: const EdgeInsets.all(8.0),
// //                                                   child: Row(
// //                                                     children: [
// //                                                       CircleAvatar(
// //                                                         backgroundColor: c.themeController.gradientTwo,//const Color(0xFF74A5D5),
// //                                                         child: Icon(
// //                                                           Icons.favorite,
// //                                                           color: kWhiteColor,
// //                                                         ),
// //                                                       ),
// //                                                       10.width,
// //                                                       Text(
// //                                                         'My Favorites',
// //                                                         style: primaryWhiteTextStyle(fontSize: 13.0, fontWeight: FontWeight.w400),
// //                                                       )
// //                                                     ],
// //                                                   ),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                           17.width,
// //                                           Expanded(
// //                                             child: GestureDetector(
// //                                               onTap: () {Get.to(() => const MyCollectionPage(),);},
// //                                               child: Container(
// //                                                 decoration: BoxDecoration(
// //                                                   border: Border.all(color:  const Color.fromRGBO(194, 194, 194, 0.5), strokeAlign: 0.2),
// //                                                   borderRadius: BorderRadius.circular(12.0),
// //                                                   color: const Color.fromRGBO(62, 60, 67, 0.2),
// //                                                 ),
// //                                                 child: Padding(
// //                                                   padding: const EdgeInsets.all(8.0),
// //                                                   child: Row(
// //                                                     children: [
// //                                                       CircleAvatar(
// //                                                         backgroundColor: c.themeController.gradientTwo,//const Color(0xFF74A5D5),
// //                                                         child: Icon(
// //                                                           Icons.menu_book,
// //                                                           color: kWhiteColor,
// //                                                         ),
// //                                                       ),
// //                                                       10.width,
// //                                                       Text(
// //                                                         'My Collection',
// //                                                         style: primaryWhiteTextStyle(fontSize: 13.0, fontWeight: FontWeight.w400),
// //                                                       )
// //                                                     ],
// //                                                   ),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ],
// //                                   ).paddingSymmetric(horizontal: 16),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           Obx(() {
// //                             final containerHeight = c.containerHeight.value;
// //                             final splitPoint = containerHeight / 2;
// //                             return Container(
// //                               decoration: BoxDecoration(
// //                                 gradient: LinearGradient(
// //                                   begin: Alignment.topCenter,
// //                                   end: Alignment.bottomCenter,
// //                                   colors: [
// //                                     c.themeController.gradientOne,
// //                                     c.themeController.gradientTwo,
// //                                     // c.themeColors.gradientThree,
// //                                     // c.themeColors.gradientFour,
// //                                   ],
// //                                 ),
// //                               ),
// //                               child: ListView.builder(
// //                                 shrinkWrap: true,
// //                                 physics: const NeverScrollableScrollPhysics(),
// //                                 itemCount: c.homeModel.data!.length,
// //                                 itemBuilder: (context, index) {
// //                                   var item = c.homeModel.data![index];
// //                                   const itemHeight = 60.0; // Approximate height of each item
// //                                   final itemPosition = index * itemHeight;
// //                                   final textColor = itemPosition < splitPoint
// //                                       ? c.themeController.gradientOneText
// //                                       : c.themeController.gradientTwoText;
// //                                   if (item.playList!.isNotEmpty) {
// //                                     return Column(
// //                                       crossAxisAlignment:
// //                                       CrossAxisAlignment.start,
// //                                       children: [
// //                                         Column(
// //                                           mainAxisAlignment:
// //                                           MainAxisAlignment.start,
// //                                           crossAxisAlignment:
// //                                           CrossAxisAlignment.start,
// //                                           children: [
// //                                             Text(
// //                                               item.name.toString(),
// //                                               style: primaryWhiteHelveticaRoundedBoldTextStyle(
// //                                                   fontSize: 20.0,
// //                                                   color: textColor, //Colors.white,
// //                                                   fontWeight: FontWeight.w700
// //                                               ),
// //                                             ),
// //                                             6.height,
// //                                             Text(
// //                                               'Savor mixed affirmations with music',
// //                                               style: secondaryWhiteTextStyle(
// //                                                   fontSize: 13,
// //                                                   color: textColor,
// //                                                   //descriptionLightColor,
// //                                                   fontWeight: FontWeight.w400),
// //                                             ),
// //                                           ],
// //                                         ).paddingOnly(left: kDefaultPadding),
// //                                         20.height,
// //                                         SizedBox(
// //                                           height: kSize.height * 0.34,
// //                                           child: ListView.builder(
// //                                               padding: EdgeInsets.only(left: kDefaultPadding, right: 8.0),
// //                                               shrinkWrap: true,
// //                                               scrollDirection: Axis.horizontal,
// //                                               itemCount: item.playList!.length,
// //                                               itemBuilder: (BuildContext context, int index) {
// //                                                 var playList = item.playList![index];
// //                                                 return GestureDetector(
// //                                                   onTap: () {
// //                                                     index != 0
// //                                                         ? Get.bottomSheet(
// //                                                         const SoundScapePremiumPage(),
// //                                                         isScrollControlled: true,
// //                                                         enableDrag: true,
// //                                                         enterBottomSheetDuration: const Duration(milliseconds: 500))
// //                                                         : Get.to(() => HomeMediaPlayer(playList));
// //                                                   },
// //                                                   child: Container(
// //                                                     margin: EdgeInsets.only(
// //                                                         right: kDefaultMargin),
// //                                                     width: 272.w,
// //                                                     child: Column(
// //                                                       crossAxisAlignment:
// //                                                       CrossAxisAlignment.start,
// //                                                       children: [
// //                                                         Stack(
// //                                                           children: [
// //                                                             Container(
// //                                                               height: 183.h,
// //                                                               width: double.infinity,
// //                                                               decoration: BoxDecoration(
// //                                                                   borderRadius: BorderRadius.circular(12.0)),
// //                                                               child: CachedNetworkImage(
// //                                                                 imageUrl: playList.image.toString(),
// //                                                                 imageBuilder: (context, imageProvider) =>
// //                                                                     Container(
// //                                                                       decoration: BoxDecoration(
// //                                                                         borderRadius: BorderRadius.circular(15.0),
// //                                                                         image: DecorationImage(
// //                                                                           image: imageProvider,
// //                                                                           fit: BoxFit.cover,
// //                                                                         ),
// //                                                                       ),
// //                                                                     ),
// //                                                                 placeholder: (context, url) => Center(child: dotsWaveLoading()),
// //                                                                 errorWidget: (context, url, error) => const Icon(Icons.error),
// //                                                               ),
// //                                                             ),
// //                                                             if (index != 0)
// //                                                               Positioned(
// //                                                                   top: 10,
// //                                                                   right: 10,
// //                                                                   child: Container(
// //                                                                     height: 30,
// //                                                                     width: 30,
// //                                                                     decoration: BoxDecoration(shape: BoxShape.circle, color: cardColor),
// //                                                                     child: Center(
// //                                                                       child: Icon(
// //                                                                         Icons.lock,
// //                                                                         size: 16.0,
// //                                                                         color: kWhiteColor,
// //                                                                       ),
// //                                                                     ),
// //                                                                   )),
// //                                                             Positioned(
// //                                                                 bottom: 10,
// //                                                                 left: 10,
// //                                                                 child: Container(
// //                                                                   height: 30,
// //                                                                   decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(10.0)),
// //                                                                   child: Center(
// //                                                                     child: Padding(
// //                                                                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
// //                                                                       child: Row(
// //                                                                         children: [
// //                                                                           Icon(
// //                                                                             Icons.music_note_rounded,
// //                                                                             color: kWhiteColor,
// //                                                                             size: 15.0,
// //                                                                           ),
// //                                                                           10.width,
// //                                                                           Text(
// //                                                                             playList.playlistTimeDuration.toString(),
// //                                                                             style: primaryWhiteTextStyle(),
// //                                                                           )
// //                                                                         ],
// //                                                                       ),
// //                                                                     ),
// //                                                                   ),
// //                                                                 )
// //                                                             ),
// //                                                           ],
// //                                                         ),
// //                                                         12.height,
// //                                                         Column(
// //                                                           crossAxisAlignment: CrossAxisAlignment.start,
// //                                                           children: [
// //                                                             Text(
// //                                                               playList.name.toString(),
// //                                                               style: primaryWhiteSFPRoundedRegularTextStyle(
// //                                                                   fontWeight: FontWeight.w400,
// //                                                                   color: textColor,
// //                                                                   fontSize: 17.0
// //                                                               ),
// //                                                               maxLines: 1,
// //                                                               overflow: TextOverflow.ellipsis,
// //                                                             ),
// //                                                             Text(
// //                                                               playList.affirmations == null ?'0 Affirmations' : '${playList.affirmations!.length} Affirmations',
// //                                                               style: primaryWhiteTextStyle(
// //                                                                   fontSize: 13.0,
// //                                                                   color: textColor,
// //                                                                   //descriptionLightColor,
// //                                                                   fontWeight: FontWeight.w400
// //                                                               ),
// //                                                               maxLines: 1,
// //                                                               overflow: TextOverflow.ellipsis,
// //                                                             )
// //                                                           ],
// //                                                         ),
// //                                                       ],
// //                                                     ),
// //                                                   ),
// //                                                 );
// //                                               }),
// //                                         ),
// //                                       ],
// //                                     );
// //                                   } else {
// //                                     return const SizedBox();
// //                                   }
// //                                 },
// //                               ).paddingOnly(bottom: 38.0),
// //                             );
// //                           }
// //                           ),
// //                         ],
// //                       )),
// //                     ],
// //                   ),
// //                 ),
// //                 /// top App Bar
// //                 Visibility(
// //                   visible: isAppBarVisible,
// //                   child: SafeArea(
// //                     child: Row(
// //                       crossAxisAlignment: CrossAxisAlignment.end,
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         SvgPicture.asset(AppImages.homeTitleLogo),
// //                         Row(
// //                           children: [
// //                             showSvgIconWidget(
// //                                 iconPath: AppIcons.homeGift,
// //                                 onTap: () {
// //                                   Get.bottomSheet(
// //                                     const GiftCardPage(),
// //                                     isScrollControlled: true,
// //                                     enableDrag: true,
// //                                     enterBottomSheetDuration: const Duration(milliseconds: 600),
// //                                   );
// //                                 }),
// //                             20.width,
// //                             showSvgIconWidget(iconPath: AppIcons.homeNotification,
// //                                 page: const NotificationPage()
// //                             ),
// //                             20.width,
// //                             showSvgIconWidget(
// //                                 iconPath: AppIcons.homePaint,
// //                                 onTap: () {
// //                                   // Get.to(()=> VoicePage());
// //                                   Get.bottomSheet(
// //                                     const SceneSettings(),
// //                                     isScrollControlled: true,
// //                                     enableDrag: true,
// //                                     enterBottomSheetDuration: const Duration(milliseconds: 500),
// //                                   );
// //                                 }),
// //                             10.width,
// //                           ],
// //                         )
// //                       ],
// //                     ).paddingOnly(
// //                         left: kDefaultPadding,
// //                         right: kDefaultPadding,
// //                         bottom: 10
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         }
// //     );
// //   }
// // }
// class HomePage extends StatelessWidget {
//   HomePage({super.key});
//   HomeTwoController c = Get.find<HomeTwoController>();
//   final controller = Get.put(RecentTracksController());

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       c.updateContainerHeight(constraints.maxHeight);
//       return NotificationListener<ScrollNotification>(
//         onNotification: (notify) {
//           if (notify is ScrollUpdateNotification) {
//             if (notify.scrollDelta == null) return true;
//             if (notify.metrics.axis == Axis.vertical) {
//               c.updateAppBarVisibility(
//                 notify.metrics.pixels,
//                 MediaQuery.of(context).size.height,
//               );
//               c.updateScrollState(
//                 notify.scrollDelta!,
//                 notify.metrics.pixels,
//                 notify.metrics.extentTotal,
//               );
//             }
//           }
//           return true;
//         },
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               physics: const ClampingScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Obx(() => c.isLoading.value || c.homeModel.data == null
//                       ? Center(child: dotsWaveLoading())
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: kSize.height * 0.58,
//                               child: Stack(
//                                 fit: StackFit.expand,
//                                 children: [
//                                   Stack(
//                                     children: [
//                                       c.themeController.changedImage.isEmpty
//                                           ? Container(
//                                               decoration: const BoxDecoration(
//                                                 image: DecorationImage(
//                                                   image: AssetImage(
//                                                       'assets/images/HomePage_image.jpeg'),
//                                                   // image: NetworkImage(DummyData.dummyData[0].imageUrl),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             )
//                                           : CachedNetworkImage(
//                                               imageUrl: c
//                                                   .themeController.changedImage
//                                                   .toString(),
//                                               imageBuilder:
//                                                   (context, imageProvider) =>
//                                                       Container(
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       const BorderRadius.only(
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   30.0),
//                                                           topRight:
//                                                               Radius.circular(
//                                                                   30.0)),
//                                                   border: Border.all(
//                                                       width: 1,
//                                                       color: Colors.white),
//                                                   image: DecorationImage(
//                                                     image: imageProvider,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                               ),
//                                               placeholder: (context, url) =>
//                                                   Center(
//                                                       child: dotsWaveLoading()),
//                                               errorWidget:
//                                                   (context, url, error) =>
//                                                       const Icon(Icons.error),
//                                             ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           gradient: LinearGradient(
//                                             begin: Alignment.topCenter,
//                                             end: Alignment.bottomCenter,
//                                             colors: [
//                                               Colors.transparent,
//                                               c.themeController.gradientOne,
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Positioned(
//                                     bottom: 4.0,
//                                     left: 0.0,
//                                     right: 0.0,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         // User name and day
//                                         RichText(
//                                           textAlign: TextAlign.center,
//                                           text: TextSpan(
//                                             style: customTextStyle(
//                                                 color: lightGreyColor,
//                                                 fontSize: 20.0),
//                                             children: <TextSpan>[
//                                               TextSpan(
//                                                   text: AppStrings.goodMorning,
//                                                   style:
//                                                       primaryWhiteSFPRoundedRegularTextStyle(
//                                                           color: Colors.white
//                                                               .withOpacity(0.8),
//                                                           fontSize: 20.0,
//                                                           fontWeight:
//                                                               FontWeight.w400)),
//                                               TextSpan(
//                                                 text: "${Get.find<ProfileController>().profile?.name ?? ""} 🌞",
//                                                 style:
//                                                     primaryWhiteHelveticaRoundedBoldTextStyle(
//                                                         fontSize: 20.0,
//                                                         fontWeight:
//                                                             FontWeight.w700),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         10.height,
//                                         // Favorites and Collection Option
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   Get.to(() =>
//                                                       const FavoriteAffirmationPlaylist());
//                                                 },
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         color: const Color
//                                                             .fromRGBO(
//                                                             194, 194, 194, 0.5),
//                                                         strokeAlign: 0.2),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             12.0),
//                                                     color: const Color.fromRGBO(
//                                                         62, 60, 67, 0.2),
//                                                   ),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Row(
//                                                       children: [
//                                                         CircleAvatar(
//                                                           backgroundColor: c
//                                                                   .themeController
//                                                                   .themeApply
//                                                                   .value
//                                                               ? c.themeController
//                                                                   .gradientTwo
//                                                               : const Color(
//                                                                   0xFF74A5D5),
//                                                           child: Icon(
//                                                             Icons.favorite,
//                                                             color: kWhiteColor,
//                                                           ),
//                                                         ),
//                                                         10.width,
//                                                         Text(
//                                                           AppStrings.myFavorite,
//                                                           style:
//                                                               primaryWhiteTextStyle(
//                                                                   fontSize:
//                                                                       13.0,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             17.width,
//                                             Expanded(
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   Get.to(
//                                                       () =>
//                                                           const MyCollectionPage(),
//                                                       transition:
//                                                           Transition.cupertino);
//                                                 },
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         color: const Color
//                                                             .fromRGBO(
//                                                             194, 194, 194, 0.5),
//                                                         strokeAlign: 0.2),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             12.0),
//                                                     color: const Color.fromRGBO(
//                                                         62, 60, 67, 0.2),
//                                                   ),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Row(
//                                                       children: [
//                                                         CircleAvatar(
//                                                           backgroundColor: c
//                                                                   .themeController
//                                                                   .themeApply
//                                                                   .value
//                                                               ? c.themeController
//                                                                   .gradientTwo
//                                                               : const Color(
//                                                                   0xFF74A5D5),
//                                                           child: Icon(
//                                                             Icons.menu_book,
//                                                             color: kWhiteColor,
//                                                           ),
//                                                         ),
//                                                         10.width,
//                                                         Text(
//                                                           AppStrings
//                                                               .myCollection,
//                                                           style:
//                                                               primaryWhiteTextStyle(
//                                                                   fontSize:
//                                                                       13.0,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ).paddingSymmetric(horizontal: 16),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Obx(() {
//                               final containerHeight = c.containerHeight.value;
//                               final splitPoint = containerHeight / 2;
//                               return Container(
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     colors: c.themeController.themeApply.value
//                                         ? [
//                                             c.themeController.gradientOne,
//                                             c.themeController.gradientTwo,
//                                             // c.themeColors.gradientThree,
//                                             // c.themeColors.gradientFour,
//                                           ]
//                                         : [
//                                             c.themeController.gradientOne,
//                                             c.themeController.gradientTwo,
//                                             c.themeController.gradientThree,
//                                             c.themeController.gradientFour,
//                                           ],
//                                   ),
//                                 ),
//                                 child: ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: c.homeModel.data!.length,
//                                   itemBuilder: (context, index) {
//                                     var item = c.homeModel.data![index];
//                                     const itemHeight =
//                                         75.0; // Approximate height of each item
//                                     final itemPosition = index * itemHeight;
//                                     final textColor = itemPosition < splitPoint
//                                         ? c.themeController.gradientOneText
//                                         : c.themeController.gradientTwoText;
//                                     if (item.playList!.isNotEmpty) {
//                                       return Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 item.name.toString(),
//                                                 style:
//                                                     primaryWhiteHelveticaRoundedBoldTextStyle(
//                                                         fontSize: 20.0,
//                                                         color:
//                                                             textColor, //Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.w700),
//                                               ),
//                                               6.height,
//                                               Text(
//                                                 'Savor mixed affirmations with music',
//                                                 style: secondaryWhiteTextStyle(
//                                                     fontSize: 13,
//                                                     color: textColor,
//                                                     //descriptionLightColor,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                             ],
//                                           ).paddingOnly(left: kDefaultPadding),
//                                           20.height,
//                                           SizedBox(
//                                             height: kSize.height * 0.34,
//                                             child: item.playList == null
//                                                 ? ListView.builder(
//                                                     padding: EdgeInsets.only(
//                                                         left: kDefaultPadding,
//                                                         right: 8.0),
//                                                     shrinkWrap: true,
//                                                     scrollDirection:
//                                                         Axis.horizontal,
//                                                     itemCount:
//                                                         item.playList!.length,
//                                                     itemBuilder:
//                                                         (BuildContext context,
//                                                             int index) {
//                                                       var playList =
//                                                           item.playList![index];
//                                                       return GestureDetector(
//                                                         onTap: () {
//                                                           index != 0
//                                                               ? Get.bottomSheet(
//                                                                   SoundScapePremiumPage(),
//                                                                   isScrollControlled:
//                                                                       true,
//                                                                   enableDrag:
//                                                                       true,
//                                                                   enterBottomSheetDuration:
//                                                                       const Duration(
//                                                                           milliseconds:
//                                                                               500))
//                                                               : Get.to(() =>
//                                                                   HomeMediaPlayer(
//                                                                       playList));
//                                                         },
//                                                         child: Container(
//                                                           margin: EdgeInsets.only(
//                                                               right:
//                                                                   kDefaultMargin),
//                                                           width: 272.w,
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Stack(
//                                                                 children: [
//                                                                   Container(
//                                                                     height:
//                                                                         183.h,
//                                                                     width: double
//                                                                         .infinity,
//                                                                     decoration: BoxDecoration(
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(12.0)),
//                                                                     child:
//                                                                         CachedNetworkImage(
//                                                                       imageUrl: playList
//                                                                           .image
//                                                                           .toString(),
//                                                                       imageBuilder:
//                                                                           (context, imageProvider) =>
//                                                                               Container(
//                                                                         decoration:
//                                                                             BoxDecoration(
//                                                                           borderRadius:
//                                                                               BorderRadius.circular(15.0),
//                                                                           image:
//                                                                               DecorationImage(
//                                                                             image:
//                                                                                 imageProvider,
//                                                                             fit:
//                                                                                 BoxFit.cover,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       placeholder: (context,
//                                                                               url) =>
//                                                                           Center(
//                                                                               child: dotsWaveLoading()),
//                                                                       errorWidget: (context,
//                                                                               url,
//                                                                               error) =>
//                                                                           const Icon(
//                                                                               Icons.error),
//                                                                     ),
//                                                                   ),
//                                                                   if (index !=
//                                                                       0)
//                                                                     Positioned(
//                                                                         top: 10,
//                                                                         right:
//                                                                             10,
//                                                                         child:
//                                                                             Container(
//                                                                           height:
//                                                                               30,
//                                                                           width:
//                                                                               30,
//                                                                           decoration: BoxDecoration(
//                                                                               shape: BoxShape.circle,
//                                                                               color: cardColor),
//                                                                           child:
//                                                                               Center(
//                                                                             child:
//                                                                                 Icon(
//                                                                               Icons.lock,
//                                                                               size: 16.0,
//                                                                               color: kWhiteColor,
//                                                                             ),
//                                                                           ),
//                                                                         )),
//                                                                   Positioned(
//                                                                       bottom:
//                                                                           10,
//                                                                       left: 10,
//                                                                       child:
//                                                                           Container(
//                                                                         height:
//                                                                             30,
//                                                                         decoration: BoxDecoration(
//                                                                             color:
//                                                                                 cardColor,
//                                                                             borderRadius:
//                                                                                 BorderRadius.circular(10.0)),
//                                                                         child:
//                                                                             Center(
//                                                                           child:
//                                                                               Padding(
//                                                                             padding:
//                                                                                 const EdgeInsets.symmetric(horizontal: 10.0),
//                                                                             child:
//                                                                                 Row(
//                                                                               children: [
//                                                                                 Icon(
//                                                                                   Icons.music_note_rounded,
//                                                                                   color: kWhiteColor,
//                                                                                   size: 15.0,
//                                                                                 ),
//                                                                                 10.width,
//                                                                                 Text(
//                                                                                   playList.playlistTimeDuration.toString(),
//                                                                                   style: primaryWhiteTextStyle(),
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       )),
//                                                                 ],
//                                                               ),
//                                                               12.height,
//                                                               Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Text(
//                                                                     playList
//                                                                         .name
//                                                                         .toString(),
//                                                                     style: primaryWhiteSFPRoundedRegularTextStyle(
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w400,
//                                                                         color:
//                                                                             textColor,
//                                                                         fontSize:
//                                                                             17.0),
//                                                                     maxLines: 1,
//                                                                     overflow:
//                                                                         TextOverflow
//                                                                             .ellipsis,
//                                                                   ),
//                                                                   Text(
//                                                                     '${playList.affirmations!.length} Affirmations',
//                                                                     style: primaryWhiteTextStyle(
//                                                                         fontSize: 13.0,
//                                                                         color: textColor,
//                                                                         //descriptionLightColor,
//                                                                         fontWeight: FontWeight.w400),
//                                                                     maxLines: 1,
//                                                                     overflow:
//                                                                         TextOverflow
//                                                                             .ellipsis,
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       );
//                                                     })
//                                                 : const SizedBox(),
//                                           ),
//                                           Obx(() => controller
//                                                   .recentTracks.isEmpty
//                                               ? Center(
//                                                   child:
//                                                       Text('No recent tracks'))
//                                               : ListView.builder(
//                                                   itemCount: controller
//                                                       .recentTracks.length,
//                                                   itemBuilder:
//                                                       (context, index) {
//                                                     final track = controller
//                                                         .recentTracks[index];
//                                                     return ListTile(
//                                                       title: Text(
//                                                           'Track ${track.trackId}'),
//                                                       subtitle: Text(
//                                                           'Playlist: ${track.playlistId}'),
//                                                       trailing: Text(
//                                                         track.createdAt
//                                                                 ?.toString()
//                                                                 .split(
//                                                                     ' ')[0] ??
//                                                             '',
//                                                       ),
//                                                       onTap: () {
//                                                         // Handle track selection
//                                                       },
//                                                     );
//                                                   },
//                                                 )),
//                                         ],
//                                       );
//                                     } else {
//                                       return const SizedBox();
//                                     }
//                                   },
//                                 ).paddingOnly(bottom: 38.0),
//                               );
//                             }),
//                           ],
//                         )),
//                 ],
//               ),
//             ),

//             /// top App Bar
//             Obx(
//               () => Visibility(
//                 visible: c.isAppBarVisible.value,
//                 child: SafeArea(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SvgPicture.asset(AppImages.homeTitleLogo),
//                       Row(
//                         children: [
//                           showSvgIconWidget(
//                               iconPath: AppIcons.homeGift,
//                               onTap: () {
//                                 Get.bottomSheet(
//                                   const GiftCardPage(),
//                                   isScrollControlled: true,
//                                   enableDrag: true,
//                                   enterBottomSheetDuration:
//                                       const Duration(milliseconds: 600),
//                                 );
//                               }),
//                           20.width,
//                           showSvgIconWidget(
//                             iconPath: AppIcons.homeNotification,
//                             onTap: () => Get.to(
//                               /// todo: redirect to new notification list screen
//                               () => const NotificationsListScreen(),
//                               // () => const NotificationPage(),
//                               transition: Transition.cupertino,
//                             ),
//                           ),
//                           20.width,
//                           showSvgIconWidget(
//                               iconPath: AppIcons.homePaint,
//                               onTap: () {
//                                 // Get.to(()=> VoicePage());
//                                 Get.bottomSheet(
//                                   const SceneSettings(),
//                                   isScrollControlled: true,
//                                   enableDrag: true,
//                                   enterBottomSheetDuration:
//                                       const Duration(milliseconds: 500),
//                                 );
//                               }),
//                           10.width,
//                         ],
//                       )
//                     ],
//                   ).paddingOnly(
//                       left: kDefaultPadding,
//                       right: kDefaultPadding,
//                       bottom: 10),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:manifest/controllers/audio_controller.dart';
// import 'package:manifest/helper/constant.dart';
// import 'package:manifest/view/widgets/divider_widget.dart';
// import 'package:manifest/view/widgets/dots_wave_loading.dart';
// import 'package:manifest/controllers/explore_tab/explore_categories_controller.dart';
// import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

// import '../../../../helper/icons_and_images_path.dart';

// class PlaylistByIdExplore extends StatelessWidget {
//   const PlaylistByIdExplore({super.key,});

//   @override
//   Widget build(BuildContext context) {
//     ExploreCategoriesController c = Get.find<ExploreCategoriesController>();
//     return GetBuilder<AudioController>(
//       init: AudioController(),
//       builder: (audioController) {
//         return Container(
//           decoration: BoxDecoration(
//               gradient: AppGradients.grayToGray,
//             ),
//             child: Obx(() => c.isLoading.value || c.expPlaylistById.data == null
//               ? Center(child: dotsWaveLoading())
//               : Scaffold(
//                backgroundColor: Colors.transparent,
//                appBar: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0.0,
//                 leading: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.white,
//                     size: 16.0,
//                   ),
//                 ),
//                 actions: [
//                   showSvgIconWidget(iconPath: AppIcons.share),
//                   22.width,
//                   showSvgIconWidget(iconPath: AppIcons.addMusic),
//                   22.width
//                 ],
//                ),
//                // bottomSheet: Material(
//                //  shape: const RoundedRectangleBorder(
//                //    borderRadius: BorderRadius.zero,
//                //  ),
//                //  child: Container(
//                //    height: 68,
//                //    color: Colors.grey.shade700,
//                //    child: Padding(
//                //      padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                //      child: ListTile(
//                //        contentPadding: EdgeInsets.zero,
//                //        leading: SizedBox(
//                //          height: 44,
//                //          width: 44,
//                //          child: ClipRRect(
//                //              borderRadius: BorderRadius.circular(10.0),
//                //              child: Image.network(
//                //                DummyData.dummyData.first.imageUrl,
//                //                fit: BoxFit.cover,
//                //                errorBuilder: (context, error, stackTrace) {
//                //                  return Container(
//                //                    color: Colors.white70,
//                //                    child: Center(child: Icon(Icons.error,color: Colors.grey.shade600),),
//                //                  );
//                //                },
//                //              )),
//                //        ),
//                //        title: Text(
//                //          'MP3 1',
//                //          style: customTextStyle(
//                //              fontWeight: FontWeight.w400,
//                //              fontSize: 16.0,
//                //              letterSpacing: 0.4,
//                //              color: kWhiteColor
//                //          ),
//                //        ),
//                //        subtitle: Text('Artist Name', style: customTextStyle(
//                //            fontWeight: FontWeight.w400,
//                //            fontSize: 12.0,
//                //            letterSpacing: 0.4,
//                //            color: descriptionColor
//                //        ),),
//                //        trailing: GestureDetector(
//                //          onTap: () {
//                //            // Add your onTap logic here
//                //          },
//                //          child: Container(
//                //            decoration: BoxDecoration(
//                //              shape: BoxShape.circle,
//                //              color: kWhiteColor, // Change color as needed
//                //            ),
//                //            padding: const EdgeInsets.all(10),
//                //            child: Icon(
//                //              Icons.pause,
//                //              color: blackColor,
//                //              size: 25,
//                //            ),
//                //          ),
//                //        ),
//                //      ),
//                //    ),
//                //  ),
//                // ),
//                body: c.expPlaylistById.data!.tracks!.isNotEmpty
//                 ? ListView(
//                   children: [
//                   12.height,
//                   Container(
//                     height: kSize.height * 0.40,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(7.0),
//                         child: Image.network(
//                           c.expPlaylistById.data!.image.toString(),
//                           fit: BoxFit.cover,
//                           colorBlendMode: BlendMode.darken,
//                           color: Colors.black45,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               color: Colors.white70,
//                               child: Center(child: Icon(Icons.error,color: Colors.grey.shade600),),
//                             );
//                           },
//                         )
//                     ),
//                   ),
//                   22.height,
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           c.expPlaylistById.data!.name.toString(),
//                           style: customTextStyle(
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.w700,
//                               color: kWhiteColor),
//                         ),
//                         4.height,
//                         Text(
//                           '${c.expPlaylistById.data!.tracksCount.toString()} tracks | ${c.expPlaylistById.data!.tracksTotalDuration.toString()}',
//                           style: customTextStyle(
//                               fontSize: 13.0,
//                               color: descriptionColor,
//                               fontWeight: FontWeight.w400
//                           ),
//                         ),
//                         10.height,
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 40,
//                                   width: 40,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(500),
//                                     color: const Color.fromRGBO(37, 37, 37, 0.55),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: showSvgIconWidget(iconPath: AppIcons.stopWatch),
//                                   ),
//                                 ),
//                                 12.width,
//                                 Obx(() => Container(
//                                   height: 40,
//                                   width: 40,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(500),
//                                     color: audioController.isLoop.value == false
//                                         ? const Color.fromRGBO(37, 37, 37, 0.55)
//                                         : const Color.fromRGBO(169, 169, 169, 0.55),
//                                   ),
//                                   child: CupertinoButton(
//                                     onPressed: () {
//                                       if (audioController.isLoop.value == false) {
//                                         audioController.setLoop(true);
//                                         LogUtil.v('set loop true');
//                                       } else {
//                                         LogUtil.v('set loop false');
//                                         audioController.setLoop(false);
//                                       }
//                                     },
//                                     padding: EdgeInsets.zero,
//                                     child: showSvgIconWidget(iconPath: AppIcons.musicReplay),
//                                   ),
//                                 )),
//                                 12.width,
//                                 Container(
//                                   height: 40,
//                                   width: 40,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(500),
//                                     color: const Color.fromRGBO(37, 37, 37, 0.55),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: showSvgIconWidget(iconPath: AppIcons.favoriteOutline),
//                                   ),
//                                 ),
//                                 12.width,
//                                 Container(
//                                   height: 40,
//                                   width: 40,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(500),
//                                     color: const Color.fromRGBO(37, 37, 37, 0.55),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: showSvgIconWidget(iconPath: AppIcons.downloadPlay),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Obx(() => audioController.isPlayLoading.value == true
//                             ? const CircleAvatar(
//                               radius: 25.0,
//                               backgroundColor: Colors.white,
//                               child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 0.8,),)
//                             : audioController.isPlaying.value == false
//                             ? CircleAvatar(
//                               radius: 25.0,
//                               backgroundColor: kWhiteColor,
//                               child: IconButton(
//                                 onPressed: () {
//                                   if(audioController.isPlayListLoadDone.value == false){
//                                     List<String> subForm = c.expPlaylistById.data!.tracks!.map((item) => item.file.toString()).toList();
//                                     LogUtil.v('audio list $subForm');
//                                     audioController.setupAudioPlayerPlaylist(playlist: subForm);
//                                   }else{
//                                     audioController.playPlaylist();
//                                   }
//                                 },
//                                 icon: Icon(Icons.play_arrow, color: blackColor, size: 35),
//                               ),
//                             )
//                             : CircleAvatar(
//                               radius: 25.0,
//                               backgroundColor: kWhiteColor,
//                               child: IconButton(
//                                 onPressed: () {
//                                   audioController.pausePlaylist();
//                                 },
//                                 icon: Icon(Icons.pause, color: blackColor, size: 35),
//                               ),
//                             ))
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   20.height,
//                   customDivider(thickNess: 0.3),
//                   22.height,
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: kMaxMargin),
//                     child: Column(
//                       children: [
//                         ListView.builder(
//                             padding: EdgeInsets.only(bottom: 70.0.h),
//                             shrinkWrap: true,
//                             itemCount: c.expPlaylistById.data!.tracks!.length,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemBuilder: (BuildContext context, int index) {
//                               var item = c.expPlaylistById.data!.tracks![index];
//                               return ListTile(
//                                 contentPadding: EdgeInsets.zero,
//                                 leading: GestureDetector(
//                                   // onTap: () async {
//                                   //   audioController.audioFile = item.file.toString();
//                                   //   await audioController.isPlaying.value ? audioController.pauseAudio() : audioController.playAudio();
//                                   //   audioController.currentIndex.value = index;
//                                   // },
//                                   child: SizedBox(
//                                       height: 60,
//                                       width: 60,
//                                       child: Stack(
//                                         fit: StackFit.expand,
//                                         children: [
//                                           ClipRRect(
//                                               borderRadius: BorderRadius.circular(7.0),
//                                               child: Image.network(
//                                                 item.name.toString(),
//                                                 fit: BoxFit.cover,
//                                                 colorBlendMode: BlendMode.darken,
//                                                 color: Colors.black45,
//                                                 errorBuilder: (context, error, stackTrace) {
//                                                   return Container(
//                                                     color: Colors.white70,
//                                                     child: Center(child: Icon(Icons.error,color: Colors.grey.shade600),),
//                                                   );
//                                                 },
//                                               )),
//                                           Center(
//                                             child: Obx(() {
//                                               if (audioController.isSinglePlayLoading.value && audioController.audioFile == item.file.toString()) {
//                                                 // Show loading indicator if single audio is loading
//                                                 return const SizedBox(
//                                                     height: 35,
//                                                     width: 35,
//                                                     child: CircularProgressIndicator(color: Colors.white, strokeWidth: 0.8));
//                                               } else if (audioController.isPlaying.value && audioController.audioFile == item.file.toString()) {
//                                                 // Show playing indicator if single audio is playing
//                                                 return CircleAvatar(
//                                                   radius: 25.0,
//                                                   backgroundColor: Colors.transparent,
//                                                   child: IconButton(
//                                                     onPressed: () {
//                                                       audioController.pauseAudio();
//                                                     },
//                                                     icon: const Icon(Icons.pause, color: Colors.white, size: 35),
//                                                   ),
//                                                 );
//                                               } else {
//                                                 // Show play button if single audio is not loading or playing
//                                                 return CircleAvatar(
//                                                   radius: 25.0,
//                                                   backgroundColor: Colors.transparent,
//                                                   child: IconButton(
//                                                     onPressed: () {
//                                                       if (!audioController.isSinglePlayLoading.value) {
//                                                         if (audioController.audioFile == item.file.toString() && audioController.isPlaying.value) {
//                                                           audioController.pauseAudio();
//                                                         } else {
//                                                           audioController.audioFile = item.file.toString();
//                                                           audioController.playAudio();
//                                                         }
//                                                       }
//                                                     },
//                                                     icon: const Icon(Icons.play_arrow, color: CupertinoColors.white, size: 35),
//                                                   ),
//                                                 );
//                                               }
//                                             }),
//                                           ),
//                                           // Center(
//                                           //     child: Icon(
//                                           //         audioController.isPlaying.value && audioController.currentIndex.value == index
//                                           //             ? Icons.pause
//                                           //             : Icons.play_arrow, color: Colors.white,size: 30)
//                                           // )
//                                         ],
//                                       )),
//                                 ),
//                                 // Image.asset(AppImages.musicThumbnail),
//                                 title: Text(item.name.toString(),
//                                   style: customTextStyle(
//                                       fontSize: 15.0,
//                                       fontWeight: FontWeight.w400,
//                                       letterSpacing: 0.4,
//                                       color: kWhiteColor
//                                   ),
//                                 ),
//                                 subtitle: Text(item.trackDuration.toString(),
//                                   style: customTextStyle(
//                                       fontSize: 11.0,
//                                       fontWeight: FontWeight.w400,
//                                       letterSpacing: 0.4,
//                                       color: descriptionColor
//                                   ),
//                                 ),
//                               );
//                             }
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             : Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: [
//                    Container(
//                     height: kSize.height * 0.30,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     child: Container(
//                       height: kSize.height * 0.40,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15.0),
//                       ),
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(7.0),
//                           child: Image.network(
//                             c.expPlaylistById.data!.image.toString(),
//                             fit: BoxFit.cover,
//                             colorBlendMode: BlendMode.darken,
//                             color: Colors.black45,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 color: Colors.white70,
//                                 child: Center(child: Icon(Icons.error,color: Colors.grey.shade600),),
//                               );
//                             },
//                           )
//                       ),
//                     ),
//                   ),
//                    const Gap(25),
//                    Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 22),
//                     child: Row(
//                       children: [
//                         Text(
//                           '${c.expPlaylistById.data!.name}',
//                           style: customTextStyle(
//                               letterSpacing: 0.4,
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.w700,
//                               color: kWhiteColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                    Gap(kSize.height * 0.16),
//                    Text(
//                     'playlist is empty',
//                     style: customTextStyle(
//                         fontSize: 16.0,
//                         color: descriptionColor,
//                         fontWeight: FontWeight.w400,
//                         letterSpacing: 0.4
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           )
//         );
//       }
//     );
//   }
// }

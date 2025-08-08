import 'package:flutter/cupertino.dart';
import 'package:manifest/core/shared/widgets/custom_search_widget.dart';
import 'package:manifest/models/playlist_tab_model/favorite_tracks_playlist_model/favorite_tracks_playlist_model.dart'
    as playlist;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import '../../../../../../../controllers/playList_tab/playlist_tab_controller.dart';
import '../../../../../../../features/explore/controllers/playlist_details_controller.dart';
import '../../../../../../../features/media_player/controllers/media_player_controller.dart';
import '../../../../../../../features/media_player/media_player_screen.dart';
import '../../../../../../../helper/import.dart';

TextEditingController searchController = TextEditingController();

class FavoriteTracksPage extends StatefulWidget {
  const FavoriteTracksPage({super.key});

  @override
  _FavoriteTracksPageState createState() => _FavoriteTracksPageState();
}

class _FavoriteTracksPageState extends State<FavoriteTracksPage> {
  final PlaylistTabController playlistTabController =
      Get.find<PlaylistTabController>();
  final PlaylistDetailsController controller =
      Get.find<PlaylistDetailsController>();

  List<playlist.Data> filteredData = [];

  @override
  void initState() {
    super.initState();
    // filteredData = List.from(playlistTabController.favoriteTracks.data ?? []);
  }

  void _onSearchChanged(String query) {
    // setState(() {
    //   filteredData = searchProducts(
    //     productList: playlistTabController.favoriteTracks.data ?? [],
    //     query: query,
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBG,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildFavoriteTracksList()),
        ],
      ),
    );
  }

  BoxDecoration _buildBackgroundGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Get.find<ThemeController>().gradientOne,
          Get.find<ThemeController>().gradientTwo,
          Get.find<ThemeController>().gradientThree,
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBG,
      elevation: 0,
      centerTitle: false,
      leading: CupertinoButton(
        onPressed: () => Navigator.pop(context),
        padding: EdgeInsets.zero,
        child:
            const Icon(Icons.arrow_back_ios, color: Colors.white, size: 16.0),
      ),
      title: Text(
        "Favorite Tracks",
        style: customTextStyle(
          color: kWhiteColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: CustomSearchWidget(
        controller: searchController,
        onSearchChanged: _onSearchChanged,
        hintText: 'Search favorite tracks...',
      ),
    );
  }

  Widget _buildFavoriteTracksList() {
    return Obx(
      () {
        if (playlistTabController.isFavoriteTrackLoading.value) {
          return _buildLoadingIndicator();
        }

        if (filteredData.isEmpty) {
          return _buildNoDataWidget();
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          shrinkWrap: true,
          itemCount: filteredData.length,
                    physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final item = filteredData[index];
            return _buildTrackItem(item);
          },
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.white,
        size: 60,
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Text(
        "No data found",
        style: customTextStyle(
            fontWeight: FontWeight.w500, fontSize: 15, color: descriptionColor),
      ),
    );
  }

  Widget _buildTrackItem(playlist.Data item) {
    return GestureDetector(
      onTap: () async {
        await controller.onPlaylistPause();
        await playlistTabController.getTrackByID(trackID: item.id.toString());
        await Get.delete<MediaPlayerController>();
        Get.to(() => MediaPlayerScreen(), arguments: {
          ArgumentConstants.trackID: item.id,
        });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: kDefaultPadding),
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              _buildTrackImage(item.image.toString()),
              const Gap(20),
              _buildTrackInfo(item),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color.fromRGBO(235, 235, 245, 0.6),
                size: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackImage(String imageUrl) {
    return ClipRRect(
      child: AppCachedImage(
        height: 60,
        width: 60,
        borderRadius: BorderRadius.circular(7.0),
        imageUrl: imageUrl,
      ),
    );
  }

  Widget _buildTrackInfo(playlist.Data item) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name ?? "",
            style: customTextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              letterSpacing: 0.4,
              color: kWhiteColor,
            ),
          ),
          Text(
            '${item.affirmationsCount} affirmations',
            style: customTextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: 0.4,
              color: descriptionColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// **Offline Search Function**
List<playlist.Data> searchProducts({
  required List<playlist.Data> productList,
  String? query,
}) {
  if (query == null || query.isEmpty) return productList;

  return productList.where((product) {
    return product.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
  }).toList();
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
// import 'package:manifest/features/explore/controllers/playlist_details_controller.dart';
// import 'package:manifest/helper/import.dart';
// import 'package:manifest/view/widgets/custom_search_widget.dart';
// import '../../../../../../../core/constants/argument_constants.dart';
// import '../../../../../../../features/media_player/audio_player_controller.dart';
// import '../../../../../../../features/media_player/controllers/media_player_controller.dart';
// import '../../../../../../../features/media_player/media_player_screen.dart';


// class FavoriteTracksPage extends StatelessWidget {
//   const FavoriteTracksPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final PlaylistTabController playlistTabController =
//         Get.find<PlaylistTabController>();

//     return Container(
//       decoration: _buildBackgroundGradient(),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: _buildAppBar(context),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
//               child: customSearchWidget(),
//             ),
//             Expanded(
//               child: Obx(() => _buildTrackList(playlistTabController)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   BoxDecoration _buildBackgroundGradient() {
//     return const BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [
//           Color.fromRGBO(40, 117, 188, 1),
//           Color.fromRGBO(6, 141, 233, 1),
//           Color.fromRGBO(23, 156, 231, 1),
//           Color.fromRGBO(35, 148, 229, 1),
//         ],
//       ),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       centerTitle: false,
//       leading: CupertinoButton(
//         onPressed: () => Navigator.pop(context),
//         padding: EdgeInsets.zero,
//         child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 16.0),
//       ),
//       title: Text(
//         AppStrings.favoriteTracks,
//         style: customTextStyle(
//           color: kWhiteColor,
//           fontSize: 20.0,
//           fontWeight: FontWeight.w700,
//           letterSpacing: 0.4,
//         ),
//       ),
//     );
//   }

//   Widget _buildTrackList(PlaylistTabController playlistTabController) {
//     if (playlistTabController.isFavoriteTrackLoading.value) {
//       return Center(
//         child: LoadingAnimationWidget.staggeredDotsWave(
//           color: Colors.white,
//           size: 60,
//         ),
//       );
//     }

//     if (playlistTabController.favoriteTracks.data == null ||
//         playlistTabController.favoriteTracks.data!.isEmpty) {
//       return Center(
//         child: Text("No data found",
//             style: customTextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 15,
//                 color: descriptionColor)),
//       );
//     }

//     return ListView.builder(
//      // padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//       itemCount: playlistTabController.favoriteTracks.data!.length,
//       itemBuilder: (context, index) {
//         var item = playlistTabController.favoriteTracks.data![index];
//         return _buildTrackItem(item, playlistTabController);
//       },
//     );
//   }

//   Widget _buildTrackItem(dynamic item, PlaylistTabController playlistTabController) {
//   final AudioPlaybackController audioPlaybackController =
//       Get.put(AudioPlaybackController());

//   return GestureDetector(
//     onTap: () async {
//       // Fetch track details but don't navigate immediately
//       await playlistTabController.getTrackByID(trackID: item.id.toString());
//     },
//     child: Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         children: [
//           // Play Button
//           GestureDetector(
//             onTap: () {
//               if (audioPlaybackController.isPlaying.value) {
//                 audioPlaybackController.stopPlaying();  // Pause if already playing
//               } else {
//                audioPlaybackController.playAffirmationsSequentially(item.affirmations ?? []);

//               }
//             },
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 _buildTrackImage(item.image),
//                 Obx(() => audioPlaybackController.isPlaying.value
//                     ? const Icon(Icons.pause_circle_filled, color: Colors.white, size: 40)
//                     : const Icon(Icons.play_circle_fill, color: Colors.white, size: 40)),
//               ],
//             ),
//           ),
//           const Gap(20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(item.name,
//                     style: customTextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 17,
//                         letterSpacing: 0.4,
//                         color: kWhiteColor)),
//                 Text('${item.affirmationsCount} affirmations',
//                     style: customTextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12,
//                         letterSpacing: 0.4,
//                         color: descriptionColor)),
//               ],
//             ),
//           ),
//           // Navigation Icon
//           GestureDetector(
//             onTap: () async {
//               await Get.delete<MediaPlayerController>();
//               Get.to(() =>  MediaPlayerScreen(), arguments: {
//                 ArgumentConstants.trackID: item.id,
//               });
//             },
//             child: const Icon(Icons.arrow_forward_ios_rounded,
//                 color: Color.fromRGBO(235, 235, 245, 0.6), size: 18.0),
//           ),
//         ],
//       ),
//     ),
//   );
// }

//   Widget _buildTrackImage(String imageUrl) {
//     return SizedBox(
//       height: 60,
//       width: 60,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(7.0),
//         child: Image.network(
//           imageUrl,
//           fit: BoxFit.cover,
//           colorBlendMode: BlendMode.darken,
//           color: Colors.black45,
//           errorBuilder: (context, error, stackTrace) => Container(
//             color: Colors.white70,
//             child: Center(child: Icon(Icons.error, color: Colors.grey.shade600)),
//           ),
//         ),
//       ),
//     );
//   }

//   void _playAffirmations(
//       PlaylistTabController playlistTabController, String trackID) async {
//     await playlistTabController.getTrackByID(trackID: trackID);
//     List<dynamic> affirmations =
//         playlistTabController.favoriteTracks.data ?? [];
//     for (var affirmation in affirmations) {
//       await Future.delayed(const Duration(seconds: 3)); // Simulating play duration
//       print('Playing affirmation: ${affirmation.name}');
//     }
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manifest/controllers/theme_controller.dart';
import '../../../../../../../controllers/playList_tab/playlist_tab_controller.dart';
import '../../../../../../../core/constants.dart';
import '../../../../../../../helper/constant.dart';
import '../../../../../../../helper/icons_and_images_path.dart';
import '../../../../../../../models/playlist_tab_model/favorite_playlist_model/favorite_playlist_model.dart'
    as playlist;
import 'package:manifest/helper/import.dart';
import '../../../../../../widgets/show_svg_icon_widget.dart';

class FavoriteAffirmationPlaylist extends StatefulWidget {
  const FavoriteAffirmationPlaylist({super.key});

  @override
  _FavoriteAffirmationPlaylistState createState() =>
      _FavoriteAffirmationPlaylistState();
}

class _FavoriteAffirmationPlaylistState
    extends State<FavoriteAffirmationPlaylist> {
  final PlaylistTabController playlistTabController =
      Get.find<PlaylistTabController>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final TextEditingController searchController = TextEditingController();

  String? currentlyPlayingUrl;
  int? currentlyPlayingIndex;
  bool isPlaying = false;
  bool isLoading = false;

  List<playlist.Data> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = List.from(playlistTabController.favoritePlaylist.data ?? []);

    // Listen for play/pause state
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });

    // Listen for processing state changes to handle loading/buffering and completion
    _audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.loading ||
          state == ProcessingState.buffering) {
        setState(() {
          isLoading = true;
        });
      } else if (state == ProcessingState.ready) {
        setState(() {
          isLoading = false;
        });
      } else if (state == ProcessingState.completed) {
        setState(() {
          // When audio completes, reset current track info so play icon shows.
          isPlaying = false;
          currentlyPlayingUrl = null;
          currentlyPlayingIndex = null;
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      filteredData = _searchTracks(
        trackList: playlistTabController.favoritePlaylist.data ?? [],
        query: query,
      );
    });
  }

  List<playlist.Data> _searchTracks({
    required List<playlist.Data> trackList,
    String? query,
  }) {
    if (query == null || query.isEmpty) return trackList;
    return trackList
        .where((track) =>
            track.description?.toLowerCase().contains(query.toLowerCase()) ??
            false)
        .toList();
  }

  void _playPauseAudio(String url, int index) async {
    try {
      if (currentlyPlayingUrl == url) {
        // Toggle play/pause for the current track.
        if (isPlaying) {
          await _audioPlayer.pause();
        } else {
          await _audioPlayer.play();
        }
      } else {
        // For a new track, set the current index and trigger loading.
        setState(() {
          currentlyPlayingIndex = index;
          isLoading = true;
        });
        await _audioPlayer.stop();
        await _audioPlayer.setUrl(url);
        await _audioPlayer.play();
        setState(() {
          currentlyPlayingUrl = url;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing audio: ${e.toString()}')),
      );
    }
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
      leading: CupertinoButton(
        onPressed: () => Navigator.pop(context),
        padding: EdgeInsets.zero,
        child:
            const Icon(Icons.arrow_back_ios, color: Colors.white, size: 16.0),
      ),
      title: Text(
        "Favorite Affirmation",
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
      child: customSearchWidget(
        controller: searchController,
        onChanged: _onSearchChanged,
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
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          itemCount: filteredData.length,
          itemBuilder: (context, index) {
            final item = filteredData[index];
            return _buildTrackItem(item, index);
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
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: descriptionColor,
        ),
      ),
    );
  }

  Widget _buildTrackItem(playlist.Data item, int index) {
    final bool isCurrentTrack = currentlyPlayingIndex == index;
    return Card(
      elevation: 0,
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      child: InkWell(
        onTap: () => _playPauseAudio(item.audio ?? "", index),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              _buildTrackImage(item, isCurrentTrack),
              const SizedBox(width: 16),
              _buildTrackInfo(item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackInfo(playlist.Data item) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.description ?? "Unknown Track",
            style: customTextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: 0.4,
              color: kWhiteColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            item.audioDuration ?? "00:00",
            style: customTextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: 0.4,
              color: kWhiteColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTrackImage(playlist.Data item, bool isCurrentTrack) {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.3),
            image: DecorationImage(
              image: item.image?.isNotEmpty ?? false
                  ? NetworkImage(item.image ?? "")
                  : const AssetImage("assets/images/default_music.png")
                      as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: _buildPlayButton(item, isCurrentTrack),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayButton(playlist.Data item, bool isCurrentTrack) {
    // While loading the current track, display a loading animation.
    if (isCurrentTrack && isLoading) {
      return CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 0.5,
      );
    }
    return IconButton(
      icon: Icon(
        isCurrentTrack ? Icons.pause_circle_filled : Icons.play_circle_filled,
        color: Colors.white,
        size: 34,
      ),
      onPressed: () => _playPauseAudio(
          item.audio ??
              "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
          filteredData.indexOf(item)),
    );
  }
}

Widget customSearchWidget({
  TextEditingController? controller,
  void Function(String)? onChanged,
}) {
  return Container(
    height: 45,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.black.withOpacity(0.20),
    ),
    child: Row(
      children: [
        showSvgIconWidget(iconPath: AppIcons.search),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller ?? TextEditingController(),
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Colors.white38,
              ),
              hintText: AppStrings.whatDoYouWantToListenTo,
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    ),
  );
}

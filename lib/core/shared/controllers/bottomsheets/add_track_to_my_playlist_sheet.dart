import 'package:manifest/core/shared/controllers/add_track_to_my_playlist_sheet_controller.dart';
import 'package:manifest/core/shared/widgets/custom_search_widget.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/loading_wrapper.dart';
import 'package:manifest/helper/import.dart';

class AddTrackToMyPlaylistSheet extends StatelessWidget {
  final int trackId;
  final VoidCallback? onAddToPlaylist;

  const AddTrackToMyPlaylistSheet({
    Key? key,
    required this.trackId,
    this.onAddToPlaylist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTrackToMyPlaylistController());

    return Obx(
      () => CustomBottomSheet(
        title: 'Add Tracks to Playlist',
        hasBackButton: false,
        primaryButtonText: 'Add to Playlist',
        isPrimaryButtonEnabled: controller.selectedPlaylistId.value.isNotEmpty,
        onPrimaryButtonPressed: () {
          if (onAddToPlaylist != null) {
            onAddToPlaylist!();
          } else {
            controller.addTrackToMyPlaylist(
              trackId: trackId,
              playlistId: controller.selectedPlaylistId.value,
            );
          }
        },
        horizontalPadding: 20.r,
        contentPadding: EdgeInsets.zero,
        body: SizedBox(
          height: kSize.height * 0.90,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomSearchWidget(
                  hintText: 'What do you want to listen to?',
                  onSearchChanged: controller.onSearchChanged,
                ),
              ),
              24.height,
              Expanded(
                child: LoadingWrapper(
                  isInitialLoading: RxBool(false),
                  isLoading: controller.isLoading,
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 160.h),
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.playlists.length,
                    itemBuilder: (context, index) {
                      final playlist = controller.playlists[index];
                      return Obx(
                        () => AppListTile.selectableWithTypeAndDuration(
                          artworkUrl: playlist.image?.imageName ?? "",
                          title: playlist.name ?? "",
                          type: "playlist",
                          duration: playlist.tracksTotalDuration ?? "",
                          isSelected: controller.selectedPlaylistId.value ==
                              playlist.id.toString(),
                          onTap: () => controller
                              .togglePlaylistSelection(playlist.id.toString()),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

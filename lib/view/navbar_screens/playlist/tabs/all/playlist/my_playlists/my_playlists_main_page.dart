import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/features/explore/views/playlist_details_screen.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';

class UserPlaylistPage extends StatelessWidget {
  const UserPlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaylistTabController c = Get.find<PlaylistTabController>();
    return Scaffold(
        backgroundColor: AppColors.appBG,
        appBar: AppBar(
          backgroundColor: AppColors.appBG,
          elevation: 0,
          centerTitle: false,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 16.0,
              ),
            ),
          ),
          title: Text(
            AppStrings.myPlaylist,
            style: customTextStyle(
              color: kWhiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: 16.0, vertical: 24.0),
            //   child: customSearchWidget(),
            // ),
            Expanded(
              child: Obx(
                () => c.isLoading.value ||
                        c.createdPlaylistsModel.data == null
                    ? c.createdPlaylistsModel.data == null
                        ? Container()
                        : Center(
                            child: dotsWaveLoading())
                    : c.createdPlaylistsModel.data != null ||
                            c.createdPlaylistsModel.data!.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            shrinkWrap: true,
                            itemCount: c.createdPlaylistsModel.data!.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var item = c.createdPlaylistsModel.data![index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const PlaylistDetailsScreen(),
                                    arguments: {
                                      ArgumentConstants.playlistId: item.id,
                                      ArgumentConstants.playlistType:
                                          item.createdBy,
                                    },
                                  );
                                  c.getPlaylistByID(
                                      playlistID: item.id.toString());
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: kDefaultPadding),
                                  child: Row(
                                    children: [
                                      AppCachedImage(
                                        imageUrl: item.image.toString(),
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        height: 60,
                                        width: 60,
                                      ),
                                      const Gap(20),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${item.name}',
                                            style: customTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                                letterSpacing: 0.4,
                                                color: kWhiteColor),
                                          ),
                                          Text(
                                            '${item.tracksCount} tracks',
                                            style: customTextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                letterSpacing: 0.4,
                                                color: descriptionColor),
                                          )
                                        ],
                                      )),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Color.fromRGBO(
                                            235, 235, 245, 0.6),
                                        size: 18.0,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text('No data',
                                style: primaryWhiteTextStyle()),
                          ),
              ),
            ),
          ],
        ));
  }
}

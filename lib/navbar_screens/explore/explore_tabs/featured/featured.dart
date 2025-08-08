import 'package:manifest/core/shared/widgets/content_card.dart';
import 'package:manifest/features/explore/views/playlist_details_screen.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/auth_screens/premium_sheet.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/controllers/explore_tab/explore_categories_controller.dart';

class FeaturedTabPage extends GetView<ExploreCategoriesController> {
  const FeaturedTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // if (controller.isExploreDataLoading.value) {
      //   return Center(child: dotsWaveLoading());
      // }

      if (controller.featuredPlaylists.value.featured == null) {
        return const Center(child: Text('No data available'));
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: controller.featuredPlaylists.value.featured?.length ?? 0,
        itemBuilder: (context, index) {
          final item = controller.featuredPlaylists.value.featured![index];
          return ContentCard(
            imageUrl: item.image.toString(),
            title: item.name.toString(),
            subtitle: '${item.tracks?.length} tracks',
            isLocked: item.isPremium,
            isPlaylist: true,
            duration: item.trackDuration.toString(),
            cardType: ContentCardType.square,
            id: item.id,
            playlistType: item.createdBy,
            onTap: () {
              /// * if premium then redirect to premium sheet
              if (!item.isPremium) {
                Get.to(() => const PremiumSheet());
                return;
              }
              Get.to(() => const PlaylistDetailsScreen(),
                  arguments: {
                    ArgumentConstants.playlistId: item.id,
                    ArgumentConstants.playlistType: item.createdBy,
                  });
            },
          );
        },
      );
    });
  }
}

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manifest/helper/icons_and_images_path.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/my_collection_page_controller.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'collection_detail_screen.dart';

class MyCollectionPage extends GetView<MyCollectionPageController> {
  const MyCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            AppStrings.myCollections,
            style: customTextStyle(
              color: kWhiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: showSvgIconWidget(
                iconPath: AppIcons.add,
                onTap: controller.onCreateCollectionTap,
              ),
            )
          ],
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
                () => controller.isLoading.value
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 60,
                        ),
                      )
                    : controller.collections.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            shrinkWrap: true,
                            itemCount: controller.collections.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var item = controller.collections[index];
                              return GestureDetector(
                                /// * on specific tile tap redirect to the collection details page
                                onTap: () {
                                  Get.to(
                                    () => const CollectionDetailScreen(),
                                    arguments: {
                                      ArgumentConstants.collectionId:
                                          item.id.toString(),
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: kDefaultPadding),
                                  child: Row(
                                    children: [
                                      AppCachedImage(
                                        imageUrl: item.image.toString(),
                                        height: 60,
                                        width: 60,
                                        borderRadius:
                                            BorderRadius.circular(7.0),
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
                                            '${item.affirmationsCount} affirmations',
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

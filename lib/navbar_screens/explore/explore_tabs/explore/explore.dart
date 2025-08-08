// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:manifest/core/theme.dart';
// import 'package:manifest/core/utils.dart';
// import 'package:manifest/helper/constant.dart';
// import 'package:manifest/core/shared/widgets/app_cached_image.dart';
// import 'package:manifest/view/widgets/custom_search_widget.dart';
// import 'package:manifest/view/widgets/dots_wave_loading.dart';
// import 'package:manifest/controllers/explore_tab/explore_categories_controller.dart';
// import 'package:manifest/features/explore/views/explore_category_screen.dart';
// import 'package:manifest/features/explore/models/explore_category_model.dart';

// class ExploreTabPage extends GetView<ExploreCategoriesController> {
//   const ExploreTabPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ExploreCategoriesController c = Get.find<ExploreCategoriesController>();
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         children: [
//           24.height,
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: kDefaultMargin),
//             child: CustomSearchWidget(
//               onSearchChanged: (query){},
//               hintText: 'Search explore categories...',
//             ),
//           ),
//           24.height,
//           Obx(() => c.isExploreDataLoading.value ||
//                   c.explorePlaylistCategories.value.data == null
//               ? Center(child: dotsWaveLoading())
//               : Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16.0,
//                       mainAxisSpacing: 16.0,
//                       childAspectRatio: 1.4,
//                     ),
//                     itemCount: c.explorePlaylistCategories.value.data!.length,
//                     shrinkWrap: true,
//                     physics: const ScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       var item = c.explorePlaylistCategories.value.data![index];
//                       return ExploreCard(category: item);
//                     },
//                   ),
//                 )),
//           60.height,
//         ],
//       ),
//     );
//   }
// }

// // GestureDetector(
// //   onTap: () {
// //   Get.to(()=> const ExploreDetailPage());
// //   },
// //   child: Card(
// //     color: Colors.transparent,
// //     elevation: 0.0,
// //     shape: RoundedRectangleBorder(
// //       borderRadius: BorderRadius.circular(15.0),
// //     ),
// //     child: CachedNetworkImage(
// //       imageUrl: item.imageUrl,
// //       imageBuilder: (context, imageProvider) => Container(
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(15.0),
// //           image: DecorationImage(
// //             image: imageProvider,
// //             fit: BoxFit.cover,
// //             colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken)
// //           ),
// //         ),
// //       ),
// //       placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
// //       errorWidget: (context, url, error) => const Icon(Icons.error),
// //     ),
// //   ),
// // ),
// // Positioned(bottom: 10.0, left: 15.0, child: Text(item.title, style: customTextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,letterSpacing: 0.4,color: const Color.fromRGBO(255, 255, 255, 1)))),

// class ExploreCard extends StatelessWidget {
//   final ExploreCategoryModel category;
//   const ExploreCard({
//     super.key,
//     required this.category,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         CardWithOverlayText(
//           height: 109.h,
//           image: category.image,
//           title: category.name,
//           onTap: () {
//             Get.to(
//               () => ExploreCategoryScreen(),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

// class CardWithOverlayText extends StatelessWidget {
//   final String? image;
//   final String? title;
//   final double? height;
//   final double? width;
//   final VoidCallback onTap;
//   const CardWithOverlayText({
//     super.key,
//     this.image,
//     this.title,
//     this.height,
//     this.width,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height ?? 163.w,
//       width: width ?? 163.w,
//       child: GestureDetector(
//         onTap: onTap,
//         child: Stack(
//           children: [
//             /// * card image
//             AppCachedImage(
//                 imageUrl: image ?? '',
//                 height: height ?? 163.w,
//                 width: width ?? 163.w),

//             /// * card title
//             Positioned.fill(
//               child: Container(
//                 padding: EdgeInsets.all(10.0.h),
//                 alignment: Alignment.bottomLeft,
//                 child: Text(
//                   title?.capitalize ?? '',
//                   style: helveticaRoundedPageTitleTextStyle(
//                       fontSize: 15.0.sp, color: AppColors.light, height: 1),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

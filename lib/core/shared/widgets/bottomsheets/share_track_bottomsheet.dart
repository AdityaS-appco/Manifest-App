// import 'dart:io';

// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
// import 'package:manifest/core/shared/widgets/buttons/facebook_circle_button.dart';
// import 'package:manifest/core/shared/widgets/buttons/instagram_circle_button.dart';
// import 'package:manifest/core/shared/widgets/buttons/transparent_button.dart';
// import 'package:manifest/core/shared/widgets/buttons/x_circle_button.dart';
// import 'package:manifest/core/shared/widgets/pill_tab_bar.dart';
// import 'package:manifest/core/shared/widgets/touch_splash.dart';
// import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
// import 'package:manifest/core/controllers/share_affirmation_controller.dart';
// import 'package:manifest/helper/import.dart';
// import 'package:manifest/core/shared/widgets/app_cached_image.dart';
// import 'package:path_provider/path_provider.dart';

// class ShareTrackBottomsheet extends StatelessWidget {
//   ShareTrackBottomsheet({
//     Key? key,
//     required this.imageUrl,
//     required this.trackName,
//     required this.shareLink,
//     this.gradientColors,
//   }) {
//     controller = Get.put(ShareAffirmationController(
//       imageUrl: imageUrl,
//       affirmationText: trackName,
//       shareLink: shareLink,
//     ));
//   }

//   final String imageUrl;
//   final String trackName;
//   final String shareLink;
//   final List<Color>? gradientColors;
//   final GlobalKey previewKey = GlobalKey();
//   late ShareAffirmationController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => CustomBottomSheet(
//         gradientColors: controller.gradientColors,
//         hasBackButton: false,
//         topPadding: 10.h,
//         horizontalPadding: 0.w,
//         buttonsTopPadding: 35.h,
//         buttonsHorizontalPadding: 20.w,
//         body: Obx(
//           () => AnimatedContainer(
//             duration: const Duration(milliseconds: 500),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 331.h,
//                   child: _buildPreviewContainer(controller),
//                 ),
//                 20.height,
//                 Text(
//                   'Share with your friends and family',
//                   textAlign: TextAlign.center,
//                   style: Get.appTextTheme.subtitleSmall.copyWith(
//                     color: Colors.white,
//                     height: 1.38,
//                   ),
//                 ),
//                 24.height,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30).r,
//                   child: _buildShareOptions(controller),
//                 ),
//                 42.height,
//               ],
//             ),
//           ),
//         ),
//         primaryButtonText: controller.isEditMode.value ? 'Save' : null,
//         onPrimaryButtonPressed:
//             controller.isEditMode.value ? () => controller.onBackgroundSave() : null,
//       ),
//     );
//   }

//   Widget _buildPreviewContainer(
//     ShareAffirmationController controller,
//   ) {
//     return Center(
//       child: SizedBox(
//         height: 331.h,
//         width: 333.w,
//         child: Stack(
//           children: [
//             /// * Background
//             AppCachedImage(
//                 imageUrl: controller.selectedBackgroundImage.value?.imageUrl,
//                 height: 331.h,
//                 width: 333.w,
//                 borderRadius: BorderRadius.circular(20).r,
//                 border: Border.all(color: Colors.white.withOpacity(0.1))),

//             /// * Text
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(20).r,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       trackName,
//                       style: Get.appTextTheme.headingExtraSmallRounded.copyWith(
//                         height: 1.25,
//                         letterSpacing: -0.40,
//                       ),
//                     ),
//                     4.height,
//                     Text(
//                       "32 affirmations · 03:15",
//                       style: Get.appTextTheme.contentTileSubtitleSmall.copyWith(
//                         height: 1.45,
//                         letterSpacing: 0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             /// * Logo
//             Positioned(
//               top: 20.h,
//               left: 0,
//               right: 0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 19.h,
//                     child: SvgPicture.asset(
//                       "assets/logo/manifest_full_logo.svg",
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Positioned(
//             //   bottom: 20.h,
//             //   left: 0,
//             //   right: 0,
//             //   child: Text(
//             //     '@getmanifest.app',
//             //     style: TextStyle(
//             //       fontFamily: 'Athletics',
//             //       color: (controller.colorExtractor.textColor.value ??
//             //               Colors.white)
//             //           .withOpacity(0.4),
//             //       fontSize: 9,
//             //       fontWeight: FontWeight.w400,
//             //     ),
//             //     textAlign: TextAlign.center,
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildShareOptions(
//     ShareAffirmationController controller,
//   ) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _buildShareButton(
//           'Copy Link',
//           type: ShareButtonType.custom,
//           iconPath: IconAllConstants.linkChain,
//           onPressed: controller.copyLink,
//         ),
//         _buildShareButton(
//           'X',
//           type: ShareButtonType.x,
//           onPressed: () => _handleShare(controller.shareToX),
//         ),
//         _buildShareButton(
//           'Instagram',
//           type: ShareButtonType.instagram,
//           onPressed: () => _handleShare(controller.shareToInstagram),
//         ),
//         _buildShareButton(
//           'Facebook',
//           type: ShareButtonType.facebook,
//           onPressed: () => _handleShare(controller.shareToFacebook),
//         ),
//         _buildShareButton(
//           'More',
//           type: ShareButtonType.custom,
//           iconPath: IconAllConstants.menuHorizontalDots_v1,
//           onPressed: () => _handleShare(controller.shareMore),
//         ),
//       ],
//     );
//   }

//   Future<void> _handleShare(
//     Future<void> Function({String? imagePath}) shareFunction,
//   ) async {
//     try {
//       final imageBytes = await UiUtils.convertWidgetToImage(previewKey);
//       if (imageBytes != null) {
//         final tempDir = await getTemporaryDirectory();
//         final file = File(
//             '${tempDir.path}/share_image_${DateTime.now().millisecondsSinceEpoch}.png');
//         await file.writeAsBytes(imageBytes);
//         await shareFunction(imagePath: file.path);
//       } else {
//         await shareFunction();
//       }
//     } catch (e) {
//       LogUtil.e('Error handling share: $e');
//       await shareFunction();
//     }
//   }

//   Widget _buildShareButton(
//     String label, {
//     String? iconPath,
//     required VoidCallback onPressed,
//     ShareButtonType? type,
//   }) {
//     return switch (type) {
//       ShareButtonType.facebook => FacebookCircleButton(onPressed: onPressed),
//       ShareButtonType.x => XCircleButton(onPressed: onPressed),
//       ShareButtonType.instagram => InstagramCircleButton(onPressed: onPressed),
//       _ => SvgCircleButton(
//           iconPath!,
//           enabledColor: AppColors.light.withOpacity(0.1),
//           iconColor: AppColors.light,
//           onPressed: onPressed,
//           buttonSize: 50,
//           iconSize: 20,
//         ),
//     };
//   }
// }

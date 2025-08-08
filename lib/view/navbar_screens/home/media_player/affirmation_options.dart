// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:manifest/helper/constant.dart';
// import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

// import '../../../../helper/icons_and_images_path.dart';
// import 'affirmation_options/AffirmationAddToCollection.dart';
// import 'affirmation_options/AffirmationShare.dart';

// class AffirmationOptions extends StatelessWidget {
//   const AffirmationOptions({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade900,
//       body: Center(
//         child: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: kDefaultPadding,),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               2.height,
//               Column(
//                 children: [
//                   Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         '“I am in the right place at the right time, doing the right thing.”',
//                         style: secondaryWhiteTextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
//                         textAlign: TextAlign.center,
//                       )),
//                   20.height,
//                   ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     leading: Icon(Icons.visibility_off, color: greyColor),
//                     title: Text(
//                       'Hide affirmation',
//                       style: secondaryWhiteTextStyle(fontSize: 17.0,fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   ListTile(
//                     onTap: () {
//                       Get.bottomSheet(
//                         const AffirmationAddToCollectionScreen(),
//                         isScrollControlled: true,
//                         enableDrag: true,
//                         enterBottomSheetDuration: const Duration(milliseconds: 500),
//                         exitBottomSheetDuration: const Duration(milliseconds: 500),
//                       );
//                     },
//                     contentPadding: EdgeInsets.zero,
//                     leading: showSvgIconWidget(iconPath: AppIcons.bookmark),
//                     title: Text(
//                       'Add to collection',
//                       style: secondaryWhiteTextStyle(fontSize: 17.0,fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     leading: showSvgIconWidget(iconPath: AppIcons.edit),
//                     title: Text(
//                       'Play now',
//                       style: secondaryWhiteTextStyle(fontSize: 17.0,fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     leading: showSvgIconWidget(iconPath: AppIcons.favouriteGreyOutline),
//                     title: Text(
//                       'Add to favorite affirmations',
//                       style: secondaryWhiteTextStyle(fontSize: 17.0,fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     leading: Icon(Icons.ios_share, color: greyColor),
//                     title: GestureDetector(
//                       onTap: () {
//                         Get.bottomSheet(
//                           const AffirmationShareScreen(),
//                           isScrollControlled: true,
//                           enableDrag: true,
//                           enterBottomSheetDuration: const Duration(milliseconds: 500),
//                           exitBottomSheetDuration: const Duration(milliseconds: 500),
//                         );
//                       },
//                       child: Text(
//                         'Share',
//                         style: secondaryWhiteTextStyle(fontSize: 17.0,fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               TextButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: Text('Close',
//                   style: secondaryWhiteTextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

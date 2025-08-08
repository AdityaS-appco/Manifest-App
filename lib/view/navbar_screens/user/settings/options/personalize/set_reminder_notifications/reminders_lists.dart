// import 'package:gap/gap.dart';
// import 'package:manifest/features/reminder/regular_reminder_screen.dart';
// // import 'package:manifest/view/navbar_screens/user/settings/options/personalize/set_reminder_notifications/add_reminder.dart';
// import 'package:manifest/view/navbar_screens/user/settings/options/personalize/set_reminder_notifications/custom_reminder/custom_reminder.dart';

// class RemindersLists extends StatelessWidget {
//   const RemindersLists({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: appBackgroundColor,
//         title: Text(AppStrings.setReminder,
//             style: appBarTitleTextStyle(
//               color: Colors.white,
//             )),
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back_ios_new, size: 18),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(kDefaultPadding),
//         child: _buildEmptyState(),
//       ),
//     );
//   }

//   Column _buildEmptyState() {
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Gap(10),
//           Text(AppStrings.remindersAreNotJustNotifications,
//               maxLines: 3,
//               textAlign: TextAlign.center,
//               style: customTextStyle(
//                   color: const Color(0xffEBEBF5).withOpacity(0.30),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400)),
//           GestureDetector(
//             onTap: () {
//               Get.bottomSheet(
//                 const SelectReminderTypeBottomSheet(),
//                 isScrollControlled: true,
//                 enableDrag: true,
//                 enterBottomSheetDuration: const Duration(milliseconds: 200),
//               );
//             },
//             child: Container(
//               width: Get.width * 0.4,
//               height: 50.0,
//               padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50.0),
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color(0xffA28DF6),
//                     Color(0xff5B4A9F)
//                   ], // Change colors as needed
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               alignment: Alignment.center,
//               child: Text(AppStrings.addReminder,
//                   style: customTextStyle(
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.w600,
//                       color: kWhiteColor)),
//             ),
//           ),
//         ],
//       );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:manifest/controllers/home_controller_two.dart';
// // import 'package:manifest/controllers/home_controller.dart';
// import 'package:manifest/helper/constant.dart';
// import 'package:manifest/view/navbar_screens/user/settings/options/personalize/set_reminder_notifications/add_reminder.dart';
// import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

// import '../../../../../../../helper/icons_and_images_path.dart';

// class CreatedReminders extends StatelessWidget {
//   const CreatedReminders({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeTwoController>(
//         init: HomeTwoController(),
//     builder: (c) {
//     return Scaffold(
//       backgroundColor: appBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: appBackgroundColor,
//         title: Text('Set reminder',style: appBarTitleTextStyle(
//           color: Colors.white,
//         )),
//         leading: IconButton(
//           onPressed: (){
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back_ios_new,size: 18),),
//         iconTheme: const IconThemeData(
//             color: Colors.white
//         ),
//         actions: [
//           IconButton(onPressed: (){
//             Get.to(()=>const AddReminder());
//           },
//               icon: showSvgIconWidget(iconPath: AppIcons.circularAdd))
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(kDefaultPadding),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("When do you want to receive reminders from us? Customize your notification preferences here.",maxLines: 3,textAlign: TextAlign.start,
//                 style: customTextStyle(
//                   color: descriptionDarkColor,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400
//                 )),

//             const Gap(10),
//             GestureDetector(
//               onTap: () {
//                 Get.to(()=>const AddReminder());
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: const Color.fromRGBO(121, 118, 128, 0.24),
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             showSvgIconWidget(iconPath: AppIcons.setReminderEdit),
//                             const Gap(12),
//                             Text('Remind 1',style: customTextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
//                           ],
//                         ),
//                         Obx(() => Switch(
//                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                           inactiveTrackColor: Colors.grey.shade800.withOpacity(0.3),
//                           inactiveThumbColor: kWhiteColor,
//                           trackOutlineColor: WidgetStateProperty.all(Colors.grey.shade800.withOpacity(0.3)),
//                           value: c.isMusicOn.value,
//                           onChanged: (value) => c.toggleMusic(),
//                         )),
//                       ],
//                     ),
//                     const Gap(12),
//                     Text('I am hardwired for success.',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                     const Gap(25),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('How many?',style: customTextStyle(fontSize: 13,fontWeight: FontWeight.w400, color: kWhiteColor),),
//                         Row(
//                           children: [
//                             showSvgIconWidget(iconPath: AppIcons.remove),
//                             const Gap(40),
//                             Text('7x',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                             const Gap(40),
//                             showSvgIconWidget(iconPath: AppIcons.setReminderAdd),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const Gap(16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Start at',style: customTextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                         Text('06:00 AM',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                       ],
//                     ),
//                     const Gap(16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('End at',style: customTextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                         Text('10:00 PM',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                       ],
//                     ),
//                     const Gap(16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Repeat',style: customTextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                         Text('M  T  W  T  F  S  S',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                       ],
//                     ),

//                   ],
//                 ),
//               ),
//             ),
//             const Gap(20),
//             GestureDetector(
//               onTap: () {
//                 Get.to(()=>const AddReminder());
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: const Color.fromRGBO(121, 118, 128, 0.24),
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             showSvgIconWidget(iconPath: AppIcons.sun),
//                             const Gap(12),
//                             Text('Remind 1',style: customTextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
//                           ],
//                         ),
//                         Obx(() => Switch(
//                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                           inactiveTrackColor: Colors.grey.shade800.withOpacity(0.3),
//                           inactiveThumbColor: kWhiteColor,
//                           trackOutlineColor: WidgetStateProperty.all(Colors.grey.shade800.withOpacity(0.3)),
//                           value: c.isMusicOn.value,
//                           onChanged: (value) => c.toggleMusic(),
//                         )),
//                       ],
//                     ),
//                     const Gap(24),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Time',style: customTextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                         Text('06:00 AM',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                       ],
//                     ),
//                     const Gap(12),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Repeat',style: customTextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                         Text('M  T  W  T  F  S  S',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: kWhiteColor),),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//      );
//     }
//    );
//   }
// }

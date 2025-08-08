/// ! Go to SetReminderIntroScreen

// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// import 'package:gap/gap.dart';
// import 'package:manifest/core/services/reminder_service.dart';
// import 'package:manifest/view/widgets/buttons_widget.dart';
// import 'package:manifest/controllers/auth_controller/auth_controller.dart';
// // import 'package:manifest/view/auth_screens/social_login_page.dart';

// import 'personalization_screen.dart';

// class SetReminder extends StatefulWidget {
//   const SetReminder({super.key});

//   @override
//   State<SetReminder> createState() => _SetReminderState();
// }

// class _SetReminderState extends State<SetReminder> {
//   late FixedExtentScrollController _controller;
//   late FixedExtentScrollController _controller1;
//   late FixedExtentScrollController _controller2;
//   @override
//   void initState() {
//     super.initState();
//     _controller = FixedExtentScrollController();
//     _controller1 = FixedExtentScrollController();
//     _controller2 = FixedExtentScrollController();
//   }

//   List<String> words = ['AM', 'PM'];
//   String? selectedtime;
//   String? selectedtime1;
//   String? selectedtime2;
//   int currenttime = 0;
//   int currenttime1 = 0;
//   int currenttimezone = 0;

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(
//         init: AuthController(),
//         builder: (c) {
//           return Scaffold(
//             body: Stack(
//               fit: StackFit.expand,
//               children: [
//                 const MeshAnimationBg(),
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Gap(kSize.height * 0.17),
//                         Text(
//                           AppStrings.setReminder,
//                           style: headingSFProRoundedBoldFontStyle(fontSize: 28, fontWeight: FontWeight.w700)
//                         ),
//                         16.height,
//                         Text(
//                           AppStrings.consistencyIsKey,
//                           style: customTextStyle(color: const Color(0xffEBEBF5).withOpacity(0.70), fontSize: 15.0, fontWeight: FontWeight.w400),
//                         ),
//                         32.height,
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               AppStrings.date,
//                               style: customTextStyle(color: const Color(0xffEBEBF5).withOpacity(0.60), fontWeight: FontWeight.w600, fontSize: 14.0),
//                             ),
//                             SizedBox(
//                               height: 80,
//                               width: Get.width * 0.99,
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: 7,
//                                 itemBuilder: (context, index) {
//                                   String dayAbbreviation = ['S', 'M', 'T', 'W', 'T', 'F', 'S'][index];
//                                   bool isSelected = c.selectedDays.contains(index);
//                                   return GestureDetector(
//                                     onTap: () {
//                                       c.toggleDaySelection(index);
//                                     },
//                                     child: Container(
//                                       margin: const EdgeInsets.all(5),
//                                       width: kSize.width * 0.10,
//                                       height: 55,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: isSelected ? Colors.white : textFieldBgColor.withOpacity(0.3),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           dayAbbreviation,
//                                           style: TextStyle(
//                                             color: isSelected ? Colors.black : Colors.white,
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             20.height,
//                             Text(
//                               AppStrings.time,
//                               style: customTextStyle(color: lightGreyColor, fontWeight: FontWeight.w600, fontSize: 14.0),
//                             ),
//                             24.height,
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: textFieldBgColor.withOpacity(0.3),
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     height: kSize.height * 0.30,
//                                     width: kSize.width * 0.15,
//                                     child: ListWheelScrollView.useDelegate(
//                                       controller: _controller,
//                                       onSelectedItemChanged: (value) {
//                                         setState(() {
//                                           currenttime = value;
//                                         });
//                                       },
//                                       itemExtent: 65,
//                                       perspective: 0.006,
//                                       diameterRatio: 1.7,
//                                       physics: const FixedExtentScrollPhysics(),
//                                       childDelegate: ListWheelChildBuilderDelegate(
//                                         childCount: 12,
//                                         builder: (context, index) {
//                                           return SizedBox(
//                                             width: 55,
//                                             child: Center(
//                                               child: Text(
//                                                   (index + 1).toString(),
//                                                 style: customTextStyle(
//                                                   color: index == currenttime ? kWhiteColor : Colors.grey,
//                                                     fontSize: index == currenttime ? 24 : 21,
//                                                     fontWeight: index == currenttime ? FontWeight.w200 : FontWeight.normal),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   10.width,
//                                   SizedBox(
//                                     height: kSize.height * 0.30,
//                                     width: kSize.width * 0.15,
//                                     child: ListWheelScrollView.useDelegate(
//                                       controller: _controller1,
//                                       onSelectedItemChanged: (value) {
//                                         setState(() {
//                                           currenttime1 = value;
//                                         });
//                                       },
//                                       itemExtent: 65,
//                                       perspective: 0.006,
//                                       diameterRatio: 1.7,
//                                       physics: const FixedExtentScrollPhysics(),
//                                       childDelegate: ListWheelChildBuilderDelegate(
//                                         childCount: 61,
//                                         builder: (context, index) {
//                                           return SizedBox(
//                                             width: 55,
//                                             child: Center(
//                                               child: Text(
//                                                 index.toString(),
//                                                 style: customTextStyle(
//                                                     color: index == currenttime1 ? kWhiteColor : Colors.grey,
//                                                     fontSize: index == currenttime1 ? 24 : 21,
//                                                     fontWeight: index == currenttime1 ? FontWeight.w200 : FontWeight.normal),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   20.width,
//                                   SizedBox(
//                                     height: kSize.height * 0.30,
//                                     width: kSize.width * 0.15,
//                                     child: ListWheelScrollView.useDelegate(
//                                         controller: _controller,
//                                         onSelectedItemChanged: (value) {
//                                           setState(() {
//                                             currenttimezone = value;
//                                           });
//                                         },
//                                         itemExtent: 65,
//                                         perspective: 0.006,
//                                         diameterRatio: 1.7,
//                                         physics: const FixedExtentScrollPhysics(),
//                                         childDelegate: ListWheelChildBuilderDelegate(
//                                             childCount: words.length,
//                                             builder: (context, index) {
//                                               return SizedBox(
//                                                   width: 55,
//                                                   child: Center(
//                                                       child: Text(
//                                                     words[index],
//                                                         style: customTextStyle(
//                                                             color: index == currenttimezone ? kWhiteColor : Colors.grey,
//                                                             fontSize: index == currenttimezone ? 24 : 21,
//                                                             fontWeight: index == currenttimezone ? FontWeight.w200 : FontWeight.normal),
//                                                   )));
//                                             })),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Gap(kSize.height * 0.2),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 //back button
//                 // Positioned(
//                 //   top: kSize.height * 0.08,
//                 //   left: kSize.width * 0.05,
//                 //   child: CircleAvatar(
//                 //     backgroundColor: textFieldBgColor,
//                 //     child: IconButton(
//                 //       icon: Icon(
//                 //         Icons.arrow_back_ios_new,
//                 //         color: kWhiteColor,
//                 //         size: 20.0,
//                 //       ),
//                 //       onPressed: () {
//                 //         Navigator.pop(context);
//                 //       },
//                 //     ),
//                 //   ),
//                 // ),
//                 Positioned(
//                   bottom: 10,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: buttonHeight,
//                           width: kSize.width * 0.9,
//                           child: kGradientButton(
//                             text: AppStrings.enableReminder,
//                             textColor: primaryColor,
//                             onPressed: () {
//                               /// * get reminder time [that user has selected]
//                               final reminderTime = 
//                               /// todo: enable reminder [api]
//                               ReminderService().setRegularReminder(
//                                 reminderTime: 
//                               )
//                               Get.to(()=> const PersonalizationScreen());
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: buttonHeight,
//                           width: kSize.width * 0.9,
//                           child: TextButton(
//                             onPressed: () {
//                               Get.offAll(() => const SocialLoginPage());
//                             },
//                             child: Text(
//                               AppStrings.skipReminder,
//                               style: customTextStyle(
//                                 fontSize: 15.0,
//                                 color: kWhiteColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   Widget _showTimeWidget() {
//     return TimePickerSpinner(
//       is24HourMode: false,
//       normalTextStyle: customTextStyle(fontSize: 18.0, color: lightGreyColor),
//       highlightedTextStyle: customTextStyle(
//         fontSize: 20.0,
//         color: kWhiteColor,
//         fontWeight: FontWeight.bold,
//       ),
//       spacing: 40,
//       itemHeight: 80,
//       isForce2Digits: false,
//       onTimeChange: (time) {
//         print(time);
//         // setState(() {
//         //   _dateTime = time;
//         // });
//       },
//     );
//   }
// }

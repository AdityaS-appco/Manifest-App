import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:gap/gap.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/helper/import.dart';
import 'created_reminders.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  late FixedExtentScrollController _controller;
  late FixedExtentScrollController _controller1;
  late FixedExtentScrollController _controller2;
  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
    _controller1 = FixedExtentScrollController();
    _controller2 = FixedExtentScrollController();
  }

  List<String> words = ['AM', 'PM'];
  String? selectedtime;
  String? selectedtime1;
  String? selectedtime2;
  int currenttime = 0;
  int currenttime1 = 0;
  int currenttimezone = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (c) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              title: Text(AppStrings.addReminder,
                  style: appBarTitleTextStyle(
                    color: Colors.white,
                  )),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                TextButton(
                    onPressed: () {
                      /// * go back
                      Get.back();
                      // Get.to(()=>const CreatedReminders());
                    },
                    child: Text(
                      AppStrings.done,
                      style: primaryWhiteHelveticaRoundedRegularTextStyle(
                          color: primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            ),
            body: Column(
              children: [
                //const MeshAnimationBg(),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: kDefaultPadding, right: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.remindingTime,
                            textAlign: TextAlign.right,
                            style: customTextStyle(
                                color: descriptionDarkColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        const Gap(20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: kSize.height * 0.30,
                                width: kSize.width * 0.15,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _controller,
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      currenttime = value;
                                    });
                                  },
                                  itemExtent: 65,
                                  perspective: 0.006,
                                  diameterRatio: 1.7,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 12,
                                    builder: (context, index) {
                                      return SizedBox(
                                        width: 55,
                                        child: Center(
                                          child: Text(
                                            (index + 1).toString(),
                                            style: customTextStyle(
                                                color: index == currenttime
                                                    ? kWhiteColor
                                                    : Colors.grey,
                                                fontSize: index == currenttime
                                                    ? 24
                                                    : 21,
                                                fontWeight: index == currenttime
                                                    ? FontWeight.w200
                                                    : FontWeight.normal),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const Gap(10),
                              SizedBox(
                                height: kSize.height * 0.30,
                                width: kSize.width * 0.15,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _controller1,
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      currenttime1 = value;
                                    });
                                  },
                                  itemExtent: 65,
                                  perspective: 0.006,
                                  diameterRatio: 1.7,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 61,
                                    builder: (context, index) {
                                      return SizedBox(
                                        width: 55,
                                        child: Center(
                                          child: Text(
                                            index.toString(),
                                            style: customTextStyle(
                                                color: index == currenttime1
                                                    ? kWhiteColor
                                                    : Colors.grey,
                                                fontSize: index == currenttime1
                                                    ? 24
                                                    : 21,
                                                fontWeight:
                                                    index == currenttime1
                                                        ? FontWeight.w200
                                                        : FontWeight.normal),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const Gap(10),
                              SizedBox(
                                height: kSize.height * 0.30,
                                width: kSize.width * 0.15,
                                child: ListWheelScrollView.useDelegate(
                                    controller: _controller,
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        currenttimezone = value;
                                      });
                                    },
                                    itemExtent: 65,
                                    perspective: 0.006,
                                    diameterRatio: 1.7,
                                    physics: const FixedExtentScrollPhysics(),
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                            childCount: words.length,
                                            builder: (context, index) {
                                              return SizedBox(
                                                  width: 55,
                                                  child: Center(
                                                      child: Text(
                                                    words[index],
                                                    style: customTextStyle(
                                                        color: index ==
                                                                currenttimezone
                                                            ? kWhiteColor
                                                            : Colors.grey,
                                                        fontSize: index ==
                                                                currenttimezone
                                                            ? 24
                                                            : 21,
                                                        fontWeight: index ==
                                                                currenttimezone
                                                            ? FontWeight.w200
                                                            : FontWeight
                                                                .normal),
                                                  )));
                                            })),
                              ),
                            ],
                          ),
                        ),
                        const Gap(30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppStrings.advanced,
                                textAlign: TextAlign.right,
                                style: customTextStyle(
                                    color: descriptionDarkColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            const Gap(20),
                            Text(AppStrings.repeat,
                                textAlign: TextAlign.right,
                                style: customTextStyle(
                                    color: kWhiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 80,
                              width: Get.width * 0.99,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  String dayAbbreviation = [
                                    'S',
                                    'M',
                                    'T',
                                    'W',
                                    'T',
                                    'F',
                                    'S'
                                  ][index];
                                  bool isSelected =
                                      c.selectedDays.contains(index);
                                  return GestureDetector(
                                    onTap: () {
                                      c.toggleDaySelection(index);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      width: kSize.width * 0.10,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? const Color.fromRGBO(
                                                162, 141, 246, 1)
                                            : const Color(0xff7A7880)
                                                .withOpacity(0.36),
                                      ),
                                      child: Center(
                                        child: Text(
                                          dayAbbreviation,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.black
                                                : Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _showTimeWidget() {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: customTextStyle(fontSize: 18.0, color: lightGreyColor),
      highlightedTextStyle: customTextStyle(
        fontSize: 20.0,
        color: kWhiteColor,
        fontWeight: FontWeight.bold,
      ),
      spacing: 40,
      itemHeight: 80,
      isForce2Digits: false,
      onTimeChange: (time) {
        print(time);
        // setState(() {
        //   _dateTime = time;
        // });
      },
    );
  }
}









// class AddReminder extends StatelessWidget {
//   const AddReminder({super.key});
//
//   @override
//   Widget build(BuildContext context) {
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
//           icon: Icon(Icons.arrow_back_ios_new,size: 18),),
//         iconTheme: IconThemeData(
//             color: Colors.white
//         ),
//         actions: [
//           TextButton(onPressed: (){}, child: Text('Done',style: primaryWhiteSFPRoundedRegularTextStyle(
//             color: primaryColor,
//             fontSize: 17,
//             fontWeight: FontWeight.w700
//           ),))
//         ],
//       ),
//       body: Padding(
//         padding:  EdgeInsets.all(kDefaultPadding),
//         child: Column(
//           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Reminding Time',
//                 textAlign: TextAlign.right,
//                 style: customTextStyle(
//                   color: descriptionLightColor,
//                   fontSize: 16,
//                 )),
//
//             Center(
//               child: Container(
//                 height: 50,
//                 width: 50,
//                 color: Colors.deepOrange,
//               ),
//             ),
//
//             Text('Advanced',textAlign: TextAlign.right,
//                 style: customTextStyle(
//                   color: descriptionLightColor,
//                   fontSize: 16,
//                 )),
//
//             Gap(10),
//             Text('Repeat',textAlign: TextAlign.right,
//                 style: customTextStyle(
//                   color: kWhiteColor,
//                   fontSize: 16,
//                 )),
//
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:gap/gap.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/set_reminder_notifications/created_reminders.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/core/utils/form_validator_util.dart';

import '../../../../../../../../helper/icons_and_images_path.dart';

class CustomReminder extends StatefulWidget {
  const CustomReminder({super.key});

  @override
  State<CustomReminder> createState() => _CustomReminderState();
}

class _CustomReminderState extends State<CustomReminder> {
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
                      /// * get back
                      Get.back();
                      // Get.to(() => const CreatedReminders());
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
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: kDefaultPadding, right: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.howManyTimes,
                              style: customTextStyle(
                                  color: kWhiteColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                showSvgIconWidget(iconPath: AppIcons.redRemove),
                                const Gap(40),
                                Text(
                                  '7x',
                                  style: customTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: kWhiteColor),
                                ),
                                const Gap(40),
                                showSvgIconWidget(iconPath: AppIcons.redAdd),
                              ],
                            ),
                          ],
                        ),
                        const Gap(45),
                        Text(AppStrings.remindingTime,
                            textAlign: TextAlign.right,
                            style: customTextStyle(
                                color: descriptionDarkColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        const Gap(16),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              const SetReminderTime(),
                              isScrollControlled: true,
                              enableDrag: true,
                              enterBottomSheetDuration:
                                  const Duration(milliseconds: 200),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.startTime,
                                style: customTextStyle(
                                    color: kWhiteColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  showSvgIconWidget(
                                      iconPath: AppIcons.redRemove),
                                  const Gap(18),
                                  Text(
                                    '8:00 AM',
                                    style: customTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: kWhiteColor),
                                  ),
                                  const Gap(18),
                                  showSvgIconWidget(iconPath: AppIcons.redAdd),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        const Divider(thickness: 0.2, color: Colors.grey),
                        const Gap(20),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              const SetReminderTime(),
                              isScrollControlled: true,
                              enableDrag: true,
                              enterBottomSheetDuration:
                                  const Duration(milliseconds: 200),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.endTime,
                                style: customTextStyle(
                                    color: kWhiteColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  showSvgIconWidget(
                                      iconPath: AppIcons.redRemove),
                                  const Gap(18),
                                  Text(
                                    '8:00 PM',
                                    style: customTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: kWhiteColor),
                                  ),
                                  const Gap(18),
                                  showSvgIconWidget(iconPath: AppIcons.redAdd),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(45),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppStrings.advanced,
                                textAlign: TextAlign.right,
                                style: customTextStyle(
                                    color: descriptionDarkColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            const Gap(16),
                            Text(AppStrings.repeat,
                                textAlign: TextAlign.right,
                                style: customTextStyle(
                                    color: kWhiteColor,
                                    fontSize: 14.0,
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
                            const Gap(26),
                            Text(AppStrings.affirmation,
                                textAlign: TextAlign.right,
                                style: customTextStyle(
                                    color: kWhiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            const Gap(12),
                            Container(
                              padding: EdgeInsets.all(kDefaultMargin),
                              decoration: BoxDecoration(
                                color: const Color(0xff2C2C2E),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              height: 120,
                              width: double.infinity,
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                style: customTextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                    color: greyColor),
                                autocorrect: true,
                                decoration: InputDecoration(
                                  hintText: AppStrings.inputYourAffirmation,
                                  hintStyle: customTextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white38),
                                  border: InputBorder.none,
                                ),
                                maxLength: 200,
                                validator: FormValidatorUtil.affirmation,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

class SetReminderTime extends StatefulWidget {
  const SetReminderTime({Key? key}) : super(key: key);

  @override
  State<SetReminderTime> createState() => _SetReminderTimeState();
}

class _SetReminderTimeState extends State<SetReminderTime> {
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
        return Container(
          height: kSize.height * 0.40,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff1d2125),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Stack(
              children: [
                Column(
                  children: [
                    const Gap(20),
                    Text(AppStrings.startTime,
                        style: primaryWhiteHelveticaRoundedRegularTextStyle(
                            color: kWhiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    const Gap(10),
                    Container(
                      decoration: BoxDecoration(
                        color: textFieldBgColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: kSize.height * 0.26,
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
                                            fontSize:
                                                index == currenttime ? 24 : 21,
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
                            height: kSize.height * 0.26,
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
                                            fontSize:
                                                index == currenttime1 ? 24 : 21,
                                            fontWeight: index == currenttime1
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
                                childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: words.length,
                                    builder: (context, index) {
                                      return SizedBox(
                                          width: 55,
                                          child: Center(
                                              child: Text(
                                            words[index],
                                            style: customTextStyle(
                                                color: index == currenttimezone
                                                    ? kWhiteColor
                                                    : Colors.grey,
                                                fontSize:
                                                    index == currenttimezone
                                                        ? 24
                                                        : 21,
                                                fontWeight:
                                                    index == currenttimezone
                                                        ? FontWeight.w200
                                                        : FontWeight.normal),
                                          )));
                                    })),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: mediumGrey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

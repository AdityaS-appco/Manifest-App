import 'package:manifest/controllers/home_controller_two.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/set_reminder_notifications/add_reminder.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/set_reminder_notifications/custom_reminder/edit_custom_reminder.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/helper/import.dart';

import '../../../../../../../../helper/icons_and_images_path.dart';

class CreatedCustomReminderList extends StatelessWidget {
  const CreatedCustomReminderList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeTwoController>(
        init: HomeTwoController(),
        builder: (c) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              title: Text('Set reminder',style: appBarTitleTextStyle(
                color: Colors.white,
              )),
              leading: IconButton(
                onPressed: (){
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new,size: 18),),
              iconTheme: const IconThemeData(
                  color: Colors.white
              ),
              actions: [
                IconButton(onPressed: (){
                  Get.to(()=>const AddReminder());
                },
                    icon: showSvgIconWidget(iconPath: AppIcons.circularAdd))
              ],
            ),
            body: Padding(
              padding:  EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("I am hardwired for success.",textAlign: TextAlign.start,
                      style: customTextStyle(
                        color: descriptionLightColor,
                        fontSize: 13,
                      )),

                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=> const EditCustomReminder());
                    },
                    child: Container(
                      width: double.infinity,
                      //height: 269,
                      decoration: BoxDecoration(
                        // rgba(121, 118, 128, 0.24)
                        color: const Color.fromRGBO(121, 118, 128, 0.24),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    showSvgIconWidget(iconPath: AppIcons.setReminderEdit),
                                    const Gap(10),
                                    Text('Remind 1',style: customTextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
                                  ],
                                ),
                                Obx(() => Switch(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  inactiveTrackColor: Colors.grey.shade800.withOpacity(0.3),
                                  inactiveThumbColor: kWhiteColor,
                                  trackOutlineColor: WidgetStateProperty.all(Colors.grey.shade800.withOpacity(0.3)),
                                  value: c.isMusicOn.value,
                                  onChanged: (value) => c.toggleMusic(),
                                )),
                              ],
                            ),
                            const Gap(10),
                            Text('Lorem ipsum dolor sit amet consectetur. Pretium sed consequat morbi tortor tellus in consequat ipsum.',maxLines: 2,style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: kWhiteColor.withOpacity(0.4)),),
                            const Gap(25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('How many?',style: customTextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: descriptionLightColor),),
                                Row(
                                  children: [
                                    showSvgIconWidget(iconPath: AppIcons.remove),
                                    const Gap(40),
                                    Text('7x',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: descriptionLightColor),),
                                    const Gap(40),
                                    showSvgIconWidget(iconPath: AppIcons.setReminderAdd),
                                  ],
                                ),
                              ],
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Start at',style: customTextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: descriptionLightColor),),
                                Text('06:00 AM',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: descriptionLightColor),),
                              ],
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('End at',style: customTextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: descriptionLightColor),),
                                Text('10:00 PM',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: descriptionLightColor),),
                              ],
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Repeat',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: descriptionLightColor),),
                                Text('M  T  W  T  F  S  S',style: customTextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: descriptionLightColor),),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }
}

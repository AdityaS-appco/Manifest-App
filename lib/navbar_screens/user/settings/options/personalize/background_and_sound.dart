import 'package:manifest/controllers/home_controller_two.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

import '../../../../../../helper/icons_and_images_path.dart';

class BackgroundAndSounds extends StatelessWidget {
  const BackgroundAndSounds({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeTwoController>(
      init: HomeTwoController(),
      builder: (c) {
        return Scaffold(
          backgroundColor: appBackgroundColor,
          appBar: AppBar(
            backgroundColor: appBackgroundColor,
            leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new,size: 18),),
            title: Text(AppStrings.backgroundAndSound,style: appBarTitleTextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17.0,
              color: Colors.white,
            )),
            iconTheme: const IconThemeData(
                color: Colors.white
            ),
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Text(AppStrings.sceneVolume,style: secondaryWhiteTextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      )),
                      const Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          showSvgIconWidget(iconPath: AppIcons.muteSound),
                          Expanded(
                            child: Obx(
                                  () => Slider(
                                value: c.volume.value.toDouble(),
                                min: 0.0,
                                max: 100.0,
                                activeColor: primaryColor,
                                inactiveColor: Colors.grey.shade700,
                                onChanged: (double newValue) {
                                  c.volume.value = newValue.round();
                                },
                              ),
                            ),
                          ),
                          showSvgIconWidget(iconPath: AppIcons.soundWIthValue),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        showSvgIconWidget(iconPath: AppIcons.moveCamera),
                        const Gap(16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(AppStrings.makeSceneDefault,style: secondaryWhiteTextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            )),
                            const Gap(4),
                            Text(AppStrings.whenChangingSoundScape,style: primaryWhiteTextStyle(
                              color: descriptionDarkColor,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            )),
                          ],
                        ),
                      ],
                    ),
                    Obx(() => Switch(
                      inactiveTrackColor: Colors.grey.shade800.withOpacity(0.3),
                      inactiveThumbColor: kWhiteColor,
                      trackOutlineColor: WidgetStateProperty.all(Colors.grey.shade800.withOpacity(0.3)),
                      value: c.isMusicOn.value,
                      onChanged: (value) => c.toggleMusic(),
                    )),
                  ],
                ),
              ]
            ),
          ),
        );
      }
    );
  }
}

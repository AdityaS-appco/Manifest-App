import 'package:manifest/features/reminder/views/set_reminder_intro_screen.dart';
import 'package:manifest/view/widgets/buttons_widget.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/helper/import.dart';

class PersonalizationGoalScreen extends StatelessWidget {
  const PersonalizationGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (c) {
          return Scaffold(
            backgroundColor: appBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              title: Text(AppStrings.personalization,
                  style: appBarTitleTextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17.0,
                    color: Colors.white,
                  )),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(15),
                        Text(AppStrings.onboardingGoalsTitle,
                            style: headingHelveticaRoundedBoldFontStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            )),
                        const Gap(4),
                        Text(
                          AppStrings.weWillPersonalizeRecommendation,
                          style: customTextStyle(
                              color: descriptionDarkColor,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400),
                        ),
                        const Gap(24),
                        Padding(
                          padding: EdgeInsets.only(bottom: kSize.height * 0.1),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: c.goalsList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                bool isSelected =
                                    c.selectedGoalIndex.contains(index);
                                return Obx(() => GestureDetector(
                                      onTap: () {
                                        c.setSelectedGoalIndex(index);
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 12.0),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding,
                                            vertical: 12.0),
                                        decoration: BoxDecoration(
                                          color: settingCardBgColor,
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          border: Border.all(
                                              color: isSelected
                                                  ? kWhiteColor
                                                  : Colors.transparent,
                                              width: 1.5),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                                c.goalsList[index].emoji
                                                    .toString(),
                                                style: customTextStyle(
                                                    fontSize: 16.0,
                                                    color: kWhiteColor)),
                                            const Gap(12),
                                            Text(
                                                c.goalsList[index].title
                                                    .toString(),
                                                style: customTextStyle(
                                                    fontSize: 14.0,
                                                    color: kWhiteColor,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                    ));
                              }),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: SizedBox(
                      height: buttonHeight,
                      width: kSize.width * 0.9,
                      child: kGradientPrimaryColorButton(
                        text: AppStrings.continueText,
                        onPressed: () {
                          Get.to(() => const SetReminderIntroScreen());
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

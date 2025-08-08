import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/list_tile_widget.dart';

import '../../../../../../helper/icons_and_images_path.dart';

class AffirmationCategory extends StatelessWidget {
  const AffirmationCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        title: Text(AppStrings.sendASuggestion,
            style: appBarTitleTextStyle(
              color: Colors.white,
            )),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: appBackgroundColor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.sendASuggestion,
                  style: primaryWhiteHelveticaRoundedRegularTextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const Gap(4),
                Text(
                  AppStrings.allFeedBackIsHeard,
                  style: customTextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      color: descriptionLightColor),
                ),
                const Gap(22),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xff2C2C2E),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: customRow(
                          title: AppStrings.sendAnAffirmationCategory,
                          leadingSvgIconPath: AppIcons.orangeBulb,
                          isTrailingIconShow: false),
                    )),
                const Gap(16),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xff2C2C2E),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: customRow(
                          title: AppStrings.proposeASessionIdea,
                          leadingSvgIconPath: AppIcons.purpleHeadPhones,
                          isTrailingIconShow: false),
                    )),
                const Gap(16),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xff2C2C2E),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: customRow(
                          title: AppStrings.requestAFeature,
                          leadingSvgIconPath: AppIcons.featureIcon,
                          isTrailingIconShow: false),
                    )),
                const Gap(16),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xff2C2C2E),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: customRow(
                          title: AppStrings.reportABug,
                          leadingSvgIconPath: AppIcons.warning,
                          isTrailingIconShow: false),
                    )),
                const Gap(16),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xff2C2C2E),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: customRow(
                          title: AppStrings.justWantedToSay,
                          leadingSvgIconPath: AppIcons.greenChat,
                          isTrailingIconShow: false),
                    )),
                const Gap(16),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xff2C2C2E),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: customRow(
                          title: AppStrings.other,
                          leadingSvgIconPath: AppIcons.menuIcon,
                          isTrailingIconShow: false),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/divider_section.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/duration_selection_cupertino_tabbar.dart';

class MostListenedTracksBottomsheet extends StatelessWidget {
  const MostListenedTracksBottomsheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: "Most listened tracks",
      hasBackButton: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Week 18-25 Apr",
            style: Get.appTextTheme.titleExtraSmall.copyWith(
              color: const Color(0xFF7A7A7C),
              fontWeight: FontWeight.w400,
            ),
          ),
          24.height,
          TimePeriodSelectionIOSTabbar(
            currentTab: Rx<TimePeriod>(TimePeriod.day),
            onTabChanged: (timePeriod) async {},
          ),
          16.height,
          DividerSection.containered(
            dividerPadding: EdgeInsets.zero,
            border: Border.all(color: Colors.white.withOpacity(0.05)),
            children: [
              Row(
                children: <Widget>[
                  Text(
                    "12 times",
                    style: Get.appTextTheme.titleExtraSmall.copyWith(
                      height: 1.86,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "11 hours 32 min",
                    style: Get.appTextTheme.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.4),
                      height: 1.86,
                    ),
                  )
                ],
              ),
              AppListTile.contentTile(
                affirmationCount: "120",
                title: "I am enough",
                duration: " 45:00",
                artworkUrl: "",
              )
            ],
          ),
          16.height,
          DividerSection.containered(
            dividerPadding: EdgeInsets.zero,
            border: Border.all(color: Colors.white.withOpacity(0.05)),
            children: [
              Row(
                children: <Widget>[
                  Text(
                    "12 times",
                    style: Get.appTextTheme.titleExtraSmall.copyWith(
                      height: 1.86,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "11 hours 32 min",
                    style: Get.appTextTheme.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.4),
                      height: 1.86,
                    ),
                  )
                ],
              ),
              AppListTile.contentTile(
                affirmationCount: "120",
                title: "I am enough",
                duration: " 45:00",
                artworkUrl: "",
              )
            ],
          ),
          16.height,
          DividerSection.containered(
            dividerPadding: EdgeInsets.zero,
            border: Border.all(color: Colors.white.withOpacity(0.05)),
            children: [
              Row(
                children: <Widget>[
                  Text(
                    "12 times",
                    style: Get.appTextTheme.titleExtraSmall.copyWith(
                      height: 1.86,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "11 hours 32 min",
                    style: Get.appTextTheme.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.4),
                      height: 1.86,
                    ),
                  )
                ],
              ),
              AppListTile.contentTile(
                affirmationCount: "120",
                title: "I am enough",
                duration: " 45:00",
                artworkUrl: "",
              )
            ],
          ),
          16.height,
        ],
      ),
    );
  }

}

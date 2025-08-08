import 'dart:math';
import 'package:manifest/core/shared/controllers/profile_controller.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/most_listened_tracks_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/charts/usage_chart_widget.dart';
import 'package:manifest/core/shared/widgets/chips/rainbow_gradient_chip.dart';
import 'package:manifest/core/shared/widgets/divider_section.dart';
import 'package:manifest/core/shared/widgets/gradient_text_span.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/core/shared/widgets/oval_blurred_widget.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/features/splash/star_splash_screen.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/gift_bottomsheet.dart';
import 'package:manifest/view/navbar_screens/user/dashboard/downloads.dart';
import 'package:manifest/view/navbar_screens/user/dashboard/recent.dart';
import 'package:manifest/view/navbar_screens/user/dashboard/session_count_sheet.dart';
import 'package:manifest/features/settings/views/settings.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/view/widgets/arc_progress_widget/arc_progress_widget/arc_progress_widget.dart';
import 'package:manifest/view/widgets/arc_progress_widget/arc_progress_widget_controller/arc_progress_controller.dart';
import 'package:manifest/view/widgets/duration_selection_cupertino_tabbar.dart';

import '../../../helper/icons_and_images_path.dart';

class UserDashboardController extends BaseController
    with ProfileControllerMixin {}

class UserDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Rx<TimePeriod> _selectedTimePeriod = Rx<TimePeriod>(TimePeriod.day);
    Get.put(ProgressController());
    final controller = Get.put(UserDashboardController());

    final userProfile = controller.profile;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background effects
          const OvalBlurredWidget(),

          // Main content
          StarSplashScreen(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      147.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            68.height,

                            /// * User profile section
                            Stack(
                              children: [
                                AppCachedImage(
                                  imageUrl: userProfile?.image ?? "",
                                  isGradient: userProfile?.isPremium ?? false,
                                  height: 120.r,
                                  width: 120.r,
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(1000).r,
                                ),
                                if (userProfile.isPremium ?? false)
                                  Positioned(
                                    bottom: 10.r,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Transform.translate(
                                        offset: Offset(0, 17.5.r),
                                        child: RainbowGradientChip(
                                          "Plus",
                                          iconPath: IconAllConstants.sparkle,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          style: Get.appTextTheme.bodySmall
                                              .copyWith(
                                            fontWeight: FontWeight.w700,
                                            height: 1,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),

                            32.height,
                            Text(
                              userProfile?.name ?? "",
                              style: Get.appTextTheme.headingSmallRounded,
                            ),

                            40.height,

                            /// * Manifestation score section
                            DividerSection.containered(
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.05)),
                              containerColor: Colors.white.withOpacity(0.1),
                              padding: const EdgeInsets.all(24),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.manifestationScore,
                                      style: Get.appTextTheme.titleLargeRounded
                                          .copyWith(
                                        height: 1.40,
                                      ),
                                    ),
                                    4.height,
                                    Text(
                                      AppStrings.basedOnYourActivity,
                                      style:
                                          Get.appTextTheme.bodySmall.copyWith(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                    20.height,
                                    Center(
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Positioned(
                                            left: 0.0,
                                            right: 0.0,
                                            top: 0.0,
                                            child: HalfCircleProgress(
                                              size: kSize.width * 0.58,
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              progressColor:
                                                  Colors.grey.shade300,
                                              strokeWidth: 15,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 45.h,
                                                width: 55.w,
                                                child: Image.asset(
                                                  AppImages.kingPicture,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              5.height,
                                              RichText(
                                                text: GradientTextSpan(
                                                  '45',
                                                  style: Get.appTextTheme
                                                      .displayLarge,
                                                ),
                                              ),
                                              12.height,
                                              Text(
                                                AppStrings.rising,
                                                style: Get.appTextTheme
                                                    .titleExtraSmall
                                                    .copyWith(
                                                  height: 1,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              23.height,
                                              Text(
                                                AppStrings.firstStepToGreatness,
                                                style: Get.appTextTheme
                                                    .titleLargeRounded
                                                    .copyWith(
                                                  height: 1.40,
                                                ),
                                              ),
                                              12.height,
                                              Text(
                                                AppStrings
                                                    .congratsOnTakingTheFirstSteps,
                                                maxLines: 4,
                                                textAlign: TextAlign.center,
                                                style: Get
                                                    .appTextTheme.bodySmall
                                                    .copyWith(
                                                  height: 1.40,
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ).paddingOnly(
                                              top: kSize.height * 0.08),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            24.height,

                            /// * duration tabbar
                            TimePeriodSelectionIOSTabbar(
                              currentTab: _selectedTimePeriod,
                              onTabChanged: (timePeriod) async {},
                            ),
                            16.height,

                            /// * Listening hours graph section
                            DividerSection.containered(
                              padding: const EdgeInsets.all(24),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Transform.scale(
                                          scale: 1.7,
                                          child: Image.asset(
                                            ImageConstants.paywallHeadphone,
                                            height: 37.h,
                                            width: 34.w,
                                          ),
                                        ),
                                        11.width,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppStrings.listeningHoursWeek,
                                              style: Get.appTextTheme.bodySmall
                                                  .copyWith(
                                                height: 1,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            4.height,
                                            Obx(() {
                                              // Show different total hours based on selected time period
                                              final String hoursText =
                                                  _selectedTimePeriod.value ==
                                                          TimePeriod.day
                                                      ? '5h 42min'
                                                      : _selectedTimePeriod
                                                                  .value ==
                                                              TimePeriod.week
                                                          ? '32h 17min'
                                                          : _selectedTimePeriod
                                                                      .value ==
                                                                  TimePeriod
                                                                      .month
                                                              ? '124h 03min'
                                                              : '1,245h 30min';

                                              return Text(
                                                hoursText,
                                                style: Get.textTheme.titleLarge
                                                    ?.copyWith(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ],
                                    ),
                                    31.height,
                                    UsageChartWidget(
                                      timePeriod: _selectedTimePeriod,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            12.height,
                            DividerSection.containeredForSetting(
                              children: [
                                AppListTile.setting(
                                  text: '${AppStrings.sessionCount}:  5',
                                  leadingIcon:
                                      IconAllConstants.historyToggleOff,
                                  onTap: () {
                                    Get.bottomSheet(
                                      const SessionCountSheet(),
                                      isScrollControlled: true,
                                      enableDrag: true,
                                      enterBottomSheetDuration:
                                          const Duration(milliseconds: 600),
                                    );
                                  },
                                ),
                                AppListTile.setting(
                                  text: "Most listened to Tracks",
                                  leadingIcon:
                                      IconAllConstants.heartRoundedOutlined,
                                  onTap: () {
                                    AppBottomSheet.show(
                                        const MostListenedTracksBottomsheet());
                                    // Get.bottomSheet(
                                    //   const MostListenedTracks(),
                                    //   isScrollControlled: true,
                                    //   enableDrag: true,
                                    //   enterBottomSheetDuration:
                                    //       const Duration(milliseconds: 600),
                                    // );
                                  },
                                )
                              ],
                            ),
                            16.height,
                            DividerSection.containeredForSetting(
                              children: [
                                AppListTile.setting(
                                  text: "Recents",
                                  leadingIcon:
                                      IconAllConstants.clockFastForward,
                                  onTap: () {
                                    Get.to(() => const Recents());
                                  },
                                ),
                                AppListTile.setting(
                                  text: AppStrings.downloads,
                                  leadingIcon: IconAllConstants.download02,
                                  onTap: () {
                                    Get.to(() => const Download());
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: kSize.height * 0.08,
                      ),
                    ])),
          ),

          /// * appbar actions
          _buildAppBarActions()
        ],
      ),
    );
  }

  Widget _buildAppBarActions() {
    return Positioned(
      top: 64.h,
      right: 16.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgCircleButton(
            IconAllConstants.gift01,
            iconColor: Colors.white,
            padding: const EdgeInsets.all(12),
            iconSize: 22,
            onPressed: () {
              Get.bottomSheet(
                const GiftBottomSheet(),
                isScrollControlled: true,
                enableDrag: true,
                enterBottomSheetDuration: const Duration(milliseconds: 400),
              );
            },
          ),
          16.width,
          SvgCircleButton(
            IconAllConstants.settings02,
            iconColor: Colors.white,
            padding: const EdgeInsets.all(12),
            iconSize: 22,
            onPressed: () {
              Get.to(() => const SettingsScreen());
            },
          ),
        ],
      ),
    );
  }
}

class StockData {
  final String month;
  final double open;
  final double high;
  final double low;
  final double close;

  StockData(this.month, this.open, this.high, this.low, this.close);

  factory StockData.random(String month) {
    final random = Random();
    final open = random.nextDouble() * 100; // Generate random open value
    final high = open + random.nextDouble() * 50; // Generate random high value
    final low = open - random.nextDouble() * 50; // Generate random low value
    final close =
        low + random.nextDouble() * (high - low); // Generate random close value
    return StockData(month, open, high, low, close);
  }
}

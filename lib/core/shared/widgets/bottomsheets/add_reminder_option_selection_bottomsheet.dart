import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/divider_section.dart';
import 'package:manifest/core/shared/widgets/touch_splash.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';
import 'package:manifest/features/reminder/views/custom_reminder_screen.dart';
import 'package:manifest/features/reminder/views/default_reminder_screen.dart';
import 'package:manifest/helper/import.dart';

class AddReminderOptionSelectionBottomsheet extends StatelessWidget {
  const AddReminderOptionSelectionBottomsheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      hasBackButton: false,
      title: "Set Reminder",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          20.height,

          /// * default reminder
          _buildReminderOptionTile(
            title: "Default Reminder",
            subtitle:
                "We’ll send you curated affirmations that would help you to stay in good vibe and crush your goals.",
            onTileTap: () {
              LogUtil.i("Default reminder clicked");

              Get.off(() => const DefaultReminderScreen());
            },
          ),
          12.height,

          /// * custom reminder
          _buildReminderOptionTile(
            title: "Custom reminder",
            subtitle:
                "Fuel your day with your personalized affirmations to crush your own personal goals. ",
            // isLocked: true,
            onTileTap: () {
              LogUtil.i("Custom reminder clicked");

              Get.off(() => const CustomReminderScreen());
            },
          ),
          32.height,
        ],
      ),
    );
  }

  Widget _buildReminderOptionTile({
    required String title,
    required String subtitle,
    required VoidCallback onTileTap,
    bool isLocked = false,
  }) {
    return !isLocked
        ? TouchSplash(
            borderRadius: BorderRadius.circular(16).r,
            onPressed: isLocked ? () {} : onTileTap,
            splashColor: Colors.white.withOpacity(0.2),
            highlightColor: Colors.white.withOpacity(0.1),
            child: _reminderOptionTile(isLocked, title, subtitle),
          )
        : _reminderOptionTile(isLocked, title, subtitle);
  }

  Widget _reminderOptionTile(bool isLocked, String title, String subtitle) {
    return DividerSection.containered(
      border: !isLocked ? Border.all(color: Colors.white) : null,
      borderRadius: BorderRadius.circular(16),
      children: [
        Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  IconAllConstants.gear,
                  color: const Color(0xff9B9BA1),
                  height: 20.r,
                  width: 20.r,
                ),
                12.width,
                SizedBox(
                  width: 289.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: Get.appTextTheme.titleSmall,
                      ),
                      6.height,
                      Text(
                        subtitle,
                        style: Get.appTextTheme.contentCardSubtitle.copyWith(
                          height: 1.5,
                          color: const Color(0x99EBEBF5),
                          letterSpacing: 0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (isLocked)
              Positioned(
                top: 0,
                right: 0,
                child: TransparentSvgCircleButton(IconAllConstants.lock01,
                    iconSize: 18,
                    iconColor: Colors.white.withOpacity(0.3),
                    padding: EdgeInsets.zero),
              ),
          ],
        )
      ],
    );
  }
}

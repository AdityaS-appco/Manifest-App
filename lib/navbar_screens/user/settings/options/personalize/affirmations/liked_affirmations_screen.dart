import 'package:manifest/core/shared/widgets/buttons/secondary_page_button.dart';
import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/dialogs/app_dialogs.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/affirmations/hidden_affirmations_screen.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/affirmations/liked_affirmations_controller.dart';

class LikedAffirmationsScreen extends GetView<LikedAffirmationController> {
  @override
  Widget build(BuildContext context) {
    return CommonAuthFormScaffold(
      title: "Affirmations",
      bottomsheet: SecondaryPageButton.text(
        text: "Show hidden affirmations",
        onPressed: () {
          Get.to(() => HiddenAffirmationsScreen());
        },
        textStyle: Get.appTextTheme.bodyMedium.copyWith(
          color: const Color(0x4CEBEBF5),
          height: 1.29,
          letterSpacing: 0,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'Liked affirmations',
                style: Get.appTextTheme.contentTileTitleMedium
                    .copyWith(letterSpacing: 0),
              ),
              const Spacer(),
              Obx(
                () => Text(
                  '${controller.likedAffirmations.length} ${AppStrings.affirmations}',
                  style: customTextStyle(
                      fontSize: 14.0, color: descriptionLightColor),
                ),
              ),
            ],
          ),
          24.height,
          Obx(
            () => ListView.separated(
                shrinkWrap: true,
                itemCount: controller.likedAffirmations.length,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => 12.height,
                itemBuilder: (BuildContext context, int index) {
                  final affirmation = controller.likedAffirmations[index];
                  return AppListTile.likedAffirmation(
                    affirmationText: affirmation.title?.toString() ?? "",
                    onLike: () {
                      AppDialogs.showIOSDialog(
                        title: affirmation.title ?? "",
                        subtitle:
                            "Are you sure you want to remove from “Liked” affirmations?",
                        onContinuePressed: () {
                          controller.toggleFavorite(affirmation);
                        },
                        continueText: "Remove",
                        continueTextColor: AppColors.danger,
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

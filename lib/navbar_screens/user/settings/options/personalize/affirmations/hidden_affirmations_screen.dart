import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/dialogs/app_dialogs.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/affirmations/hidden_affirmations_controller.dart';

class HiddenAffirmationsScreen extends GetView<HiddenAffirmationController> {
  @override
  Widget build(BuildContext context) {
    return CommonAuthFormScaffold(
      title: "Hidden Affirmations",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Obx(
                () => Text(
                  '${controller.hiddenAffirmations.length} ${AppStrings.affirmations}',
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
                itemCount: controller.hiddenAffirmations.length,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => 12.height,
                itemBuilder: (BuildContext context, int index) {
                  final affirmation = controller.hiddenAffirmations[index];
                  return AppListTile.hiddenAffirmation(
                    affirmationText: controller.hiddenAffirmations[index].title
                            ?.toString() ??
                        "",
                    onHide: () {
                      AppDialogs.showIOSDialog(
                        title: controller.hiddenAffirmations[index].title ?? "",
                        subtitle:
                            "Are you sure you want to remove from “Hidden” affirmations?",
                        onContinuePressed: () {
                          controller.toggleHiddenAffirmation(affirmation);
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

import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/features/paywall/controllers/paywall_controller.dart';
import 'package:manifest/features/paywall/widgets/subscription_option_tile.dart';
import 'package:manifest/helper/import.dart';

class ChooseYourPlanBottomsheet extends StatelessWidget {
  final VoidCallback onConfirmChange;
  const ChooseYourPlanBottomsheet({
    Key? key,
    required this.onConfirmChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChooseYourPlanBottomsheetController());

    return CustomBottomSheet(
      hasBackButton: true,
      title: "Choose Plan",
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            20.height,
            ListView.separated(
              itemCount:
                  controller.paywallController.subscriptionOptions.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, __) => 12.height,
              itemBuilder: (context, index) {
                final plan =
                    controller.paywallController.subscriptionOptions[index];
                return Obx(() {
                  final isSelected =
                      controller.selectedPlanIndex.value == index;
                  return SubscriptionOptionTile(
                    plan,
                    isSelected: isSelected,
                    onTap: () => controller.selectPlan(index),
                  );
                });
              },
            ),
            32.height,
            PrimaryPageButton.text(
              onPressed: () => controller.confirmPlanChange(onConfirmChange),
              text: "Confirm Change",
              isEnabled: !controller.isLoading.value,
            ),
            20.height,
            Text(
              "Your new plan starts on Dec 13, 2024",
              style: Get.appTextTheme.dialogExtraSmallTitle.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0x99EBEBF5),
              ),
              textAlign: TextAlign.center,
            ),
            12.height,
          ],
        ),
      ),
    );
  }
}

class ChooseYourPlanBottomsheetController extends GetxController {
  /// The currently selected plan index (or id, as per your data model)
  final RxInt selectedPlanIndex = 0.obs;

  /// Loading state for confirm action
  final RxBool isLoading = false.obs;

  /// List of available plans (replace with your actual model if needed)
  final paywallController = Get.put(PaywallController());

  /// Select a plan by index
  void selectPlan(int index) {
    selectedPlanIndex.value = index;
  }

  /// Confirm the plan change (simulate async operation)
  Future<void> confirmPlanChange(Function onSuccess) async {
    isLoading.value = true;
    try {
      onSuccess();
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/helper/import.dart';

class RestorePurchaseConfirmationBottomsheet extends StatelessWidget {
  final VoidCallback onKeepCurrent;
  final VoidCallback onChangePlan;
  const RestorePurchaseConfirmationBottomsheet({
    Key? key,
    required this.onKeepCurrent,
    required this.onChangePlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      hasBackButton: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            ImageConstants.alertTriangle,
            height: 139.r,
            width: 139.r,
          ),
          32.height,
          _buildClaimMessage(),
          56.height,
        ],
      ),
      primaryButtonText: "Keep Current Plan",
      onPrimaryButtonPressed: onKeepCurrent,
      secondaryButtonText: "Change Plan",
      onSecondaryButtonPressed: onChangePlan,
    );
  }

  Widget _buildClaimMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 315.w,
          child: Text(
            'Are you sure \nwant to cancel?',
            style: Get.appTextTheme.headingSmallRounded,
            textAlign: TextAlign.center,
          ),
        ),
        12.height,
        SizedBox(
          width: 275.w,
          child: Text(
            "Choosing a new plan will deactivate your \ncurrent plan. Sure you want to continue.",
            textAlign: TextAlign.center,
            style: Get.appTextTheme.dialogExtraSmallTitle.copyWith(
              color: const Color(0x99EBEBF5),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

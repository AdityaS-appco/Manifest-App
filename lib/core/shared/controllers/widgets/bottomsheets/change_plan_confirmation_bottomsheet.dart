import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/helper/import.dart';

class ChangePlanConfirmationBottomsheet extends StatelessWidget {
  final VoidCallback onKeepCurrent;
  final VoidCallback onChangePlan;
  const ChangePlanConfirmationBottomsheet({
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
          Transform.scale(
            scale: 1.8,
            child: SizedBox(
              width: 157.5.w,
              height: 160.39.h,
              child: Expanded(
                child: Image.asset(
                  ImageConstants.notification2,
                ),
              ),
            ),
          ),
          28.95.height,
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
            'Heads Up!',
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

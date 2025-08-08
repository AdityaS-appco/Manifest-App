import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/helper/import.dart';

class SendResultsSuccessfullBottomsheet extends StatelessWidget {
  const SendResultsSuccessfullBottomsheet({
    Key? key,
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
            ImageConstants.check4,
            width: 131.52.w,
            height: 120.h,
          ),
          32.height,
          _buildClaimMessage(),
          38.height,
        ],
      ),
      primaryButtonText: "Okay",
      onPrimaryButtonPressed: () => Get.back(),
    );
  }

  Widget _buildClaimMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 227.w,
          child: Text(
            'Results sent successfully!',
            style: Get.appTextTheme.headingSmallRounded,
            textAlign: TextAlign.center,
          ),
        ),
        12.height,
        SizedBox(
          width: 193.w,
          child: Text(
            "Your progress has been shared. Keep going strong!",
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

import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/helper/import.dart';

class DeleteAccountConfirmationBottomsheet extends StatelessWidget {
  final VoidCallback onDelete;
  const DeleteAccountConfirmationBottomsheet({
    Key? key,
    required this.onDelete,
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
      primaryButtonText: "Yes, delete it",
      primaryButtonColor: AppColors.danger,
      primaryButtonTextColor: AppColors.light,
      onPrimaryButtonPressed: onDelete,
      secondaryButtonText: "Cancel",
      onSecondaryButtonPressed: () => Get.back(),
    );
  }

  Widget _buildClaimMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 315.w,
          child: Text(
            'Do You Really Want to delete your account?',
            style: Get.appTextTheme.headingSmallRounded,
            textAlign: TextAlign.center,
          ),
        ),
        12.height,
        SizedBox(
          width: 275.w,
          child: Text(
            "Once you delete your account, all your data will be permanently removed, and you won’t be able to recover it.",
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

import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/helper/import.dart';

class JoinNewsletterBottomsheet extends StatelessWidget {
  final Function(String email) onJoin;
  const JoinNewsletterBottomsheet({
    Key? key,
    required this.onJoin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final canJoin = false.obs;

    /// * handle join click
    void _validateEmail(String? email) {
      /// * validate the email textfield
      canJoin.value = FormValidatorUtil.email(email) == null;
    }

    return Obx(
      () => CustomBottomSheet(
          hasBackButton: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImageConstants.newsletterEnvelope,
                height: 102.47.r,
              ),
              32.height,
              _buildClaimMessage(),
              24.height,
              AppTextField.email(
                  title: "",
                  controller: emailController,
                  validator: (email) => FormValidatorUtil.email(email),
                  onChanged: (email) => _validateEmail(email)),
              32.53.height,
            ],
          ),
          primaryButtonText: "Join Newsletter",
          onPrimaryButtonPressed: () => onJoin.call(emailController.text),
          isPrimaryButtonEnabled: canJoin.value),
    );
  }

  Widget _buildClaimMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 315.w,
          child: Text(
            'Join Newsletter',
            style: Get.appTextTheme.headingSmallRounded,
            textAlign: TextAlign.center,
          ),
        ),
        12.height,
        Text(
          "Your feedback helps us improve. Stay tuned for your chance to win a year of Manifest Premium!",
          textAlign: TextAlign.center,
          style: Get.appTextTheme.dialogExtraSmallTitle.copyWith(
            color: const Color(0x99EBEBF5),
            fontWeight: FontWeight.w400,
            height: 1.69,
          ),
        ),
      ],
    );
  }
}

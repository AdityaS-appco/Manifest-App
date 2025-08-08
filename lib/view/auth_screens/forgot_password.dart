import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/helper/import.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (c) {
          return CommonAuthFormScaffold(
            title: AppStrings.forgotPasswordTwo,
            subtitle: AppStrings.enterYourEmailToResetYourPassword,
            formKey: formKey,
            bottomsheet: PrimaryPageButton.text(
              text: AppStrings.continueText,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await c.sendPasswordOtp();
                }
              },
            ),
            body: Flex(
              direction: Axis.vertical,
              children: [
                AppTextField.email(controller: c.emailController),
              ],
            ),
          );
        });
  }
}

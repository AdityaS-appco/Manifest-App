import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/helper/import.dart';

class CreateAccountWithEmailScreen extends StatelessWidget {
  const CreateAccountWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (c) {
          return CommonAuthFormScaffold(
            formKey: formKey,
            title: AppStrings.createAccount,
            subtitle: AppStrings.beYourBestSelf,
            hasStarSplash: true,
            bottomsheet: PrimaryPageButton.text(
              text: AppStrings.continueText,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await c.registerWithEmail();
                }
              },
            ),
            body: Flex(
              direction: Axis.vertical,
              children: [
                AppTextField.email(
                  controller: c.emailController,
                  hintText: "Your email",
                ),
                const Gap(20.0),
                AppTextField.password(
                  controller: c.passwordController,
                  hintText: "Password",
                ),
                const Gap(20.0),
                AppTextField.password(
                  title: AppStrings.confirmPassword,
                  hintText: "Confirm password",
                  controller: c.confirmPasswordController,
                  validator: (value) => FormValidatorUtil.confirmPassword(
                    value,
                    c.passwordController.text,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

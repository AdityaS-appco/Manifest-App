import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/auth_screens/forgot_password.dart';

class LoginPage extends StatelessWidget {
  final bool showBackRoute;
  const LoginPage({super.key, required this.showBackRoute});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (c) {
          return CommonAuthFormScaffold(
            title: AppStrings.welcomeBack,
            subtitle: AppStrings.welcomeBackMessage,
            formKey: formKey,
            isBackButtonVisible: showBackRoute,
            bottomsheet: PrimaryPageButton.text(
              text: AppStrings.login,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await c.loginWithEmail();
                }
              },
            ),
            body: Flex(
              direction: Axis.vertical,
              children: [
                AppTextField.email(controller: c.emailController),
                24.height,
                AppTextField.password(controller: c.passwordController),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ForgotPassword());
                      },
                      child: Text(
                        AppStrings.forgotPassword,
                        style: Get.appTextTheme.bodySmall.copyWith(height: 1.67),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/core/utils/form_validator_util.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final resetFormKey = GlobalKey<FormState>();
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (c) {
          return CommonAuthFormScaffold(
            title: 'Reset Password',
            subtitle: 'Enter your new password',
            formKey: resetFormKey,
            bottomsheet: PrimaryPageButton.text(
              text: 'Continue',
              onPressed: () async {
                if (resetFormKey.currentState!.validate()) {
                  await c.resetPasswordWithOtp();
                }
              },
            ),
            body: Flex(
              direction: Axis.vertical,
              children: [
                AppTextField.password(
                  title: 'New Password',
                  controller: c.passwordController,
                  hintText: 'New Password',
                ),
                20.height,
                AppTextField.password(
                  title: 'Confirm New Password',
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

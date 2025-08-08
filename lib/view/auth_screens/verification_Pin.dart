import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/features/settings/controllers/verification_pin_controller.dart';

class VerificationPin extends StatelessWidget {
  const VerificationPin(
    this.email, {
    required this.onContinue,
    this.onResend,
  });

  final String email;
  final Function(String)? onContinue;
  final Function()? onResend;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationPinController());
    // Initialize the controller with email
    controller.initialize(email);
    final formKey = GlobalKey<FormState>();

    return CommonAuthFormScaffold(
      title: 'Verification',
      subtitleWidget: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'We\'ve sent a code to ',
              style: Get.appTextTheme.pageSubtitle,
            ),
            TextSpan(
              text: email,
              style: Get.appTextTheme.pageSubtitle.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      formKey: formKey,
      isBackButtonVisible: true,
      bottomsheet: Obx(() => PrimaryPageButton.text(
            text: 'Continue',
            onPressed: controller.otp.length == 4
                ? (() => onContinue!(controller.otp) ?? controller.verifyOtp)
                : () {},
            isEnabled: controller.otp.length == 4,
          )),
      body: Flex(
        direction: Axis.vertical,
        children: [
          PinCodeFields(
            keyboardType: TextInputType.number,
            length: 4,
            padding: const EdgeInsets.all(16.0).r,
            margin: const EdgeInsets.symmetric(horizontal: 3).r,
            borderRadius: BorderRadius.circular(16.0).r,
            autoHideKeyboard: true,
            fieldHeight: 70.0.h,
            fieldWidth: 70.0.w,
            fieldBackgroundColor: Colors.white.withOpacity(0.1),
            activeBackgroundColor: Colors.white.withOpacity(0.1),
            activeBorderColor: const Color(0x4CFFFFFF),
            borderColor: Colors.white.withOpacity(0.05),
            borderWidth: 1,
            fieldBorderStyle: FieldBorderStyle.square,
            animation: Animations.slideInUp,
            animationCurve: Curves.easeInOut,
            responsive: false,
            textStyle: Get.appTextTheme.headingLarge.copyWith(height: 0),
            onComplete: controller.onOtpComplete,
            onChange: controller.onOtpChanged,
          ),
          30.height,
          Obx(
            () => Column(
              children: [
                if (controller.timer > 0)
                  Text(
                    controller.timerString,
                    style: Get.appTextTheme.pageSubtitle.copyWith(
                      height: 1.29,
                      letterSpacing: -0.40,
                    ),
                  ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Didn\'t get the code? ',
                        style: Get.appTextTheme.pageSubtitle.copyWith(
                          height: 1.29,
                          letterSpacing: -0.40,
                        ),
                      ),
                      TextSpan(
                        text: "Resend",
                        style: Get.appTextTheme.pageSubtitle.copyWith(
                          color: controller.timer == 0 ? Colors.white : null,
                          fontWeight: FontWeight.w700,
                          height: 1.29,
                          letterSpacing: -0.40,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.handleResendOtp(onResend!());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

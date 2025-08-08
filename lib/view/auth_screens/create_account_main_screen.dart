import 'package:flutter/gestures.dart' as richText;
import 'package:flutter/gestures.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/view/auth_screens/create_account_with_email_screen.dart';
import '../../helper/icons_and_images_path.dart';
import 'login_page.dart';

class CreateAccountMainScreen extends StatelessWidget {
  const CreateAccountMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (c) {
          return CommonAuthFormScaffold(
            isBackButtonVisible: false,
            hasStarSplash: true,
            contentPadding: const EdgeInsets.all(31),
            bottomsheet: Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: AppStrings.haveAnAccount,
                      style: Get.appTextTheme.loginPhrase,
                    ),
                    TextSpan(
                      text: AppStrings.logIn,
                      style: Get.appTextTheme.loginPhraseBold,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(
                            () => const LoginPage(showBackRoute: true),
                            transition: Transition.fadeIn,
                            duration: const Duration(milliseconds: 400),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(kSize.height * 0.14),
                Image.asset(
                  AppImages.whiteStarLogo,
                  height: 80,
                  width: 80,
                ),
                32.height,
                Text(
                  AppStrings.createAccount,
                  style: Get.appTextTheme.headingLarge.copyWith(height: 1.29),
                ),
                8.height,
                Text(
                  AppStrings.beYourBestSelf,
                  style: Get.appTextTheme.subtitleSmall.copyWith(
                    color: Colors.white.withAlpha(178),
                  ),
                ),
                32.height,
                PrimaryPageButton.icon(
                  svgIcon: IconAllConstants.mailSendEnvelope,
                  text: AppStrings.continueWithEmail,
                  textStyle: Get.appTextTheme.socialButtonText,
                  iconTextGap: 12.w,
                  onPressed: () {
                    Get.to(() => const CreateAccountWithEmailScreen());
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14)
                          .r,
                  isSvgColored: true,
                ),
                16.height,
                if (GetPlatform.isIOS) ...[
                  PrimaryPageButton.icon(
                      svgIcon: IconAllConstants.apple,
                      text: AppStrings.continueWithApple,
                      textStyle: Get.appTextTheme.socialButtonText,
                      iconTextGap: 12.w,
                      isSvgColored: true,
                      padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14)
                          .r,
                      onPressed: () async {
                        c.signInWithAppleServer();
                        // ToastUtil.error( message: 'temporary this Service not available',contentType: ContentType.failure);
                      }),
                  16.height,
                ],
                PrimaryPageButton.icon(
                    svgIcon: IconAllConstants.google,
                    text: AppStrings.continueWithGoogle,
                    textStyle: Get.appTextTheme.socialButtonText,
                    iconTextGap: 12.w,
                    isSvgColored: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14)
                            .r,
                    onPressed: () async {
                      await c.signInWithGoogleServer();
                    }),
                16.height,
                PrimaryPageButton.icon(
                    svgIcon: IconAllConstants.fb,
                    text: AppStrings.continueWithFacebook,
                    textStyle: Get.appTextTheme.socialButtonText,
                    iconTextGap: 12.w,
                    isSvgColored: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14)
                            .r,
                    onPressed: () async {
                      c.signInWithFacebookServer();
                      //ToastUtil.error(message: 'temporary this Service not available',contentType: ContentType.failure);
                    }),
                32.height,
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: AppStrings.termsAndPrivacy,
                          style: Get.appTextTheme.bodySmall.copyWith(
                            height: 1.5,
                            color: const Color(0xB2EBEBF5),
                          ),
                        ),
                        TextSpan(
                          text: AppStrings.privacyPolicy,
                          style: Get.appTextTheme.bodySmall.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: richText.TapGestureRecognizer()
                            ..onTap = () {},
                        ),
                        TextSpan(
                          text: AppStrings.whichExplainsHow,
                          style: Get.appTextTheme.bodySmall.copyWith(
                            color: const Color(0xB2EBEBF5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                30.height,
              ],
            ),
          );
        });
  }
}

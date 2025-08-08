import 'package:flutter/gestures.dart' as richText;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/features/splash/star_splash_screen.dart';
import 'package:manifest/helper/icons_and_images_path.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/buttons_widget.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/view/auth_screens/create_account_with_email_screen.dart';
import 'login_page.dart';

class SocialLoginPage extends StatelessWidget {
  const SocialLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (c) {
          return Scaffold(
            body: StarSplashScreen(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // const StarSplashScreen(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Gap(kSize.height * 0.14),
                          Image.asset(
                            AppImages.whiteStarLogo,
                            height: 80,
                            width: 80,
                          ),
                          20.height,
                          Text(AppStrings.createAccount,
                              style: headingHelveticaRoundedBoldFontStyle(
                                  fontSize: 28, fontWeight: FontWeight.w700)),
                          6.height,
                          Text(
                            AppStrings.beYourBestSelf,
                            style: primaryWhiteHelveticaRoundedRegularTextStyle(
                                color: const Color(0xffEBEBF5),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400),
                          ),
                          32.height,
                          kPrimaryButton(
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  showSvgIconWidget(iconPath: AppIcons.mail),
                                  12.width,
                                  Text(
                                    AppStrings.continueWithEmail,
                                    style: customTextStyle(
                                        fontSize: kSize.height * 0.018,
                                        fontWeight: FontWeight.w500,
                                        color: blackColor),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Get.to(
                                    () => const CreateAccountWithEmailScreen());
                              }),
                          16.height,
                          if (GetPlatform.isIOS) ...[
                            kPrimaryButton(
                                widget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.apple,
                                      height: 20,
                                      width: 20,
                                    ),
                                    12.width,
                                    Text(
                                      AppStrings.continueWithApple,
                                      style: customTextStyle(
                                          fontSize: kSize.height * 0.018,
                                          fontWeight: FontWeight.w500,
                                          color: blackColor),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  c.signInWithAppleServer();
                                  // ToastUtil.error( message: 'temporary this Service not available',contentType: ContentType.failure);
                                }),
                            16.height,
                          ],
                          kPrimaryButton(
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.google,
                                    height: 20,
                                    width: 20,
                                  ),
                                  12.width,
                                  Text(
                                    AppStrings.continueWithGoogle,
                                    style: customTextStyle(
                                        fontSize: kSize.height * 0.018,
                                        fontWeight: FontWeight.w500,
                                        color: blackColor),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                await c.signInWithGoogleServer();
                              }),
                          16.height,
                          kPrimaryButton(
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.facebook,
                                    width: 20,
                                    height: 20,
                                  ),
                                  12.width,
                                  Text(
                                    AppStrings.continueWithFacebook,
                                    style: customTextStyle(
                                        fontSize: kSize.height * 0.018,
                                        fontWeight: FontWeight.w500,
                                        color: blackColor),
                                  ),
                                ],
                              ),
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
                                      style:
                                          primaryWhiteHelveticaRoundedRegularTextStyle(
                                              color:
                                                  AppColors.lessImportantText,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400)),
                                  TextSpan(
                                    text: AppStrings.privacyPolicy,
                                    style:
                                        primaryWhiteHelveticaRoundedRegularTextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w700),
                                    recognizer: richText.TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                  TextSpan(
                                    text: AppStrings.whichExplainsHow,
                                    style:
                                        primaryWhiteHelveticaRoundedRegularTextStyle(
                                      color: AppColors.lessImportantText,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          30.height,
                          Padding(
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style:
                                    primaryWhiteHelveticaRoundedRegularTextStyle(
                                        color: lightGreyColor, fontSize: 16.0),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Already have an account? ",
                                    style:
                                        primaryWhiteHelveticaRoundedRegularTextStyle(
                                            color: AppColors.lessImportantText,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700),
                                  ),
                                  TextSpan(
                                    text: AppStrings.login,
                                    style: TextStyle(
                                      letterSpacing: 0.2,
                                      fontFamily: 'Helvetica',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: kWhiteColor,
                                    ),
                                    recognizer: richText.TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(() => const LoginPage(
                                              showBackRoute: true,
                                            ));
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: kSize.height * 0.06,
                  //   right: kSize.width * 0.00,
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: kSize.width * 0.02,
                  //     ),
                  //     child: TextButton(
                  //         onPressed: () async {
                  //           /// * login as guest and set reminder [if user has not skipped the set reminder part]
                  //           await Get.find<AuthService>()
                  //               .loginAsGuestAndSetReminder();

                  //           /// * navigate to the home screen
                  //           Get.offAll(() => NavbarScreen());
                  //           // animation Controller disposing
                  //         },
                  //         child: Text(
                  //           AppStrings.skip,
                  //           style: secondaryWhiteTextStyle(
                  //               fontSize: 15, fontWeight: FontWeight.w500),
                  //         )),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}

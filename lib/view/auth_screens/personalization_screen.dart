import 'dart:ui';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/features/navbar/navbar_screen.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/auth_screens/create_account_main_screen.dart';
import 'package:manifest/view/widgets/buttons_widget.dart';

class PersonalizationScreen extends StatelessWidget {
  const PersonalizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (c) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: kSize.height * 0.21,
                          width: kSize.width * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xffA99DC5),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.video_collection,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                                10.height,
                                Text(AppStrings.personalization,
                                    style: customTextStyle(
                                        color: kWhiteColor, fontSize: 16.0)),
                              ],
                            ),
                          ),
                        ),
                        Gap(kSize.height * 0.06),
                        Text(AppStrings.yourAllSet,
                            style: customTextStyle(
                                color:
                                    const Color(0xffEBEBF5).withOpacity(0.60),
                                fontSize: 15.0)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      children: [
                        SizedBox(
                          height: buttonHeight,
                          width: kSize.width,
                          child: kGradientButton(
                            height: 60,
                            text: AppStrings.signUpAndSave,
                            textColor: primaryColor,
                            onPressed: () {
                              Get.offAll(() => const CreateAccountMainScreen());
                            },
                          ),
                        ),
                        SizedBox(
                          height: buttonHeight,
                          width: kSize.width,
                          child: TextButton(
                            onPressed: () {
                              Get.offAll(() => NavbarScreen());
                            },
                            child: Text(
                              AppStrings.abandonSaveAnd,
                              style: primaryWhiteHelveticaRoundedRegularTextStyle(
                                fontSize: 15.0,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/touch_splash.dart';
import 'package:manifest/helper/import.dart';

class ChangeAppIconBottomsheet extends StatelessWidget {
  final VoidCallback onSave;
  const ChangeAppIconBottomsheet({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeAppIconBottomsheetController());
    return CustomBottomSheet(
      hasBackButton: false,
      title: "Change App Icon",
      bottomPadding: 32,
      body: SizedBox(
        height: 139.h,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => 12.width,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.appIcons.length,
          itemBuilder: (context, index) {
            final appIcon = controller.appIcons[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Obx(
                  () => TouchSplash(
                    onPressed: () => controller.selectIconTemporarily(appIcon),
                    splashColor: Colors.white.withOpacity(0.1),
                    highlightColor: Colors.white.withOpacity(0.05),
                    child: SizedBox(
                      width: 107.w,
                      height: 107.h,
                      child: Stack(
                        children: [
                          Image.asset(
                            appIcon.iconPath,
                            width: 107.w,
                            height: 107.h,
                            fit: BoxFit.cover,
                          ),
                          if (appIcon ==
                              controller.temporarySelectedAppIcon.value) ...[
                            // Positioned(
                            //   bottom: 10.h,
                            //   right: 10.w,
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       border: Border.all(
                            //           color: Colors.white, width: 1.5),
                            //       borderRadius: BorderRadius.circular(50).r,
                            //     ),
                            //     child: SvgPicture.asset(
                            //       IconAllConstants.checkCircle1Alt,
                            //       height: 16.r,
                            //       width: 16.r,
                            //       color: const Color(0xFF814AFF),
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                              bottom: 10.h,
                              right: 10.w,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF814AFF),
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(50).r,
                                ),
                                child: SvgPicture.asset(
                                  IconAllConstants.check,
                                  height: 16.r,
                                  width: 16.r,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                12.height,
                Text(
                  appIcon.name,
                  style: Get.appTextTheme.bottomsheetSubtitle.copyWith(
                    fontSize: 15,
                    height: 1.33,
                    letterSpacing: 0,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      primaryButtonText: "Save",
      onPrimaryButtonPressed: () {
        Get.back();
        controller.saveSelectedIcon();
        onSave();
      },
    );
  }
}

class AppIcon {
  final String iconPath;
  final String name;

  AppIcon({
    required this.iconPath,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppIcon &&
          runtimeType == other.runtimeType &&
          iconPath == other.iconPath &&
          name == other.name;

  @override
  int get hashCode => Object.hash(iconPath, name);
}

class ChangeAppIconBottomsheetController extends GetxController {
  final List<AppIcon> appIcons = [
    AppIcon(iconPath: ImageConstants.dreamy, name: "Dreamy"),
    AppIcon(iconPath: ImageConstants.thinker, name: "Thinker"),
    AppIcon(iconPath: ImageConstants.mystic, name: "Mystic"),
  ];

  final Rxn<AppIcon> selectedAppIcon = Rxn<AppIcon>();
  final Rxn<AppIcon> temporarySelectedAppIcon = Rxn<AppIcon>();

  void selectIconTemporarily(AppIcon icon) {
    temporarySelectedAppIcon.value = icon;
  }

  void saveSelectedIcon() {
    selectedAppIcon.value = temporarySelectedAppIcon.value;

    ToastUtil.success("App icon changed successfully");
  }
}

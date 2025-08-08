import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/affirmations/hidden_affirmations_screen.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/personalize/affirmations/liked_affirmations_screen.dart';

import '../../../../../../../helper/icons_and_images_path.dart';

class AffirmationsMainScreen extends StatelessWidget {
  const AffirmationsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
        ),
        title: Text(AppStrings.affirmations,
            style: appBarTitleTextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17.0,
              color: Colors.white,
            )),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            /// * Liked Affirmations
            ListTile(
                onTap: () => Get.to(() => LikedAffirmationsScreen()),
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: 0.0,
                title: Text(AppStrings.likedAffirmations,
                    style: secondaryWhiteTextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    )),
                trailing: SvgPicture.asset(AppIcons.forwardArrow)),
            Divider(
                color: const Color(0xff3e3c435c).withOpacity(0.36),
                thickness: 1),

            /// * Hidden Affirmations
            ListTile(
                onTap: () => Get.to(() => HiddenAffirmationsScreen()),
                contentPadding: EdgeInsets.zero,
                title: Text(AppStrings.hiddenAffirmations,
                    style: secondaryWhiteTextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    )),
                trailing: SvgPicture.asset(AppIcons.forwardArrow)),
            Divider(
                color: const Color(0xff3e3c435c).withOpacity(0.36),
                thickness: 1),
          ],
        ),
      ),
    );
  }
}

import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/list_tile_widget.dart';

import '../../../../../helper/icons_and_images_path.dart';

class DownloadPlayListOptions extends StatelessWidget {
  const DownloadPlayListOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Wealth Affirmations',
                    style: secondaryWhiteTextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
              const Gap(44),
              customRow(title: 'Share', textSize: 17, fontWeight: FontWeight.w500,leadingSvgIconPath: AppIcons.share,
              isTrailingIconShow: false
              ),
              customRow(title: 'Add to Playlist', textSize: 17, fontWeight: FontWeight.w500,leadingSvgIconPath: AppIcons.edit, isTrailingIconShow: false),
              customRow(title: 'Remove from download',textSize: 17, fontWeight: FontWeight.w500, leadingIcon: Icons.remove_circle_outline, leadingIconColor: Colors.red, isTrailingIconShow: false),

              Gap(kSize.height * 0.2),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  'Close',
                  style: secondaryWhiteTextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

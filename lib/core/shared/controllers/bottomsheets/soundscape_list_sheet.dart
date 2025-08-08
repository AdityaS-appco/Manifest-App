import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/features/soundscape/views/soundscape_tab_page.dart';
import 'package:manifest/helper/import.dart';

class SoundscapeListSheet extends StatelessWidget {
  const SoundscapeListSheet();

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: 'Soundscapes',
      maxHeight: 0.9.sh,
      minHeight: 0.9.sh,
      titlePadding: const EdgeInsets.symmetric(horizontal: 16).r,
      customHeader: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Soundscapes", style: Get.appTextTheme.headingLargeRounded),
            SvgCircleButton(
              IconAllConstants.xClose,
              onPressed: () => Get.back(),
            )
          ],
        ),
      ), // Remove the default header are
      horizontalPadding: 0,
      backButtonAlignment: Alignment.centerRight,
      body: SizedBox(height: 0.9.sh, child: const SoundScapeTabPage(backgroundColor: Colors.transparent)),
    );
  }
}

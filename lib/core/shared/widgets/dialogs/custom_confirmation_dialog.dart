import 'package:manifest/core/shared/views/blur_screen.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/core/shared/widgets/buttons/secondary_page_button.dart';
import 'package:manifest/helper/import.dart';

class CustomConfirmationDialog extends StatelessWidget {
  const CustomConfirmationDialog({
    required this.headerChildren,
    this.primaryButtonColor,
    this.secondaryButtonColor,
    this.primaryButtonTextColor,
    this.secondaryButtonTextColor,
    this.primaryButtonText,
    this.secondaryButtonText,
  });

  final List<Widget> headerChildren;
  final Color? primaryButtonColor;
  final Color? secondaryButtonColor;
  final Color? primaryButtonTextColor;
  final Color? secondaryButtonTextColor;
  final String? primaryButtonText;
  final String? secondaryButtonText;

  @override
  Widget build(BuildContext context) {
    return BlurScreen(
      child: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  120.height,
                 ...headerChildren,
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                PrimaryPageButton.text(
                  text: primaryButtonText ?? "Save Changes",
                  onPressed: () {},
                  color: primaryButtonColor,
                  textColor: primaryButtonTextColor,
                ),
                8.height,
                SecondaryPageButton.text(
                  text: secondaryButtonText ?? "Cancel",
                  onPressed: () => Get.back(),
                  color: secondaryButtonColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

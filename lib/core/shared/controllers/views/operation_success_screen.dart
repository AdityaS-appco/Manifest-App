import 'package:manifest/core/shared/views/logo_as_title_screen.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/helper/import.dart';

class OperationSuccessScreen extends StatelessWidget {
  const OperationSuccessScreen({
    this.title = 'You\'re all set!',
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.hasButton = false,
    this.hasManifestLogo = true,
    this.iconWidth = 157.50,
    this.buttonText = 'Done',
    this.onButtonPressed,
  });

  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final bool hasButton;
  final bool hasManifestLogo;
  final String buttonText;
  final double iconWidth;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasManifestLogo
          ? LogoAsTitleScreen(
              children: _buildBody,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildBody,
                )
              ],
            ),
      bottomSheet: hasButton
          ? Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: PrimaryPageButton.text(
                onPressed: onButtonPressed ??
                    () {
                      Get.back();
                      Get.back();
                    },
                text: buttonText,
              ),
            )
          : null,
    );
  }

  List<Widget> get _buildBody {
    return [
      Image.asset(
        'assets/images/successTick.png',
        width: iconWidth.w,
      ),
      32.height,
      Text(
        title,
        style: titleStyle ?? Get.appTextTheme.titleLargeRounded,
        textAlign: TextAlign.center,
      ),
      12.height,
      if (subtitle != null)
        Text(
          subtitle!,
          style: subtitleStyle ?? Get.appTextTheme.bottomsheetSubtitle,
          textAlign: TextAlign.center,
        ),
      (59 + 16).height,
    ];
  }
}

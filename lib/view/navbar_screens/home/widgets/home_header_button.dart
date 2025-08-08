import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/shared/widgets/buttons/blur_button.dart';
import 'package:manifest/helper/import.dart';

class HomeHeaderButton extends StatelessWidget {
  const HomeHeaderButton({
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  final String title;
  final String iconPath;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlurButton(
        onPressed: () => onTap(),
        icon: iconPath,
        iconSize: 22,
        text: title,
        textStyle: Get.appTextTheme.bodyLarge.copyWith(
          height: 1,
          letterSpacing: -0.32,
        ),
      ),
    );
  }
}

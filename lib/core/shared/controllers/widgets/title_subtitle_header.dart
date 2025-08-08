import 'package:manifest/helper/import.dart';

class TitleSubtitleHeader extends StatelessWidget {
  const TitleSubtitleHeader({
    this.title,
    this.subtitle,
    this.subtitleWidget,
    super.key,
  });

  final String? title;
  final String? subtitle;
  final Widget? subtitleWidget;

  @override
  Widget build(BuildContext context) {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.vertical,
      children: [
        133.height,
        if (title != null && title != "") ...[
          Text(
            title!,
            style: Get.appTextTheme.glowingPageTitle,
          ),
        ],
        if (subtitleWidget != null || (subtitle != null && subtitle != "")) ...[
          16.height,
          subtitleWidget ?? Text(
            subtitle!,
            style: Get.appTextTheme.pageSubtitle,
          ),
        ],
      ],
    );
  }
}

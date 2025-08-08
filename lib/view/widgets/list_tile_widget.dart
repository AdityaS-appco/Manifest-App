import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/helper/import.dart';

import '../../helper/icons_and_images_path.dart';

Widget customListTile(
    {Function()? onPressed,
    required String title,
    String? leadingSvgIconPath,
    String? trailingSvgIconPath,
    Icon? trailingIcon,
    IconData? leadingIcon,
    bool isTrailingIconShow = true}) {
  return ListTile(
    onTap: onPressed,
    leading: leadingSvgIconPath != null
        ? showSvgIconWidget(iconPath: leadingSvgIconPath)
        : Icon(leadingIcon),
    title: Text(
      title,
      style: secondaryWhiteTextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
    ),
    trailing: trailingSvgIconPath != null
        ? showSvgIconWidget(iconPath: trailingSvgIconPath)
        : (isTrailingIconShow
            ? Icon(Icons.arrow_forward_ios_rounded, color: greyColor, size: 18)
            : null),
    contentPadding: EdgeInsets.zero,
  );
}

Widget customRow(
    {Function()? onPressed,
    required String title,
    String? leadingSvgIconPath,
    String? trailingSvgIconPath,
    Icon? trailingIcon,
    IconData? leadingIcon,
    bool isTrailingIconShow = true,
    double? textSize,
    Color? textColor,
    FontWeight? fontWeight,
    double? letterSpacing,
    Color? leadingIconColor,
    double? leadingIconSize}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onPressed ?? () {},
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                leadingSvgIconPath != null
                    ? showSvgIconWidget(iconPath: leadingSvgIconPath)
                    : Icon(leadingIcon,
                        color: leadingIconColor ?? kWhiteColor,
                        size: leadingIconSize ?? 20),
                12.width,
                Text(
                  title,
                  style: customTextStyle(
                    color: textColor ?? kWhiteColor,
                    fontSize: textSize ?? 14.0,
                    fontWeight: fontWeight ?? FontWeight.w600,
                    letterSpacing: letterSpacing,
                  ),
                ),
              ],
            ),
            trailingSvgIconPath != null
                ? showSvgIconWidget(iconPath: trailingSvgIconPath)
                : (isTrailingIconShow
                    ? showSvgIconWidget(iconPath: AppIcons.forwardArrow)
                    : const SizedBox()),
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/custom_switch.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';

enum PlayerControlTileTrailingType { switchType, forwardIcon, custom }

class InfoOptions {
  final bool hasInfo;
  final VoidCallback? onInfoPressed;

  InfoOptions({this.hasInfo = true, this.onInfoPressed});
}

class PlayerControlTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? leadingImageUrl;
  final String? leadingIconPath;
  final InfoOptions infoOptions;
  final AppSwitchOptions switchOptions;
  final Widget? trailing;
  final PlayerControlTileTrailingType? trailingType;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final VoidCallback? onTileTap;
  final EdgeInsets? padding;

  const PlayerControlTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.leadingImageUrl,
    required this.leadingIconPath,
    required this.infoOptions,
    required this.switchOptions,
    this.trailing,
    this.trailingType,
    this.titleStyle,
    this.subtitleStyle,
    this.onTileTap,
    this.padding,
  });

  factory PlayerControlTile.withIcon({
    required String title,
    required String iconPath,
    InfoOptions? infoOptions,
    AppSwitchOptions? switchOptions,
    Widget? trailing,
    PlayerControlTileTrailingType? trailingType,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    VoidCallback? onTileTap,
  }) {
    return PlayerControlTile(
      title: title,
      leadingImageUrl: null,
      leadingIconPath: iconPath,
      infoOptions: infoOptions ?? InfoOptions(),
      switchOptions: switchOptions ?? AppSwitchOptions(),
      trailing: trailing,
      trailingType: trailingType ?? PlayerControlTileTrailingType.forwardIcon,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      onTileTap: onTileTap,
    );
  }

  factory PlayerControlTile.withImage({
    required String title,
    required String imageUrl,
    String? subtitle,
    InfoOptions? infoOptions,
    AppSwitchOptions? switchOptions,
    Widget? trailing,
    PlayerControlTileTrailingType? trailingType,
    VoidCallback? onTileTap,
    EdgeInsets? padding,
  }) {
    return PlayerControlTile(
      title: title,
      subtitle: subtitle ?? '',
      titleStyle: helveticaPageTitleTextStyle(
        fontSize: 12,
        color: AppColors.light.withOpacity(0.5),
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: -0.40,
      ),
      leadingImageUrl: imageUrl,
      leadingIconPath: null,
      infoOptions: infoOptions ?? InfoOptions(hasInfo: false),
      switchOptions: switchOptions ?? AppSwitchOptions(),
      trailing: trailing,
      trailingType: trailingType ?? PlayerControlTileTrailingType.forwardIcon,
      onTileTap: onTileTap,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: switchOptions.switchState == AppSwitchState.locked
            ? null
            : onTileTap,
        child: Container(
          padding: padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leadingImageUrl != null)
                AppCachedImage(
                  borderRadius: BorderRadius.circular(50.r),
                  imageUrl: leadingImageUrl!,
                  width: 32.r,
                  height: 32.r,
                )
              else if (leadingIconPath != null)
                SvgPicture.asset(
                  leadingIconPath!,
                  width: 20.r,
                  height: 20.r,
                  color: AppColors.light.withOpacity(0.7),
                ),
              10.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title!,
                          style: titleStyle ??
                              helveticaPageTitleTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        if (infoOptions.hasInfo &&
                            infoOptions.onInfoPressed != null) ...[
                          10.width,
                          TransparentSvgCircleButton(
                            IconAllConstants.informationCircle1,
                            onPressed: infoOptions.onInfoPressed,
                            iconSize: 16,
                            buttonSize: 18,
                            padding: EdgeInsets.zero,
                          ),
                          10.width,
                        ],
                      ],
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: subtitleStyle ??
                            helveticaPageTitleTextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.light,
                            ),
                      ),
                  ],
                ),
              ),
              if (trailing != null &&
                  trailingType == PlayerControlTileTrailingType.custom)
                trailing!
              else if (trailingType ==
                  PlayerControlTileTrailingType.forwardIcon)
                SvgPicture.asset(
                  IconAllConstants.chevronRight,
                  color: AppColors.light.withOpacity(0.7),
                  width: 24.r,
                  height: 24.r,
                )
              else if (trailingType == PlayerControlTileTrailingType.switchType)
                AppSwitch(
                  options: switchOptions,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

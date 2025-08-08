import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/helper/import.dart';

/// * A bottomsheet for player settings with header and options
class PlayerSettingBottomsheet extends StatelessWidget {
  final String? artworkUrl;
  final String title;
  final String subtitle;
  final String? description;
  final List<PlayerSettingOption> options;
  final EdgeInsetsGeometry? contentPadding;
  final bool isArtworkEditable;
  final AudioType? audioType;

  const PlayerSettingBottomsheet({
    super.key,
    this.artworkUrl,
    required this.title,
    required this.subtitle,
    this.description,
    required this.options,
    this.contentPadding,
    this.isArtworkEditable = false,
    this.audioType,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      hasBackButton: false,
      backgroundColor: const Color(0xFF252525).withOpacity(0.7),
      blurAmount: 64,
      horizontalPadding: 0,
      topPadding: 0.r,
      contentPadding: EdgeInsets.symmetric(vertical: 42.r),
      titlePadding: EdgeInsets.zero,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with artwork, title and subtitle
          AppListTile.playerSettingHeader(
            artworkUrl: artworkUrl,
            title: title,
            subtitle: subtitle,
            contentPadding:
                contentPadding ?? EdgeInsets.symmetric(horizontal: 30.r),
            isArtworkEditable: isArtworkEditable,
            type: audioType,
          ),

          // Display description if present
          if (description != null) ...[
            25.height,
            Padding(
              padding: contentPadding ?? EdgeInsets.symmetric(horizontal: 30.r),
              child: Text(
                description!,
                style: helveticaPageTitleTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.6),
                  height: 1.77,
                ),
              ),
            ),
          ],
          18.height,

          // Options list with dividers
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) => AppListTile.playerSettingOption(
              title: options[index].title,
              iconPath: options[index].iconPath,
              onTap: options[index].onTap,
              iconColor: options[index].iconColor,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 30.r, vertical: 20.r),
            ),
          ),
        ],
      ),
    );
  }
}

/// * Data class for player setting options
class PlayerSettingOption {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final Color iconColor;

  const PlayerSettingOption({
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.iconColor = Colors.white,
  });
}

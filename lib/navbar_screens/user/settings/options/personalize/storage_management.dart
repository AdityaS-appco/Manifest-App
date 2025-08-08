import 'package:manifest/core/shared/widgets/buttons/secondary_page_button.dart';
import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/dialogs/app_dialogs.dart';
import 'package:manifest/core/shared/widgets/divider_section.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/core/shared/widgets/touch_splash.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/controllers/storage_management_controller.dart';
import 'package:manifest/core/services/storage_management_service.dart';

class StorageManagementScreen extends StatelessWidget {
  StorageManagementScreen({super.key});

  final StorageManagementController controller =
      Get.put(StorageManagementController());

  @override
  Widget build(BuildContext context) {
    return CommonAuthFormScaffold(
      title: AppStrings.storageManagement,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DividerSection(
            padding: EdgeInsets.zero,
            dividerPadding: EdgeInsets.zero,
            dividerSpacing: 0,
            children: [
              AppListTile.storageManagement(
                title: "Soundscapes",
                subtitle: controller.soundscapesSize.value,
                onDelete: () =>
                    controller.handleDelete(StorageDirectory.soundscapes),
              ),
              AppListTile.storageManagement(
                title: AppStrings.affirmations,
                subtitle: controller.affirmationsSize.value,
                onDelete: () =>
                    controller.handleDelete(StorageDirectory.affirmations),
              ),
              AppListTile.storageManagement(
                title: "Tracks",
                subtitle: controller.affirmationsSize.value,
                onDelete: () =>
                    controller.handleDelete(StorageDirectory.tracks),
              ),
              AppListTile.storageManagement(
                title: AppStrings.playlists,
                subtitle: controller.playlistsSize.value,
                onDelete: () =>
                    controller.handleDelete(StorageDirectory.playlists),
              ),
              AppListTile.storageManagement(
                title: 'MP3s',
                subtitle: controller.mp3sSize.value,
                onDelete: () => controller.handleDelete(StorageDirectory.mp3s),
              ),
              AppListTile.storageManagement(
                title: AppStrings.voiceRecords,
                subtitle: controller.voiceRecordsSize.value,
                onDelete: () =>
                    controller.handleDelete(StorageDirectory.voiceRecords),
              ),
            ],
          ),
          24.height,
          SizedBox(
            width: 180.w,
            child: TouchSplash(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.zero,
              splashColor: Colors.white.withOpacity(0.1),
              highlightColor: Colors.white.withOpacity(0.05),
              onPressed: () {
                LogUtil.i("Delete all saved sounds pressed!");
              },
              child: Text(
                "Delete all saved sounds",
                style: Get.appTextTheme.loginPhrase.copyWith(
                  color: AppColors.danger,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          57.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Freeing up storage on your device by deleting files allows \nfor more available space. If needed, you can easily re-\ndownload them at any time.",
                textAlign: TextAlign.center,
                style: Get.appTextTheme.bodyMedium.copyWith(
                  color: const Color(0x99EBEBF5),
                  height: 1.29,
                  letterSpacing: 0,
                ),
              ),
              16.height,
              Text(
                "Your session history and progress will \nremain unaffected by this change.",
                textAlign: TextAlign.center,
                style: Get.appTextTheme.bodyMedium.copyWith(
                  color: const Color(0x99EBEBF5),
                  height: 1.29,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

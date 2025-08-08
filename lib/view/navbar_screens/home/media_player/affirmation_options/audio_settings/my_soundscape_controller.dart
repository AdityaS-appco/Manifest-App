import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:manifest/features/media_player/controllers/media_player_controller.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/downloaded_soundscape.dart';
import 'package:manifest/core/services/soundscape_service.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/soundscape_response_model.dart';

class MySoundscapeController extends GetxController {
  final RxList<DownloadedSoundscape> downloadedSoundscapes =
      <DownloadedSoundscape>[].obs;

  final SoundscapeService _soundscapeService;

  MySoundscapeController(this._soundscapeService);

  @override
  void onInit() async {
    super.onInit();
    await fetchDownloadedSoundscapeData();
  }

  /// * fetch the downloaded soundscape data
  Future<void> fetchDownloadedSoundscapeData() async {
    final response = await _soundscapeService.getDownloaded();

    // if (response['success']) {
    //   downloadedSoundscapes.value =
    //       response['data'] as List<DownloadedSoundscape>;
    // }
  }

  /// * remove the soundscape from downloaded soundscape list
  Future<void> removeFromDownloaded(DownloadedSoundscape soundscape) async {
    /// * if the soundscape to be removed is playing, stop it first
    if (soundscape.id ==
        Get.find<MediaPlayerController>().currentSoundscape.value?.id) {
      await Get.find<MediaPlayerController>().soundscapePlayer.stop();
    }

    // final response = await _soundscapeService.removeFromDownloaded(soundscape);
    // if (response['success']) {
    //   downloadedSoundscapes.remove(soundscape);
    //   Get.back(); // Close the bottom sheet

    //   /// * show snackbar
    //   ToastUtil.success(
    //     response['message'],
    //   );
    // }
  }

  /// * add the soundscape to downloaded
  Future<void> addToDownload(Soundscape soundscape) async {
    if (soundscape.sound == null) {
      ToastUtil.error(
        'Cannot download soundscape: No audio URL provided',
      );
      return;
    }

    // Check if already downloaded
    if (downloadedSoundscapes.any((s) => s.id == soundscape.id)) {
      ToastUtil.info(
       'Soundscape is already downloaded',
       
      );
      return;
    }

    LoadingUtil.show();

    // final response = await _soundscapeService.addToDownloaded(soundscape);
    // if (response['success']) {
    //   // Get the downloaded soundscape from response which has the correct filePath
    //   final downloadedSoundscape = DownloadedSoundscape.fromSoundscape(
    //       soundscape, response['filepath'] as String);

    //   downloadedSoundscapes.add(downloadedSoundscape);
    //   Get.back(); // Close the bottom sheet

    //   LoadingUtil.dismiss();

    //   /// * show snackbar
    //   ToastUtil.success(response['message']);
    // } else {
    //   LoadingUtil.dismiss();
    //   ToastUtil.error(response['message'] ?? 'Failed to download soundscape');
    // }
  }
}

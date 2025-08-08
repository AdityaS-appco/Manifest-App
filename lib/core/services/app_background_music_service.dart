import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:manifest/models/explore_tab_model/soundscape_tab/soundscape_response_model.dart';

class AppBackgroundSoundService extends GetxController {
  static AudioPlayer soundscapePlayer = AudioPlayer();
  static AudioPlayer affirmationPlayer = AudioPlayer();
  static AudioPlayer boosterPlayer = AudioPlayer();

  /// * play soundscape
  static void playSoundscape(Soundscape soundscape) {}

  /// * pause soundscape
  static void pauseSoundscape() {}

  /// * play affirmation
  static void playAffirmation() {}

  /// * pause affirmation
  static void pauseAffirmation() {}

  /// * play booster
  static void playBooster() {}

  /// * pause booster
  static void pauseBooster() {}
}

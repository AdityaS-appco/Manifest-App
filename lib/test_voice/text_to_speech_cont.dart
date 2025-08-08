import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:manifest/test_voice/text_to_speech_service.dart';

class VoiceController extends GetxController {
  final VoiceService _voiceService;
  final AudioPlayer _audioPlayer = AudioPlayer();
  // var availableVoices = <Voice>[].obs;

  VoiceController(this._voiceService);

  // Future<void> fetchVoices() async {
  //   try {
  //     availableVoices.value = await _voiceService.listVoices();
  //
  //     LogUtil.v('available Voices: $availableVoices');
  //   } catch (e) {
  //     // Handle errors
  //     print('Error: $e');
  //   }
  // }


  Future<void> fetchAndPlayVoice(String text) async {
    final String voicePath;
    try {
      // Fetch the voice URL from the service
      voicePath = await _voiceService.fetchVoice(
        text: text.toString(),
        voiceID: 'pNInz6obpgDQGcFmaJgB'
      );

      // Play the audio using just_audio
      await _audioPlayer.setFilePath(voicePath);
      _audioPlayer.play();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}

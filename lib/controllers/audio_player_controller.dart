import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:manifest/core/utils/toast_util.dart';
import 'package:manifest/models/playlist_tab_model/playlist_by_id_model.dart';

class JustAudioPlayerController extends GetxController {
  final player = AudioPlayer();
  var isPlaying = false.obs;
  var isLoading = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;
  var isCompleted = false.obs;
  String? currentUrl;

  // Add these new variables
  List<FileElement> playlist = [];
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();

    // Listen to player streams
    player.durationStream.listen((d) => duration.value = d ?? Duration.zero);
    player.positionStream.listen((p) => position.value = p);
    player.playingStream.listen((playing) => isPlaying.value = playing);

    // Handle audio completion
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        isCompleted.value = true; // Mark as completed
        isPlaying.value = false; // Ensure playing state is false
        Future.delayed(Duration(milliseconds: 100), () {
          player.seek(Duration.zero); // Reset to start
          player.pause(); // Pause after completion
        });
      }
    });

    // Listen for song completion
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        isCompleted.value = true;
        playNext(); // Automatically play next song
      }
    });

    // Listen for play/pause state changes
    player.playingStream.listen((playing) {
      isPlaying.value = playing;
    });
  }

  void setPlaylist(List<FileElement> urls) {
    playlist = urls;
    currentIndex = 0;
    playAtIndex(currentIndex);
  }

  Future<void> playNext() async {
    if (currentIndex < playlist.length - 1) {
      currentIndex++;
      playPause(playlist[currentIndex].antoniVoiceUrl.toString());
    }
  }

  Future<void> playPrevious() async {
    if (currentIndex > 0) {
      currentIndex--;
      playPause(playlist[currentIndex].antoniVoiceUrl.toString());
    }
  }

  Future<void> playAtIndex(int index) async {
    if (index >= 0 && index < playlist.length) {
      currentIndex = index;
      playPause(playlist[index].antoniVoiceUrl.toString());
    }
  }

  /// Play or pause the audio from a URL
  void playPause(String url) async {
    try {
      if (currentUrl != url) {
        // New audio source
        isLoading.value = true;
        isCompleted.value = false; // Reset completion state
        currentUrl = url;

        await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
        await player.play();
      } else {
        // Same audio source
        if (isCompleted.value) {
          // Reset and play from the beginning if completed
          isCompleted.value = false;
          await player.seek(Duration.zero);
          await player.play();
        } else if (isPlaying.value) {
          // Pause if currently playing
          await player.pause();
        } else {
          // Play if currently paused
          await player.play();
        }
      }
    } catch (e) {
      ToastUtil.error('Error playing audio: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Seek to a specific position in the audio
  void seek(Duration newPosition) {
    player.seek(newPosition);
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}

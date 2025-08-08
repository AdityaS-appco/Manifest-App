import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:manifest/controllers/affirmation_controller.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/models/home_model.dart';

class HomeMediaPlayerController extends GetxController {
  // for favorite
  AffirmationController affirmationController =
      Get.find<AffirmationController>();

  // media player Sliding upward and downward page controller
  PageController pageController = PageController(initialPage: 0);
  final player = AudioPlayer();
  late ConcatenatingAudioSource _playlist;

  @override
  void onInit() {
    super.onInit();
    // Listen to slider changes for playback speed
    // delayValue.listen((speed) {
    //   changePlaybackSpeed(speed);
    // });

    // Audio player state handling
    player.playerStateStream.listen((playerState) {
      if (playerState.processingState != ProcessingState.buffering &&
          playerState.processingState != ProcessingState.loading) {
        player.positionStream.listen((position) {
          if (player.duration != null && position >= player.duration!) {
            nextPage();
          }
        });
      }
    });

    // Set initial volume
    // player.setVolume(sliderValue.value);
  }

  // Media player
  Future<void> setupAudioPlayer1(PlayList playlist) async {
    int selectedIndex = 1;

    final List<Affirmations>? affirmations = playlist.affirmations;
    Map<String, List<String>> playlistsMap = {};

    if (affirmations != null && selectedIndex >= 0) {
      final List<List<String>> audioSources = [];

      int maxMusicTracks = 1;
      for (final affirmation in affirmations) {
        maxMusicTracks =
            max(maxMusicTracks, affirmation.typesOfVoices?.length ?? 0);
      }

      // Initialize audioSources list with empty lists
      for (int i = 0; i < maxMusicTracks; i++) {
        audioSources.add([]);
      }

      // Iterate through each affirmation
      for (int i = 0; i < affirmations.length; i++) {
        final Affirmations affirmation = affirmations[i];
        final List<TypesOfVoices>? typesOfVoices = affirmation.typesOfVoices;

        if (typesOfVoices != null) {
          // Iterate through typesOfVoices for this affirmation
          for (int j = 0; j < typesOfVoices.length; j++) {
            final TypesOfVoices voice = typesOfVoices[j];
            // Add the audio source to the corresponding music track list
            audioSources[j].add(
                voice.music.toString()); // Add only the music URL to the list
          }
        }
      }

      // Iterate over each playlist
      for (int k = 0; k < audioSources.length; k++) {
        String playlistName = 'Playlist ${k + 1}';
        playlistsMap[playlistName] = audioSources[k];
      }

      playlistsMap.forEach((playlistName, audioSources) {
        LogUtil.v('$playlistName:');
        LogUtil.v('$audioSources');
      });

      List<String> audioList =
          playlistsMap['Playlist $getSelectPlaylist']!.toList();

      // LogUtil.v('aaa $audioList');
      final List<AudioSource> audioSources2 = audioList
          .map((audioUrl) => AudioSource.uri(Uri.parse(audioUrl)))
          .toList();
      _playlist = ConcatenatingAudioSource(
        children: audioSources2,
        useLazyPreparation: true,
      );
      // await player.setAudioSource(_playlist);
      try {
        await player.setAudioSource(_playlist);
      } catch (e) {
        print('Error setting audio source: $e');
        // Handle error: stop audio playback and prevent moving to next page
        await pause();
        return;
      }
    } else {
      print('No affirmations found in the playlist');
    }
  }

  Future<void> play() async {
    await player.play();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> next() async {
    await player.seekToNext();
  }

  Future<void> previous() async {
    await player.seekToPrevious();
  }

  void updateVolume(double value) {
    double volume = value / 100; // Normalize the value to range 0.0 to 1.0
    player.setVolume(volume);
  }

  // void changePlaybackSpeed(double speed) {
  //   player.setSpeed(speed); // Adjust playback speed based on slider value
  // }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> playAgain() async {
    pageController.jumpToPage(0);
    await player.seek(Duration.zero,
        index: 0); // Seek to the beginning of the first audio in the playlist
    await player.play();
  }

  // Favorite Button at media player
  RxBool isEdit = false.obs;
  void setEditValue({required bool value}) {
    isEdit.value = value;
    LogUtil.v('$isEdit');
  }

  // Current Affirmation at media player
  Rx<Affirmations> currentAffirmation = Affirmations().obs;
  void setCurrentAffirmation(Affirmations value) {
    currentAffirmation.value = value;
  }

  //................................................................

  // Audio Settings
  RxBool isMusicOn = true.obs;
  RxBool switchBooster = false.obs;
  // background music slider
  RxDouble sliderValue = 50.0.obs;
  // affirmation voice slider
  // RxInt trackSliderValue = 30.obs;

  // Affirmation Delay Slider
  // final RxDouble delayValue = 2.0.obs;
  // final RxDouble containerWidth = 200.0.obs;
  // final double thumbSize = 10;
  // final double maxWidth = 300;
  //
  // void updateWidth(double dx, double width) {
  //   containerWidth.value += dx;
  //   if (containerWidth.value < 0) {
  //     containerWidth.value = 0;
  //   } else if (containerWidth.value > maxWidth - thumbSize) {
  //     containerWidth.value = maxWidth - thumbSize;
  //   }
  //   delayValue.value = containerWidth.value / maxWidth;
  // }
  final RxDouble delayValue = 10.0.obs; // Start at 0s
  final RxDouble containerWidth = 120.0.obs;
  final double thumbSize = 10;
  final double maxWidth =
      Get.size.width * 0.833; // Ensure you have kSize available

  void updateWidth(double dx, double width) {
    containerWidth.value += dx;
    if (containerWidth.value < 0) {
      containerWidth.value = 0;
    } else if (containerWidth.value > maxWidth - thumbSize) {
      containerWidth.value = maxWidth - thumbSize;
    }
    delayValue.value =
        (containerWidth.value / maxWidth) * 30 + 1; // Map width to 0-30 range
  }

  // void updateWidth(double dx, double width) {
  //   containerWidth.value += dx;
  //   if (containerWidth.value < 0) {
  //     containerWidth.value = 0;
  //   } else if (containerWidth.value > maxWidth - thumbSize) {
  //     containerWidth.value = maxWidth - thumbSize;
  //   }
  //   delayValue.value = containerWidth.value / maxWidth;
  // }

  var subliminalSliderValue = 4.0.obs;

  void updateSliderValue(double value) {
    subliminalSliderValue.value = value;
  }

  final RxInt _selectPlaylist = 1.obs;
  int get getSelectPlaylist => _selectPlaylist.value;
  void setSelectedPlaylist({required int value}) {
    _selectPlaylist.value = value;
    LogUtil.v('ddd $value');
    update();
  }

  void toggleMusic() {
    isMusicOn.value = !isMusicOn.value;
  }

  void toggleBooster() {
    // switchBooster.toggle();
  }

  // Subliminal levels slider for foreground audio
  // void increaseSubliminalSliderValue() {
  //   if (trackSliderValue.value < 100) {
  //     trackSliderValue.value++;
  //   }
  // }
  // void decreaseSubliminalSliderValue() {
  //   if (trackSliderValue.value > 0) {
  //     trackSliderValue.value--;
  //   }
  // }

  //Background music volume
  // void increaseSliderValue() {
  //   if (sliderValue.value < 100) {
  //     sliderValue.value++;
  //   }
  // }
  //
  // void decreaseSliderValue() {
  //   if (sliderValue.value > 0) {
  //     sliderValue.value--;
  //   }
  // }
}

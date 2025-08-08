import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:manifest/core/utils.dart';
import 'package:record/record.dart';

class AudioController extends GetxController {
  // AffirmationController affirmationController = Get.find<AffirmationController>();
  // // Audio Settings
  // RxBool isMusicOn = true.obs;
  // RxBool switchBooster = false.obs;
  // //Sliders
  // RxInt sliderValue = 50.obs;
  // RxInt trackSliderValue = 30.obs;
  //
  // final RxInt _selectPlaylist = 1.obs;
  // int get getSelectPlaylist => _selectPlaylist.value;
  // void setSelectedPlaylist({required int value}) {
  //   _selectPlaylist.value = value;
  //   LogUtil.i('ddd $value');
  //   update();
  // }
  //
  // void toggleMusic() {
  //   isMusicOn.value = !isMusicOn.value;
  // }
  //
  // void toggleBooster() {
  //   // switchBooster.toggle();
  // }
  //
  // // Subliminal levels
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
  //
  // //Background music volume
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
  //
  // // Favorite Button
  // RxBool isEdit = false.obs;
  // void setEditValue({required bool value}) {
  //   isEdit.value = value;
  //   LogUtil.w('$isEdit');
  // }
  //
  // final player = AudioPlayer();
  // late ConcatenatingAudioSource _playlist;
  // PageController pageController = PageController(initialPage: 0);
  //
  // Rx<Affirmations> currentAffirmation = Affirmations().obs;
  // void setCurrentAffirmation(Affirmations value) {
  //   currentAffirmation.value = value;
  // }

  // default audios playling
  // Future<void> setupAudioPlayer(PlayList playlist) async {
  //   final List<String?> audioUrls = playlist.affirmations!.map((affirmation) => affirmation.audio).toList();
  //   final List<AudioSource> audioSources = audioUrls.map((audioUrl) => AudioSource.uri(Uri.parse(audioUrl!))).toList();
  //   _playlist = ConcatenatingAudioSource(children: audioSources, useLazyPreparation: true);
  //   await player.setAudioSource(_playlist);
  // }

  // home media player testing
  // Future<void> setupAudioPlayer1(PlayList playlist) async {
  //   int selectedIndex = 1;
  //
  //   final List<Affirmations>? affirmations = playlist.affirmations;
  //   Map<String, List<String>> playlistsMap = {};
  //
  //   if (affirmations != null && selectedIndex >= 0) {
  //     final List<List<String>> audioSources = [];
  //
  //     int maxMusicTracks = 1;
  //     for (final affirmation in affirmations) {
  //       maxMusicTracks = max(maxMusicTracks, affirmation.typesOfVoices?.length ?? 0);
  //     }
  //
  //     // Initialize audioSources list with empty lists
  //     for (int i = 0; i < maxMusicTracks; i++) {
  //       audioSources.add([]);
  //     }
  //
  //     // Iterate through each affirmation
  //     for (int i = 0; i < affirmations.length; i++) {
  //       final Affirmations affirmation = affirmations[i];
  //       final List<TypesOfVoices>? typesOfVoices = affirmation.typesOfVoices;
  //
  //       if (typesOfVoices != null) {
  //         // Iterate through typesOfVoices for this affirmation
  //         for (int j = 0; j < typesOfVoices.length; j++) {
  //           final TypesOfVoices voice = typesOfVoices[j];
  //           // Add the audio source to the corresponding music track list
  //           audioSources[j].add(voice.music.toString()); // Add only the music URL to the list
  //         }
  //       }
  //     }
  //
  //     // Iterate over each playlist
  //     for (int k = 0; k < audioSources.length; k++) {
  //       String playlistName = 'Playlist ${k + 1}';
  //       playlistsMap[playlistName] = audioSources[k];
  //     }
  //
  //     playlistsMap.forEach((playlistName, audioSources) {
  //       LogUtil.w('$playlistName:');
  //       LogUtil.w('$audioSources');
  //     });
  //
  //     LogUtil.w('eee $getSelectPlaylist');
  //     List<String> audioList = playlistsMap['Playlist $getSelectPlaylist']!.toList();
  //
  //     // LogUtil.w('aaa $audioList');
  //     final List<AudioSource> audioSources2 = audioList.map((audioUrl) => AudioSource.uri(Uri.parse(audioUrl))).toList();
  //     _playlist = ConcatenatingAudioSource(children: audioSources2, useLazyPreparation: true);
  //     LogUtil.w('Audio player setup completed');
  //     await player.setAudioSource(_playlist);
  //   } else {
  //     print('No affirmations found in the playlist');
  //   }
  // }
  //
  // Future<void> play() async {
  //   await player.play();
  // }
  //
  // Future<void> pause() async {
  //   await player.pause();
  // }
  //
  // Future<void> next() async {
  //   await player.seekToNext();
  // }
  //
  // Future<void> previous() async {
  //   await player.seekToPrevious();
  // }

  // void nextPage() {
  //   pageController.nextPage(
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeIn,
  //   );
  // }

  /// Voice Recorder
  int recordDuration = 0;
  Timer? _timer;
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      update();
    });
  }

  Record record = Record();
  RxBool recordingStarted = false.obs;
  RxBool recordingPlaying = false.obs;
  String? audioFilePath;
  String? audioFile;
  RxBool isPlaying = false.obs;
  var currentIndex = (-1).obs;

  void setPlayingValue({required bool value}) {
    isPlaying.value = value;
    LogUtil.w('isPlaying: $isPlaying');
    update();
  }

  // _writeFileToStorage() async {
  //   File audioFileStorage = File(audioFile!);
  //   Uint8List bytes = await audioFileStorage.readAsBytes();
  //   audioFileStorage.writeAsBytes(bytes);
  //   LogUtil.w("saved to Storage: ${audioFileStorage.path} ");
  // }
  //
  // /// get path from directory
  // getPath() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = directory.path;
  //   return path;
  // }
  //
  // startRecording() async {
  //   recordingStarted = true.obs;
  //   update();
  //   String path = await getPath();
  //   audioFilePath = '$path/${DateTime.now().toString()}.mp4';
  //   if (await record.hasPermission()) {
  //     LogUtil.w(' file path: $audioFilePath  directory path: $path');
  //     await record.start(
  //       path: audioFilePath,
  //       encoder: AudioEncoder.aacLc, // by default
  //       bitRate: 128000, // by default
  //       samplingRate: 44100,
  //     );
  //     _startTimer();
  //     record.onStateChanged();
  //     audioFile = audioFilePath;
  //     await _writeFileToStorage();
  //   } else {
  //     Permission.microphone.request();
  //     startRecording();
  //   }
  // }
  //
  // stopRecording() async {
  //   _timer?.cancel();
  //   recordDuration = 0;
  //   recordingStarted = false.obs;
  //   await record.stop();
  //   update();
  // }

  final AudioPlayer _audioPlayer = AudioPlayer();

  // Track loading state for individual items
  final RxMap<String, bool> itemLoadingStates = <String, bool>{}.obs;
  final RxMap<String, bool> itemPlayingStates = <String, bool>{}.obs;
  final RxString currentPlayingItemId = RxString('');

  bool isItemLoading(String itemId) {
    return itemLoadingStates[itemId] ?? false;
  }

  bool isItemPlaying(String itemId) {
    return itemPlayingStates[itemId] ?? false;
  }

  void setItemLoadingState(String itemId, bool isLoading) {
    itemLoadingStates[itemId] = isLoading;
    update();
  }

  void setItemPlayingState(String itemId, bool isPlaying) {
    if (isPlaying) {
      // Stop any currently playing item
      if (currentPlayingItemId.value.isNotEmpty &&
          currentPlayingItemId.value != itemId) {
        itemPlayingStates[currentPlayingItemId.value] = false;
      }
      currentPlayingItemId.value = itemId;
    } else if (currentPlayingItemId.value == itemId) {
      currentPlayingItemId.value = '';
    }
    itemPlayingStates[itemId] = isPlaying;
    this.isPlaying.value = isPlaying;
    update();
  }

  Future<void> loadAudio({required String filePath}) async {
    try {
      // Load the audio file from the local path
      await _audioPlayer.setFilePath(filePath);
      LogUtil.i('voice loaded');
    } catch (e) {
      // Handle any errors
      LogUtil.e('Error loading audio: $e');
    }
  }

  Future<void> loadAudio1({required String filePath}) async {
    try {
      // Load the audio file
      await _audioPlayer.setUrl(audioFile!);
      LogUtil.i('voice loaded');
    } catch (e) {
      // Handle any errors
      LogUtil.e('Error loading audio: $e');
    }
  }

  Future<void> loadAudioUrl({required String filePath, String? itemId}) async {
    try {
      if (filePath.isEmpty || !Uri.parse(filePath).isAbsolute) {
        throw Exception('Invalid audio URL');
      }

      if (itemId != null) {
        setItemLoadingState(itemId, true);
      }
      isSinglePlayLoading.value = true;

      // Check if URL is accessible
      final uri = Uri.parse(filePath);
      final client = HttpClient();
      final request = await client.headUrl(uri);
      final response = await request.close();

      if (response.statusCode != 200) {
        throw Exception('Failed to access audio URL: ${response.statusCode}');
      }

      await _audioPlayer.setUrl(filePath);
      // Set loop mode based on isLoop value
      await _audioPlayer
          .setLoopMode(isLoop.value ? LoopMode.one : LoopMode.off);
      isAudioLoadDone.value = true;
      LogUtil.i('voice loaded: $filePath');
    } catch (e) {
      LogUtil.e('Error loading audio: $e');
      setPlayingValue(value: false);
      if (itemId != null) {
        setItemPlayingState(itemId, false);
      }
      isAudioLoadDone.value = false;
      rethrow;
    } finally {
      isSinglePlayLoading.value = false;
      if (itemId != null) {
        setItemLoadingState(itemId, false);
      }
    }
  }

  void playAudio() async {
    setPlayingValue(value: true);
    // loadAudio(filePath: audioFile!);
    await loadAudio1(filePath: audioFile!);
    _audioPlayer.play();
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        stopAudio();
      }
    });
  }

  void pauseAudio() {
    setPlayingValue(value: false);
    _audioPlayer.pause();
  }

  void stopAudio() {
    setPlayingValue(value: false);
    _audioPlayer.stop();
  }

  void emptyAudioFile() {
    audioFile = null;
  }

  void playAudi() async {
    LogUtil.i("playing single audio called");
    if (currentPlayingItemId.value.isNotEmpty) {
      setItemPlayingState(currentPlayingItemId.value, true);
      setPlayingValue(value: true);
      await _audioPlayer.play();
      LogUtil.i("isPlaying: ${isPlaying.value}");
    }
  }

  void pauseAudi() {
    LogUtil.i("pause single audio called");
    if (currentPlayingItemId.value.isNotEmpty) {
      setItemPlayingState(currentPlayingItemId.value, false);
      setPlayingValue(value: false);
      _audioPlayer.pause();
      LogUtil.i("isPlaying: ${isPlaying.value}");
    }
  }

  void stopAudi() {
    if (currentPlayingItemId.value.isNotEmpty) {
      setItemPlayingState(currentPlayingItemId.value, false);
      setPlayingValue(value: false);
      _audioPlayer.stop();
    }
  }

  @override
  void onInit() {
    super.onInit();
    // player.playerStateStream.listen((playerState) {
    //   if (playerState.processingState != ProcessingState.buffering && playerState.processingState != ProcessingState.loading) {
    //     player.positionStream.listen((position) {
    //       if (player.duration != null && position >= player.duration!) {
    //         nextPage();
    //       }
    //     });
    //   }
    // });
    /// single audio listen
    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((playerState) {
      final processingState = playerState.processingState;
      final playing = playerState.playing;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        isSinglePlayLoading.value = true;
        isBuffering.value = processingState == ProcessingState.buffering;
      } else if (processingState == ProcessingState.ready) {
        isSinglePlayLoading.value = false;
        isAudioLoadDone.value = true;
      } else if (processingState == ProcessingState.completed) {
        isSinglePlayLoading.value = false;
        isAudioLoadDone.value = true;
        stopAudi();
      }
      isPlaying.value = playing;
    });

    /// playlist listen
    playerOfPlaylist.processingStateStream.listen((processingState) async {
      LogUtil.i("Processing State: $processingState");
      if (processingState == ProcessingState.loading) {
        LogUtil.i('ProcessingState.loading');
        isPlayLoading.value = true;
        isPlayListLoadDone.value = false;
      } else if (processingState == ProcessingState.buffering) {
        LogUtil.i('ProcessingState.buffering}');
        isPlayLoading.value = true;
      } else if (processingState == ProcessingState.ready) {
        LogUtil.i('ProcessingState.ready}');
        isPlayLoading.value = false;
        isPlaying.value = true;
        isPlayListLoadDone.value = true;
        playPlaylist();
      } else if (processingState == ProcessingState.completed) {
        LogUtil.i('ProcessingState.completed');
        await stopPlaylist();
        isPlayListLoadDone.value = true;
        isPlayLoading.value = false;
      }
    });
  }

  @override
  void onClose() {
    // Dispose of the audio player when the controller is disposed
    _audioPlayer.dispose();
    super.onClose();
  }

  /// Single audio play
  var isSinglePlayLoading = false.obs;
  var isAudioLoadDone = false.obs;
  var isBuffering = false.obs;
  // by url
  // Removed duplicate loadAudioUrl method

  /// playlist play
  Rx<bool> isLoop = false.obs;
  void setLoop(value) {
    isLoop.value = value;
    if (value) {
      _audioPlayer.setLoopMode(LoopMode.one);
    } else {
      _audioPlayer.setLoopMode(LoopMode.off);
    }
  }

  final playerOfPlaylist = AudioPlayer();
  late ConcatenatingAudioSource _playlistOf;

// by assets
  Future<void> setupAudioPlayerPlaylistAsset(
      {required List<String> playlist}) async {
    List<String> musicAssets = [
      'assets/audio/music1.mp3',
      'assets/audio/music2.mp3',
      'assets/audio/music3.mp3'
    ];
    final List<String> audioPaths =
        playlist.isNotEmpty ? playlist : musicAssets;
    final List<AudioSource> audioSources =
        audioPaths.map((audioPath) => AudioSource.asset((audioPath))).toList();
    ConcatenatingAudioSource playlistSource = ConcatenatingAudioSource(
        children: audioSources, useLazyPreparation: true);

    await playerOfPlaylist.setAudioSource(playlistSource);

    if (isLoop.value == true) {
      playerOfPlaylist.setLoopMode(LoopMode.all);
    }
  }

  // by url
  var isPlayLoading = false.obs;
  var isPlayListLoadDone = false.obs;
  Future<void> setupAudioPlayerPlaylist(
      {required List<String> playlist}) async {
    final List<AudioSource> audioSources = playlist
        .map((audioUrl) => AudioSource.uri(Uri.parse(audioUrl)))
        .toList();
    _playlistOf = ConcatenatingAudioSource(
        children: audioSources, useLazyPreparation: true);
    playerOfPlaylist.setAudioSource(_playlistOf);

    if (isLoop.value == true) {
      playerOfPlaylist.setLoopMode(LoopMode.all);
    }
  }

  Future<void> playPlaylist() async {
    LogUtil.i("playPlaylist called");
    setPlayingValue(value: true);
    await playerOfPlaylist.play();
    isPlaying.value = true;
    isPlayLoading.value = false; // Stop loading when play starts
    LogUtil.i("isPlaying: ${isPlaying.value}");
  }

  Future<void> pausePlaylist() async {
    LogUtil.i("pausePlaylist called");
    setPlayingValue(value: false);
    await playerOfPlaylist.pause();
    isPlaying.value = false;
    isPlayLoading.value = false;
    LogUtil.i("isPlaying: ${isPlaying.value}");
  }

  Future<void> stopPlaylist() async {
    LogUtil.i("stopPlaylist called");
    setPlayingValue(value: false);
    await playerOfPlaylist.stop();
    isPlaying.value = false;
    isPlayLoading.value = false;
    LogUtil.i("isPlaying: ${isPlaying.value}");
  }

  Future<void> seekToStart() async {
    await playerOfPlaylist.seek(Duration.zero);
  }
}

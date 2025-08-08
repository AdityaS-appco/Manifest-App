import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/core/shared/widgets/dialogs/app_dialogs.dart';
import 'package:manifest/core/utils/toast_util.dart';
import 'package:manifest/features/playlist/by_you/services/remote_audio_service.dart';
import 'package:manifest/features/media_player/widgets/media_player_loop_option_sheet.dart';
import 'package:manifest/features/media_player/widgets/sleep_timer_sheet.dart';
import 'package:manifest/models/playlist_tab_model/my_collections/my_collections_model.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/all/my_collection/collection_detail_screen_controller.dart';

enum PlayerState {
  playing, // Currently playing an affirmation
  paused, // Paused and can be resumed from current position
  stopped // Completely stopped, should restart from beginning
}

class CollectionAudioController extends BaseController {
  final RemoteAudioService _audioService = RemoteAudioService();
  final CollectionDetailScreenController _collectionController =
      Get.find<CollectionDetailScreenController>();

  // Player state variables
  Rx<PlayerState> playerState = PlayerState.stopped.obs;
  RxBool isPlayingCollection = false.obs;
  RxBool isLoadingAudio = false.obs;
  RxInt currentAffirmationIndex = 0.obs;

  // Feature flags
  RxBool isPlayerStopTimerActive = false.obs;
  RxBool isLoopEnabled = false.obs;
  RxInt loopCount = 0.obs;
  RxBool isCollectionFavorite = false.obs;
  RxBool isCollectionDownloaded = false.obs;

  // Audio duration tracking
  RxDouble currentDuration = 0.0.obs;
  RxDouble totalDuration = 0.0.obs;
  Timer? _durationUpdateTimer;

  // Currently playing affirmation
  Rx<CollectionAffirmations?> currentlyPlayingAffirmation =
      Rx<CollectionAffirmations?>(null);

  // Helper getters
  RxBool get isPlayingAffirmation =>
      RxBool(playerState.value == PlayerState.playing);
  Collection? get collection => _collectionController.collection.value;

  // Timer related variables
  Timer? _audioTimer;
  RxInt selectedDurationInMinutes = 0.obs;

  // Audio state streams
  Stream<bool> get isPlaying => _audioService.playingStream;
  Stream<bool> get isLoadingAudioStream =>
      _audioService.processingStateStream.map((state) =>
          state == ProcessingState.loading ||
          state == ProcessingState.buffering);

  @override
  void onInit() async {
    super.onInit();
    await _initAudioStreams();
  }

  Future<void> _initAudioStreams() async {
    /// * Listen to playing state changes
    _audioService.playingStream.listen((playing) {
      if (playing) {
        playerState.value = PlayerState.playing;
        _startDurationTracking();
      } else if (playerState.value == PlayerState.playing) {
        playerState.value = PlayerState.paused;
        _stopDurationTracking();
      }
    });

    /// * Listen to processing state changes
    _audioService.processingStateStream.listen((state) {
      isLoadingAudio.value = state == ProcessingState.loading ||
          state == ProcessingState.buffering;
      if (state == ProcessingState.completed) {
        _onAffirmationCompleted();
      }
    });

    /// * Listen to duration updates
    _audioService.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration.value = duration.inMilliseconds.toDouble();
      }
    });

    /// * Listen to position updates
    _audioService.positionStream.listen((position) {
      currentDuration.value = position.inMilliseconds.toDouble();
    });
  }

  void _startDurationTracking() {
    _durationUpdateTimer?.cancel();
    _durationUpdateTimer =
        Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (playerState.value != PlayerState.playing) {
        _stopDurationTracking();
        return;
      }
    });
  }

  void _stopDurationTracking() {
    _durationUpdateTimer?.cancel();
    _durationUpdateTimer = null;
  }

  @override
  void onClose() {
    _cancelAudioTimer();
    _stopDurationTracking();
    _audioService.dispose();
    super.onClose();
  }

  /// * Collection Control Methods
  /// * Called when the main collection play button is pressed
  Future<void> onCollectionPlay() async {
    try {
      final affirmations = collection?.affirmations;
      if (affirmations == null || affirmations.isEmpty) return;

      isPlayingCollection.value = true;

      /// * If we already have a current affirmation set, resume or play it
      if (currentlyPlayingAffirmation.value != null) {
        if (playerState.value == PlayerState.paused) {
          /// * Resume current affirmation
          await _audioService.toggleSingleAudioPlayPause();
          playerState.value = PlayerState.playing;
        } else {
          /// * Play from beginning or play a stopped affirmation
          await _playAffirmation(currentlyPlayingAffirmation.value!);
        }
      } else {
        /// * No current affirmation, start from the first affirmation
        currentAffirmationIndex.value = 0;
        currentlyPlayingAffirmation.value = affirmations[0];
        await _playAffirmation(affirmations[0]);
      }
    } catch (e) {
      LogUtil.log('Error in onCollectionPlay: $e');
    }
  }

  Future<void> onCollectionPause() async {
    if (currentlyPlayingAffirmation.value != null) {
      await onAffirmationPause();
    }
    isPlayingCollection.value = false;
  }

  Future<void> toggleCollectionPlayPause() async {
    if (isPlayingCollection.value ||
        playerState.value == PlayerState.playing ||
        isPlayingAffirmation.value) {
      await onCollectionPause();
    } else {
      await onCollectionPlay();
    }
  }

  /// * Affirmation Control Methods
  Future<void> onAffirmationPlay(int affirmationId) async {
    try {
      final affirmations = collection?.affirmations;
      if (affirmations == null) return;

      final affirmationIndex =
          affirmations.indexWhere((a) => a.id == affirmationId);
      if (affirmationIndex == -1) return;

      final affirmation = affirmations[affirmationIndex];

      /// * Case 1: Currently playing - stop current playback first
      if (playerState.value == PlayerState.playing) {
        if (currentlyPlayingAffirmation.value?.id == affirmation.id) {
          /// * Same affirmation is already playing, do nothing
          return;
        }

        /// * Different affirmation, pause current first
        await onAffirmationPause();
      }

      /// * Case 2: Paused with same affirmation - resume playback
      if (playerState.value == PlayerState.paused &&
          currentlyPlayingAffirmation.value?.id == affirmation.id) {
        await _audioService.toggleSingleAudioPlayPause();
        playerState.value = PlayerState.playing;
        return;
      }

      /// * Case 3: New affirmation or stopped state - start fresh playback
      currentAffirmationIndex.value = affirmationIndex;
      currentlyPlayingAffirmation.value = affirmation;
      await _playAffirmation(affirmation);
      playerState.value = PlayerState.playing;
    } catch (e) {
      LogUtil.log('Error in onAffirmationPlay: $e');
    }
  }

  Future<void> onAffirmationPause() async {
    if (playerState.value == PlayerState.playing) {
      await _audioService.pauseSingleAudio();
      playerState.value = PlayerState.paused;
    }
  }

  /// * Called when a user taps the play button on a specific affirmation in the list
  Future<void> toggleSingleAffirmationPlayPause(int affirmationId) async {
    try {
      final affirmations = collection?.affirmations;
      if (affirmations == null) return;

      final affirmationIndex =
          affirmations.indexWhere((a) => a.id == affirmationId);
      if (affirmationIndex == -1) return;

      final selectedAffirmation = affirmations[affirmationIndex];
      final isSelectedAffirmationCurrentlyPlaying =
          currentlyPlayingAffirmation.value?.id == affirmationId;

      /// * Case 1: Selected affirmation is currently playing - pause it
      if (isSelectedAffirmationCurrentlyPlaying &&
          playerState.value == PlayerState.playing) {
        await onAffirmationPause();
        return;
      }

      /// * Case 2: Selected affirmation is paused - resume it
      if (isSelectedAffirmationCurrentlyPlaying &&
          playerState.value == PlayerState.paused) {
        /// * Resume the same affirmation
        await _audioService.toggleSingleAudioPlayPause();
        playerState.value = PlayerState.playing;
        return;
      }

      /// * Case 3: Different affirmation is playing or nothing is playing
      /// * Stop any current playback first
      if (playerState.value == PlayerState.playing) {
        await onAffirmationPause();
      }

      /// * If we were in collection mode, exit it when manually selecting an affirmation
      if (isPlayingCollection.value) {
        isPlayingCollection.value = false;
      }

      /// * Play the selected affirmation
      currentAffirmationIndex.value = affirmationIndex;
      currentlyPlayingAffirmation.value = selectedAffirmation;
      await _playAffirmation(selectedAffirmation);
      playerState.value = PlayerState.playing;
    } catch (e) {
      LogUtil.log('Error in toggleSingleAffirmationPlayPause: $e');
    }
  }

  /// * Called when an affirmation finishes playing
  Future<void> _onAffirmationCompleted() async {
    try {
      final affirmations = collection?.affirmations;
      if (affirmations == null || affirmations.isEmpty) return;

      // Check if we're at the last affirmation
      if (currentAffirmationIndex.value < affirmations.length - 1) {
        // Not the last affirmation, continue to next one
        final nextIndex = currentAffirmationIndex.value + 1;
        currentAffirmationIndex.value = nextIndex;
        currentlyPlayingAffirmation.value = affirmations[nextIndex];

        // Play the next affirmation
        await _playAffirmation(affirmations[nextIndex]);
      } else {
        // This was the last affirmation
        if (isLoopEnabled.value && loopCount.value > 0) {
          // Decrement loop count first
          loopCount.value--;

          // Update loop state (might disable looping if count reaches 0)
          _updateLoopState();

          if (isLoopEnabled.value) {
            // Reset to first affirmation
            currentAffirmationIndex.value = 0;
            currentlyPlayingAffirmation.value = affirmations[0];

            // Play first affirmation
            await _playAffirmation(affirmations[0]);
          } else {
            // Loop completed (count reached zero)
            await _resetToStart();
          }
        } else {
          // No looping or loop disabled
          await _resetToStart();
        }
      }
    } catch (e) {
      LogUtil.log('Error in _onAffirmationCompleted: $e');
    }
  }

  /// Helper to check and update loop state
  void _updateLoopState() {
    if (loopCount.value <= 0) {
      isLoopEnabled.value = false;
      _cancelAudioLoop();
      ToastUtil.success('Collection playback loop completed!');
    }
  }

  /// Helper to reset to start without playing
  Future<void> _resetToStart() async {
    // Reset playback state
    isPlayingCollection.value = false;
    playerState.value = PlayerState.stopped;

    // Stop current playback
    await _audioService.pauseSingleAudio();

    // Reset UI state
    _stopDurationTracking();
    currentDuration.value = 0;

    // Reset to first affirmation
    if (collection?.affirmations?.isNotEmpty == true) {
      currentAffirmationIndex.value = 0;
      currentlyPlayingAffirmation.value = collection?.affirmations?[0];

      // Load first affirmation's audio but don't play it
      final firstAffirmation = collection!.affirmations![0];
      await _loadAffirmationAudio(firstAffirmation);
    }
  }

  /// Helper to load affirmation audio without playing
  Future<bool> _loadAffirmationAudio(CollectionAffirmations affirmation) async {
    try {
      bool sourceSet = false;

      // Try to load from adamVoiceUrl first if available
      if (affirmation.adamVoiceUrl?.isNotEmpty == true) {
        await _audioService.loadPlaylist([affirmation.adamVoiceUrl!]);
        sourceSet = true;
      }
      // If not available, try to extract from subForm
      // else if (affirmation.subForm?.isNotEmpty == true) {
      //   try {
      //     final List<dynamic> subFormData = json.decode(affirmation.subForm!);
      //     if (subFormData.isNotEmpty && subFormData[0].containsKey('appendAudio')) {
      //       final String audioUrl = subFormData[0]['appendAudio'];
      //       await _audioService.loadPlaylist([audioUrl]);
      //       sourceSet = true;
      //     }
      //   } catch (e) {
      //     AppLogger.log('Error parsing audio URL from subForm: $e');
      //   }
      // }

      return sourceSet;
    } catch (e) {
      LogUtil.log('Error in _loadAffirmationAudio: $e');
      return false;
    }
  }

  /// Play an affirmation
  Future<void> _playAffirmation(CollectionAffirmations affirmation) async {
    try {
      currentlyPlayingAffirmation.value = affirmation;
      bool playbackStarted = false;

      // Try to play from adamVoiceUrl first if available
      if (affirmation.adamVoiceUrl?.isNotEmpty == true) {
        await _audioService.loadAndPlaySingleAudio(affirmation.adamVoiceUrl!);
        playbackStarted = true;
      }
      // If not available, try to extract from subForm
      else if (affirmation.subForm?.isNotEmpty == true) {
        try {
          final List<dynamic> subFormData = json.decode(affirmation.subForm!);
          if (subFormData.isNotEmpty &&
              subFormData[0].containsKey('appendAudio')) {
            final String audioUrl = subFormData[0]['appendAudio'];
            await _audioService.loadAndPlaySingleAudio(audioUrl);
            playbackStarted = true;
          }
        } catch (e) {
          LogUtil.log('Error parsing audio URL from subForm: $e');
        }
      }

      // Handle failed playback
      if (!playbackStarted) {
        LogUtil.log(
            'Failed to start playback for affirmation: ${affirmation.title}');
        if (isPlayingCollection.value) {
          // In collection mode, try next affirmation if this one fails
          await _onAffirmationCompleted();
        } else {
          // In single affirmation mode, just reset
          playerState.value = PlayerState.stopped;
        }
      }
    } catch (e) {
      LogUtil.log('Error in _playAffirmation: $e');
    }
  }

  /// * Timer Functionality (Enhanced)
  /// * Handle the timer control button press
  Future<void> onTimerPressed() async {
    /// * if the timer is already active, cancel it
    if (isPlayerStopTimerActive.value) {
      cancelAudioTimer();
      ToastUtil.info('Collection playback sleep timer cancelled!');
      return;
    }

    /// * else show the timer sheet
    await Get.bottomSheet(
      SleepTimerSheet(
        onTimerOptionSelect: onTimerOptionTap,
        selectedDurationInMinutes: selectedDurationInMinutes.value,
      ),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }

  /// * Handles the timer option tap
  void onTimerOptionTap(Duration duration) {
    selectedDurationInMinutes.value = duration.inMinutes;
    setTimer(duration.inMinutes, onTimerComplete: () {
      ToastUtil.info(
        'Collection playback stopped by sleep timer!',
      );
    });

    /// * close the options menu
    Get.back();

    /// * show a snackbar
    ToastUtil.info('Pause audio after ${duration.inMinutes} minute(s)!');
  }

  /// * Sets a timer for the given duration in minutes
  void setTimer(int minutes, {VoidCallback? onTimerComplete}) {
    _audioTimer?.cancel();

    /// * if minutes > 0, enable the timer
    if (minutes > 0) {
      isPlayerStopTimerActive.value = true;

      /// * Start the timer
      _audioTimer = Timer(Duration(minutes: minutes), () async {
        /// * as the timer is up,
        /// * 1. pause the affirmation
        await onAffirmationPause();

        /// * 2. update the isTimerEnabled flag
        isPlayerStopTimerActive.value = false;

        /// * 3. invoke the onTimerComplete callback
        onTimerComplete?.call();
      });
    }

    /// * if minutes <= 0, disable the timer
    else {
      isPlayerStopTimerActive.value = false;
    }
  }

  /// * Cancel the current timer
  void cancelAudioTimer() {
    _audioTimer?.cancel();
    _audioTimer = null;
    isPlayerStopTimerActive.value = false;
  }

  /// * Aliased method for backward compatibility
  void _cancelAudioTimer() {
    cancelAudioTimer();
  }

  /// * Loop Functionality (Enhanced)
  /// ! Handles the loop option tap
  void toggleLoopMode() {
    /// * if already enabled, disable it
    if (isLoopEnabled.value) {
      /// * cancel the loop
      _cancelAudioLoop();

      /// * display toast
      ToastUtil.info('Collection playback loop cancelled!');

      return;
    }

    /// * if not already enabled, show the loop option sheet
    Get.bottomSheet(
      MediaPlayerLoopOptionSheet(onLoopSet: _onLoopSet),
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }

  /// ! Handle loop count selection
  /// * 1. change isLoopEnabled flag to true
  /// * 2. update the loop count
  /// * 3. show toast
  void _onLoopSet(int count) {
    isLoopEnabled.value = true;
    loopCount.value = count;
    ToastUtil.info('Collection will be repeated $count times!');
  }

  /// ! Cancel the current loop
  void _cancelAudioLoop() {
    _audioService.setLoopMode(false);
    loopCount.value = 0;
    isLoopEnabled.value = false;
  }

  /// ! action button 3
  /// * toggle favorite collection
  void toggleFavoriteCollection() {
    /// todo: add or remove from favorite collection [api call]
    /// update the isCollectionFavorite flag
    isCollectionFavorite.toggle();
  }

  /// ! action button 4
  /// * download collection
  void downloadCollection() {
    /// todo: implement logic to download collection
    /// update the isCollectionDownloaded flag
    isCollectionDownloaded.toggle();
  }

  // Helper method to get all audio URLs from the collection
  List<String> getAllAudioUrls() {
    List<String> audioUrls = [];
    final affirmations = collection?.affirmations;

    if (affirmations != null) {
      for (var affirmation in affirmations) {
        // First try adamVoiceUrl
        if (affirmation.adamVoiceUrl?.isNotEmpty == true) {
          audioUrls.add(affirmation.adamVoiceUrl!);
          continue;
        }

        // If not available, try to extract from subForm
        try {
          if (affirmation.subForm != null) {
            final List<dynamic> subFormData = json.decode(affirmation.subForm!);
            if (subFormData.isNotEmpty &&
                subFormData[0].containsKey('appendAudio')) {
              audioUrls.add(subFormData[0]['appendAudio']);
            }
          }
        } catch (e) {
          LogUtil.log('Error parsing audio URL from subForm: $e');
        }
      }
    }

    return audioUrls;
  }

  // Load and play all affirmations as a playlist
  Future<void> loadAndPlayAllAffirmations() async {
    try {
      final audioUrls = getAllAudioUrls();
      if (audioUrls.isEmpty) return;

      await _audioService.loadAndPlayPlaylist(audioUrls);
      isPlayingCollection.value = true;
      playerState.value = PlayerState.playing;
      currentAffirmationIndex.value = 0;
      currentlyPlayingAffirmation.value = collection?.affirmations?[0];
    } catch (e) {
      LogUtil.log('Error in loadAndPlayAllAffirmations: $e');
    }
  }
}

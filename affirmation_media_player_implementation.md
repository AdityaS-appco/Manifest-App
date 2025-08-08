
# Affirmation Media Player Implementation Guide

## Overview
This document provides step-by-step instructions for implementing the affirmation media player functionality with proper handling of playback, delay, and loop features.

## Core Components

### 1. Key Controllers
- `MediaPlayerController`: Main controller handling playback logic
- `AudioSettingsController`: Manages audio settings and delay configurations

### 2. Key Variables
```dart
// In MediaPlayerController
final isPlaying = false.obs;
final isInDelay = false.obs;
Timer? _delayTimer;
final delayTimeRemaining = Duration.zero.obs;
Timer? _delayCountdownTimer;
final loopCount = 0.obs;
final isLoopEnabled = false.obs;
```

## Implementation Steps

### 1. Initial Setup
```dart
void onInit() async {
  isLoading.value = true;
  await _initSoundscapePlayer();
  await _getTracksById(trackId);
  await _initVideoPlayer();
  await _initAffirmationPlayer();
  _initBoosterPlayer();
  _initAudioPlayerListeners();
  _initAudioSettingListeners();
  _playMindMovie();
  
  if (track?.affirmations?.isNotEmpty == true) {
    playAffirmation();
  }
  isLoading.value = false;
}
```

### 2. Playback Control Implementation
```dart
Future<void> playAffirmation() async {
  if (affirmationPlayer.playerState.processingState == ProcessingState.ready && !isPlaying.value) {
    isPlaying.value = true;
    if (isInDelay.value) {
      handleDelayResume();
    } else {
      await affirmationPlayer.play();
    }
  }
}

Future<void> pauseAffirmation() async {
  if (isPlaying.value) {
    isPlaying.value = false;
    await affirmationPlayer.pause();
    _cancelDelayTimers();
  }
}
```

### 3. Delay Handling
```dart
void handleAffirmationComplete() {
  final delay = _audioSettingsController.currentAffirmationDelay.value;
  
  if (delay > 0 && isPlaying.value) {
    startDelayTimer(delay);
  } else {
    handleNextAffirmation();
  }
}

void startDelayTimer(double delay) {
  isInDelay.value = true;
  final delayMs = (delay * 1000).toInt();
  delayTimeRemaining.value = Duration(milliseconds: delayMs);
  
  // Update UI every 50ms for smooth animation
  _delayCountdownTimer = Timer.periodic(
    const Duration(milliseconds: 50),
    updateDelayUI
  );
  
  _delayTimer = Timer(
    Duration(milliseconds: delayMs),
    handleDelayComplete
  );
}
```

### 4. Loop Functionality
```dart
void handleLastAffirmationComplete() {
  if (isLoopEnabled.value && loopCount.value > 0) {
    loopCount.value--;
    _updateLoopState();
    if (isLoopEnabled.value) {
      _playFromFirstAffirmation();
    } else {
      _resetToStart();
    }
  } else {
    _resetToStart();
  }
}
```

### 5. UI Updates
```dart
Widget buildMediaPlayerButton() {
  return Obx(() {
    final progress = controller.isInDelay.value
      ? (controller.currentPosition.inMilliseconds / controller.currentDuration.inMilliseconds)
      : (controller.position.value.inMilliseconds / controller.duration.value.inMilliseconds);
    
    return MediaPlayerButton(
      isPlaying: controller.isPlaying,
      progress: progress,
      progressColor: controller.isInDelay.value ? AppColors.primary : AppColors.light,
      // ... other properties
    );
  });
}
```

## Key Features

### 1. Smooth Delay Handling
- Track delay time in milliseconds
- Update UI every 50ms for smooth progress animation
- Pause/resume capability during delay period

### 2. Loop Management
- Decrement loop count after completing full playlist
- Automatic transition to first affirmation
- Proper state management for loop enabling/disabling

### 3. Progress Visualization
- Show affirmation progress during playback
- Show delay progress during wait periods
- Different colors for playback vs delay states

## Common Issues and Solutions

### 1. Playback Continuity
```dart
void _cancelDelayTimers() {
  _delayTimer?.cancel();
  _delayCountdownTimer?.cancel();
  isInDelay.value = false;
  delayTimeRemaining.value = Duration.zero;
}
```

### 2. Smooth Animations
```dart
Future<void> _animateToPage(int page) async {
  await pageController.animateToPage(
    page,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
  );
}
```

## Testing Checklist

1. Playback Control
   - [ ] Play/pause functionality
   - [ ] Smooth transition between affirmations
   - [ ] Proper delay handling

2. Loop Functionality
   - [ ] Loop count decrementation
   - [ ] Proper reset after loop completion
   - [ ] Smooth transition to first affirmation

3. UI Response
   - [ ] Progress bar updates
   - [ ] Delay visualization
   - [ ] Smooth page transitions

4. Error Handling
   - [ ] Audio loading errors
   - [ ] Network connectivity issues
   - [ ] Resource cleanup on disposal

## Resources

- Just Audio package documentation
- GetX state management guide
- Flutter animation guides

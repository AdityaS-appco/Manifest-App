# Playlist Media Player Implementation Documentation

This document provides a comprehensive explanation of the playlist media player implementation for a Flutter application. The implementation includes audio playback functionality for both individual tracks and playlists, with features such as track control, playlist navigation, timer functionality, looping, favorites, and downloads.

## Table of Contents

1. [Data Models](#data-models)
2. [Architecture](#architecture)
3. [Core Components](#core-components)
4. [State Management](#state-management)
5. [Player Functionality](#player-functionality)
6. [User Interface](#user-interface)
7. [Advanced Features](#advanced-features)
8. [Storage Implementation](#storage-implementation)

## Data Models

### Affirmation Model

The application uses an `Affirmation` class to represent individual audio recordings:

```dart
class Affirmation {
  final String title;
  final Duration duration;
  final String recordingPath;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Conversion methods for JSON serialization
  Map<String, dynamic> toJson() { ... }
  factory Affirmation.fromJson(Map<String, dynamic> json) { ... }
}
```

### Track Model

Tracks are collections of related affirmations:

```dart
class Track {
  final String title;
  final List<Affirmation> affirmations;
  final Duration totalDuration;
  final String? coverImagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Conversion methods for JSON serialization
  Map<String, dynamic> toJson() { ... }
  factory Track.fromJson(Map<String, dynamic> json) { ... }
}
```

The application also works with a server-side model for playlists and tracks, which appears to have a slightly different structure:

```dart
// Server-side models (inferred from controller usage)
class PlaylistResponseModel {
  Data? data;
  // Other fields and methods...
}

class Data {
  String? name;
  String? image;
  int? tracksCount;
  String? tracksTotalDuration;
  List<Tracks>? tracks;
  // Other fields...
}

class Tracks {
  int? trackId;
  int? id;
  String? trackName;
  String? trackFile;
  String? image;
  int? affirmationsCount;
  // Other fields...
}
```

## Architecture

The application follows a GetX-based architecture with clear separation of concerns:

1. **Controller Layer**: Manages business logic, state, and API communication
2. **View Layer**: Handles UI rendering and user interactions
3. **Service Layer**: Provides functionality for audio playback and data storage
4. **Model Layer**: Defines data structures for the application

## Core Components

### PlaylistDetailsController

This is the central controller managing all aspects of playlist interaction:

```dart
class PlaylistDetailsController extends BaseController {
  final ApiService _apiService;
  final RemoteAudioService _audioService = RemoteAudioService();

  // State variables
  Rx<PlayerState> playerState = PlayerState.stopped.obs;
  RxBool isPlayingPlaylist = false.obs;
  RxBool isLoadingAudio = false.obs;
  RxInt currentAffirmationIndex = 0.obs;
  RxInt currentTrackIndex = 0.obs;

  // Data variables
  Rx<PlaylistResponseModel> playlistResponse = PlaylistResponseModel().obs;
  Rx<Tracks?> currentlyPlayingTrack = Rx<Tracks?>(null);

  // Feature flags
  RxBool isPlayerStopTimerActive = false.obs;
  RxBool isLoopEnabled = false.obs;
  RxBool isPlaylistFavorite = false.obs;
  RxBool isPlaylistDownloaded = false.obs;

  // ... methods for player control
}
```

### RemoteAudioService

This service abstracts audio playback functionality using the `just_audio` package, providing a comprehensive wrapper around audio operations:

```dart
class RemoteAudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  ConcatenatingAudioSource? _playlist;

  // State getters
  bool get isPlaylistLoaded => _playlist != null && _audioPlayer.audioSource != null;
  bool get isPlaying => _audioPlayer.playing;
  ProcessingState get processingState => _audioPlayer.processingState;

  // State streams
  Stream<bool> get playingStream => _audioPlayer.playingStream;
  Stream<ProcessingState> get processingStateStream => _audioPlayer.processingStateStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration> get bufferedPositionStream => _audioPlayer.bufferedPositionStream;
  Stream<bool> get shuffleModeEnabledStream => _audioPlayer.shuffleModeEnabledStream;
  Stream<LoopMode> get loopModeStream => _audioPlayer.loopModeStream;

  // Single audio operations
  Future<void> loadAndPlaySingleAudio(String audioUrl);
  Future<void> pauseSingleAudio();
  Future<void> stopSingleAudio();
  Future<void> toggleSingleAudioPlayPause();

  // Playlist operations
  Future<void> loadPlaylist(List<String> audioUrls);
  Future<void> playPlaylist();
  Future<void> pausePlaylist();
  Future<void> stopPlaylist();
  Future<void> loadAndPlayPlaylist(List<String> audioUrls);
  Future<void> togglePlayPause();

  // Navigation controls
  Future<void> seekToStart();
  Future<void> seekToNext();
  Future<void> seekToPrevious();
  Future<void> seek(Duration position);

  // Playback settings
  void setLoopMode(bool enableLoop);
  Future<void> setVolume(double volume);
  Future<void> setSpeed(double speed);

  // Resource management
  void dispose();
}
```

The service handles both single track and playlist playback scenarios:

#### Single Track Operations

For individual track playback:

```dart
Future<void> loadAndPlaySingleAudio(String audioUrl) async {
  try {
    await _audioPlayer.stop();
    _playlist = null;  // Clear playlist when playing single audio
    await _audioPlayer.setUrl(audioUrl);
    if (_audioPlayer.processingState == ProcessingState.ready) {
      await _audioPlayer.play();
    }
  } catch (e) {
    AppLogger.log('Error in loadAndPlaySingleAudio: $e');
    rethrow;
  }
}
```

#### Playlist Operations

For multi-track playlist handling:

```dart
Future<void> loadPlaylist(List<String> audioUrls) async {
  try {
    await _audioPlayer.stop();
    final List<AudioSource> audioSources = audioUrls
        .map((url) => AudioSource.uri(Uri.parse(url)))
        .toList();
    _playlist = ConcatenatingAudioSource(
      children: audioSources,
      useLazyPreparation: true,
    );
    await _audioPlayer.setAudioSource(_playlist!);
  } catch (e) {
    _playlist = null;
    AppLogger.log('Error in loadPlaylist: $e');
    rethrow;
  }
}
```

#### Error Handling

All methods include comprehensive error handling:

```dart
try {
  // Audio operation code
} catch (e) {
  AppLogger.log('Error in methodName: $e');
  rethrow;
}
```

### LocalStorageService

A service for persisting tracks and affirmations locally:

```dart
class LocalStorageService {
  // Singleton implementation
  static LocalStorageService? _instance;
  static Future<LocalStorageService> getInstance() async { ... }

  // CRUD operations for tracks
  Future<bool> saveTrack(Track track);
  Future<List<Track>> getTracks();
  Future<Track?> getTrackByTitle(String title);
  Future<bool> deleteTrack(String title);

  // Operations for affirmations within tracks
  Future<bool> addAffirmationToTrack(String trackTitle, Affirmation affirmation);
  Future<bool> removeAffirmationFromTrack(String trackTitle, String affirmationTitle);
}
```

## State Management

The application uses GetX for reactive state management:

### Observable State Variables

```dart
// Player state
Rx<PlayerState> playerState = PlayerState.stopped.obs;
RxBool isPlayingPlaylist = false.obs;
RxBool isLoadingAudio = false.obs;

// Track/playlist tracking
RxInt currentAffirmationIndex = 0.obs;
RxInt currentTrackIndex = 0.obs;

// Feature flags
RxBool isPlayerStopTimerActive = false.obs;
RxBool isLoopEnabled = false.obs;
RxBool isPlaylistFavorite = false.obs;
RxBool isPlaylistDownloaded = false.obs;

// Duration tracking
RxDouble currentDuration = 0.0.obs;
RxDouble totalDuration = 0.0.obs;
```

### State Streams

The controller integrates with audio service streams to keep UI updated:

```dart
Stream<bool> get isPlaying => _audioService.playingStream;
Stream<bool> get isLoadingAudioStream => _audioService.processingStateStream.map(...);
```

### State Initialization

```dart
@override
void onInit() async {
  super.onInit();
  await _getPlaylistById(playlistId);
  await _initAudioStreams();
}

Future<void> _initAudioStreams() async {
  // Set up stream listeners for audio state
  _audioService.playingStream.listen(...);
  _audioService.processingStateStream.listen(...);
  _audioService.durationStream.listen(...);
  _audioService.positionStream.listen(...);
}
```

## Player Functionality

### Playback States

The player has three main states defined in the controller:

```dart
enum PlayerState {
  playing, // Currently playing a track
  paused,  // Paused and can be resumed from current position
  stopped  // Completely stopped, should restart from beginning
}
```

Additionally, the RemoteAudioService exposes more detailed playback states from the just_audio library:

```dart
// ProcessingState enum from just_audio
enum ProcessingState {
  idle,       // The player is idle and has not loaded an audio source
  loading,    // The player is loading an audio source
  buffering,  // The player is buffering audio for playback
  ready,      // The player is ready to play
  completed   // The player has completed playing the current source
}

// Access the processing state
ProcessingState get processingState => _audioPlayer.processingState;

// Subscribe to processing state changes
_audioService.processingStateStream.listen((state) {
  isLoadingAudio.value = state == ProcessingState.loading ||
                         state == ProcessingState.buffering;
  if (state == ProcessingState.completed) {
    _onTrackCompleted();
  }
});
```

### Playlist Control

The controller provides methods for controlling playlist playback:

```dart
// Start/resume playlist playback
Future<void> onPlaylistPlay() async { ... }

// Pause playlist playback
Future<void> onPlaylistPause() async { ... }

// Toggle between play/pause
Future<void> togglePlaylistPlayPause() async { ... }

// Handle playlist completion
void onPlaylistCompleted() { ... }
```

### Track Control

Methods for manipulating individual tracks:

```dart
// Play a specific track by ID
Future<void> onTrackPlay(String trackId) async { ... }

// Pause current track
Future<void> onTrackPause() async { ... }

// Toggle play/pause for a specific track
Future<void> toggleSingleTrackPlayPause(String trackId) async { ... }

// Handle track completion
Future<void> _onTrackCompleted() async { ... }

// Play the next track in sequence
Future<void> _playNextTrack() async { ... }

// Internal method to start playing a track
Future<void> _playTrack(Tracks track) async { ... }
```

### Duration Tracking

The controller tracks playback duration for progress displays:

```dart
void _startDurationTracking() {
  _durationUpdateTimer?.cancel();
  _durationUpdateTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
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
```

## User Interface

### PlaylistDetailsScreen

The main UI component for displaying and interacting with playlists:

```dart
class PlaylistDetailsScreen extends GetView<PlaylistDetailsController> {
  // Main layout with playlist details, track listing, and player controls
  @override
  Widget build(BuildContext context) { ... }

  // Bottom player overlay when track is playing
  Widget? _buildPlayerBottomNavbar() { ... }

  // App bar actions based on playlist type and edit mode
  List<Widget> get _buildActions { ... }
}
```

### Track List UI

Displays tracks with play/pause controls:

```dart
ListView.separated(
  itemCount: controller.playlistResponse.value.data!.tracks!.length,
  separatorBuilder: (context, index) => 22.height,
  itemBuilder: (BuildContext context, int index) {
    var item = controller.playlistResponse.value.data!.tracks![index];
    return ExploreTrackListTile(
      track: item,
      controller: controller,
    );
  }
)
```

### Player Controls

The UI includes several control buttons:

```dart
// Main play/pause button for playlist
MediaPlayerButton(
  isPlayPause: true,
  isPlaying: controller.isPlayingTrack,
  onPlay: controller.togglePlaylistPlayPause,
  onPause: controller.togglePlaylistPlayPause,
)

// Feature buttons
SvgCircleButton(IconConstants.audioTimer, onPressed: controller.onTimerPressed)
SvgCircleButton(IconConstants.audioReplay, onPressed: controller.toggleLoopMode)
SvgCircleButton(IconConstants.favoriteOutlined, onPressed: controller.toggleFavoritePlaylist)
SvgCircleButton(IconConstants.download, onPressed: controller.downloadPlaylist)
```

### Bottom Navigation Player

A persistent mini-player that appears when music is playing:

```dart
PlayerBottomNavbar(
  coverImage: controller.currentlyPlayingTrack.value?.image.toString() ?? '',
  title: controller.currentlyPlayingTrack.value?.trackName.toString() ?? 'No Name',
  subtitle: getAffirmationCountString(controller.currentlyPlayingTrack.value?.affirmationsCount),
  isPlaying: controller.isPlayingTrack,
  onPlay: controller.togglePlaylistPlayPause,
  onPause: controller.togglePlaylistPlayPause,
  showProgress: true,
  progress: controller.totalDuration.value > 0
      ? controller.currentDuration.value / controller.totalDuration.value
      : 0,
)
```

## Advanced Features

### Timer Functionality

The player can be set to automatically stop after a specified duration:

```dart
// Show timer selection dialog
void onTimerPressed() {
  if (isPlayerStopTimerActive.value) {
    _cancelAudioTimer();
    return;
  }

  return AppDialogs.showBlurred(
    TimerOverlayMenu(
      onSetTimer: onSetTimer,
    ),
  );
}

// Start timer with selected duration
void onSetTimer(int minutes) {
  _startAudioTimer(minutes);
}

// Timer implementation
void _startAudioTimer(int minutes) {
  _cancelAudioTimer();
  isPlayerStopTimerActive.value = true;

  _audioTimer = Timer(Duration(minutes: minutes), () {
    onTrackPause();
    isPlayerStopTimerActive.value = false;
  });
}

// Cancel active timer
void _cancelAudioTimer() {
  _audioTimer?.cancel();
  _audioTimer = null;
  isPlayerStopTimerActive.value = false;
}
```

### Loop Mode

Enables continuous playback by restarting the playlist when finished:

```dart
void toggleLoopMode() {
  isLoopEnabled.toggle();
}

// In onPlaylistCompleted:
if (isLoopEnabled.value) {
  // Start playing from the first track again
  onPlaylistPlay();
} else {
  // Otherwise stop playback
  playerState.value = PlayerState.stopped;
  isPlayingPlaylist.value = false;
}
```

### Favorites

The implementation includes UI for marking playlists as favorites:

```dart
void toggleFavoritePlaylist() {
  isPlaylistFavorite.toggle();
  // TODO: API call for saving favorite status
}
```

### Downloads

The UI includes functionality for downloading playlists for offline use:

```dart
void downloadPlaylist() {
  isPlaylistDownloaded.toggle();
  // TODO: Implementation for downloading tracks
}
```

### Playlist Editing

The controller supports editing of custom playlists:

```dart
void editPlaylist() {
  isEditing.value = true;
}

void saveEditedPlaylist() {
  isEditing.value = false;
}

void editTitle() {
  // TODO: Implement title editing
}
```

## Storage Implementation

### Shared Preferences Storage

The application uses SharedPreferences for local storage:

```dart
class LocalStorageService {
  static const String _tracksKey = 'tracks';
  final SharedPreferences _prefs;

  // Store tracks as JSON in SharedPreferences
  Future<bool> _saveTracks(List<Track> tracks) async {
    final String tracksJson = json.encode(tracks.map((t) => t.toJson()).toList());
    return await _prefs.setString(_tracksKey, tracksJson);
  }

  // Retrieve and deserialize tracks
  Future<List<Track>> getTracks() async {
    final String? tracksJson = _prefs.getString(_tracksKey);
    if (tracksJson == null) return [];

    final List<dynamic> tracksList = json.decode(tracksJson);
    return tracksList.map((json) => Track.fromJson(json)).toList();
  }
}
```

### Server API Integration

The controller fetches playlist data from a remote API:

```dart
Future<void> _getPlaylistById(int playlistId) async {
  try {
    startLoading();
    var response = await _apiService.request(
      apiEndPoint: "${ApiService.explorerPlaylistById}${playlistId.toString()}?device_id=${LocalStorage.deviceID.toString()}",
      isGet: true,
      withToken: LocalStorage.userAccessToken.isNotEmpty,
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      playlistResponse.value = PlaylistResponseModel.fromJson(data);
    } else {
      handleFailure(data['message']);
    }
  } catch (e) {
    handleFailure(e.toString());
  } finally {
    stopLoading();
  }
}
```

## Implementation Flow

1. When the screen initializes, it fetches playlist data from the API using `_getPlaylistById()`
2. Audio stream listeners are set up to react to playback state changes
3. User can play a specific track by tapping it in the list, triggering `toggleSingleTrackPlayPause()`
4. User can play the entire playlist with the main play button, calling `togglePlaylistPlayPause()`
5. When a track completes, `_onTrackCompleted()` is called to either play the next track or restart based on loop mode
6. Timer, loop, favorite, and download buttons toggle their respective states
7. The UI reactively updates based on observable state changes in the controller

This implementation provides a complete audio playback solution with rich features for both playlist and individual track management.

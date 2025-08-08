import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

/// Service to help with preloading assets that might be needed early in the app
class AssetPreloader {
  // Keep track of preloaded assets
  static final Map<String, bool> _preloadedAssets = {};

  /// Preload a single asset file into memory
  static Future<void> preloadAsset(String assetPath) async {
    if (_preloadedAssets[assetPath] == true) {
      // Already preloaded, skip
      return;
    }

    try {
      // Load the asset into memory
      final ByteData data = await rootBundle.load(assetPath);
      _preloadedAssets[assetPath] = true;
      LogUtil.i('✓ Successfully preloaded asset: $assetPath');
    } catch (e) {
      LogUtil.e('✗ Error preloading asset $assetPath: $e');
    }
  }

  /// Preload an image asset without requiring a BuildContext
  static Future<void> preloadImage(String imagePath) async {
    if (_preloadedAssets[imagePath] == true) {
      // Already preloaded, skip
      return;
    }

    try {
      // Use the rootBundle to load the asset bytes
      await rootBundle.load(imagePath);
      _preloadedAssets[imagePath] = true;
      LogUtil.i('✓ Successfully preloaded image: $imagePath');
    } catch (e) {
      LogUtil.e('✗ Error preloading image $imagePath: $e');
    }
  }

  /// Start loading a video in the background
  /// This doesn't fully load the video but initializes it so it's ready faster later
  static Future<void> prepareVideo(String videoPath) async {
    if (_preloadedAssets[videoPath] == true) {
      // Already preloaded, skip
      return;
    }

    try {
      // Create a video controller but don't initialize or play it yet
      final controller = VideoPlayerController.asset(videoPath);

      // Trigger the initialization but don't await it
      controller.initialize().then((_) {
        _preloadedAssets[videoPath] = true;

        // Mute the audio
        controller.setVolume(0);
        
        // Don't play it, just prepare it
        controller.pause();
        LogUtil.i('✓ Successfully prepared video: $videoPath');
      }).catchError((e) {
        LogUtil.e('✗ Error preparing video $videoPath: $e');
      });
    } catch (e) {
      LogUtil.e('✗ Error setting up video preloading for $videoPath: $e');
    }
  }

  /// Preload onboarding videos
  static Future<void> preloadOnboardingVideos() async {
    try {
      const videoPath1 = 'assets/onboarding_1_v2.webm';

      const videoPath2 = 'assets/onboarding_2_v2.webm';

      const videoPath3 = 'assets/onboarding_3_v2.webm';

      // Only preload the first video fully, the others just prepare
      await preloadAsset(videoPath1);
      prepareVideo(videoPath2);
      prepareVideo(videoPath3);
    } catch (e) {
      LogUtil.e('✗ Error preloading onboarding videos: $e');
    }
  }

  /// Preload multiple assets at once
  static Future<void> preloadAssets(List<String> assetPaths) async {
    final futures = assetPaths.map((path) => preloadAsset(path));
    await Future.wait(futures);
  }

  /// Check if an asset has been preloaded
  static bool isPreloaded(String assetPath) {
    return _preloadedAssets[assetPath] == true;
  }

  /// Clear preloaded assets
  static void clearPreloadedAssets() {
    _preloadedAssets.clear();
  }
}

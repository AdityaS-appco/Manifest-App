// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants/assets/image_constants.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/core/utils/color_extractor.dart';
import 'package:palette_generator/palette_generator.dart';

class ThemeController extends GetxController {
  // Storage key constants
  static const String KEY_GRADIENT_ONE = 'theme_gradient_one';
  static const String KEY_GRADIENT_TWO = 'theme_gradient_two';
  static const String KEY_GRADIENT_THREE = 'theme_gradient_three';
  static const String KEY_GRADIENT_FOUR = 'theme_gradient_four';
  static const String KEY_TEXT_COLOR_ONE = 'theme_text_color_one';
  static const String KEY_TEXT_COLOR_TWO = 'theme_text_color_two';
  static const String KEY_TEXT_COLOR_THREE = 'theme_text_color_three';
  static const String KEY_TEXT_COLOR_FOUR = 'theme_text_color_four';
  static const String KEY_CURRENT_SCENE_IMAGE = 'theme_current_scene_image';
  static const String KEY_CUSTOM_THEME_ENABLED = 'theme_custom_enabled';

  // Default colors for dark blue-gray gradient (matching the screenshot)
  static const Color DEFAULT_GRADIENT_ONE = Color(0xFF0B0020); // Black
  static const Color DEFAULT_GRADIENT_TWO =
      Color(0xFF0B002080); // Dark blue-gray
  static const Color DEFAULT_GRADIENT_THREE =
      Color(0xFF0B0020); // Medium blue-gray
  static const Color DEFAULT_GRADIENT_FOUR =
      Color(0xFF0B0020); // Light blue-gray
  static const Color DEFAULT_TEXT_COLOR = Colors.white;

  // Default image path
  String get defaultSceneImagePath => ImageConstants.defaultSceneImagePath;

  // Gradient colors
  final Rx<Color> _gradientOne = DEFAULT_GRADIENT_ONE.obs;
  final Rx<Color> _gradientTwo = DEFAULT_GRADIENT_TWO.obs;
  final Rx<Color> _gradientThree = DEFAULT_GRADIENT_THREE.obs;
  final Rx<Color> _gradientFour = DEFAULT_GRADIENT_FOUR.obs;

  // Text colors for each gradient
  final Rx<Color> _gradientOneTextColor = DEFAULT_TEXT_COLOR.obs;
  final Rx<Color> _gradientTwoTextColor = DEFAULT_TEXT_COLOR.obs;
  final Rx<Color> _gradientThreeTextColor = DEFAULT_TEXT_COLOR.obs;
  final Rx<Color> _gradientFourTextColor = DEFAULT_TEXT_COLOR.obs;

  // Theme state
  final RxBool _isDark = true.obs; // Default to dark theme
  final RxBool _customThemeEnabled = false.obs;
  final RxString _currentSceneImage = "".obs;
  final RxBool _isThemeLoading = false.obs;

  // Color extractor
  final colorExtractor =
      Get.put(ColorExtractorController(), tag: 'theme_controller');

  // Getters
  Color get gradientOne => _gradientOne.value;
  Color get gradientTwo => _gradientTwo.value;
  Color get gradientThree => _gradientThree.value;
  Color get gradientFour => _gradientFour.value;

  Color get gradientOneText => _gradientOneTextColor.value;
  Color get gradientTwoText => _gradientTwoTextColor.value;
  Color get gradientThreeText => _gradientThreeTextColor.value;
  Color get gradientFourText => _gradientFourTextColor.value;

  bool get isDark => _isDark.value;
  RxBool get customThemeEnabled => _customThemeEnabled;
  RxString get currentSceneImage => _currentSceneImage;
  bool get isThemeLoading => _isThemeLoading.value;

  // Storage reference
  final _storage = LocalStorage.kStorage;

  @override
  void onInit() async {
    super.onInit();
    await loadSavedTheme();
    loadDarkModePreference();

    // If no custom theme is enabled, extract colors from default image
    if (!_customThemeEnabled.value) {
      await extractColorsFromDefaultImage();
    }
  }

  /// Load saved dark mode preference
  void loadDarkModePreference() {
    _isDark.value = LocalStorage.kStorage.read(LocalStorage.themeMode) ??
        true; // Default to dark
    applyDarkMode();
  }

  /// Extract colors from the default scene image
  Future<void> extractColorsFromDefaultImage() async {
    try {
      // Ensure we have the default image path defined
      if (defaultSceneImagePath.isNotEmpty) {
        await colorExtractor.extractColorsFromAssetImage(defaultSceneImagePath);

        // Update default gradient colors based on the image
        // But keep the original blue-gray theme intact by blending them
        if (colorExtractor.paletteColors.isNotEmpty) {
          // Only update if not using custom theme
          if (!_customThemeEnabled.value) {
            // Blend with default colors to maintain the dark blue-gray appearance
            _gradientOne.value = Color.lerp(
                    DEFAULT_GRADIENT_ONE,
                    colorExtractor.darkestColor.value ?? DEFAULT_GRADIENT_ONE,
                    0.2) ??
                DEFAULT_GRADIENT_ONE;
            _gradientTwo.value = Color.lerp(
                    DEFAULT_GRADIENT_TWO,
                    colorExtractor.dominantColor.value ?? DEFAULT_GRADIENT_TWO,
                    0.2) ??
                DEFAULT_GRADIENT_TWO;
            _gradientThree.value = Color.lerp(
                    DEFAULT_GRADIENT_THREE,
                    colorExtractor.lightestColor.value ??
                        DEFAULT_GRADIENT_THREE,
                    0.2) ??
                DEFAULT_GRADIENT_THREE;
            _gradientFour.value = Color.lerp(
                    DEFAULT_GRADIENT_FOUR,
                    colorExtractor.lightestColor.value ?? DEFAULT_GRADIENT_FOUR,
                    0.2) ??
                DEFAULT_GRADIENT_FOUR;
          }
        }
      }
    } catch (e) {
      debugPrint('Error extracting colors from default image: $e');
      // Keep using the default colors if extraction fails
    }
  }

  /// Load saved theme colors from storage
  Future<void> loadSavedTheme() async {
    try {
      _customThemeEnabled.value =
          _storage.read(KEY_CUSTOM_THEME_ENABLED) ?? false;

      if (_customThemeEnabled.value) {
        // Load saved image path
        _currentSceneImage.value = _storage.read(KEY_CURRENT_SCENE_IMAGE) ?? "";

        // Load saved gradient colors
        final gradientOneValue = _storage.read(KEY_GRADIENT_ONE);
        final gradientTwoValue = _storage.read(KEY_GRADIENT_TWO);
        final gradientThreeValue = _storage.read(KEY_GRADIENT_THREE);
        final gradientFourValue = _storage.read(KEY_GRADIENT_FOUR);

        // Load saved text colors
        final textOneValue = _storage.read(KEY_TEXT_COLOR_ONE);
        final textTwoValue = _storage.read(KEY_TEXT_COLOR_TWO);
        final textThreeValue = _storage.read(KEY_TEXT_COLOR_THREE);
        final textFourValue = _storage.read(KEY_TEXT_COLOR_FOUR);

        // Apply saved colors if they exist
        if (gradientOneValue != null)
          _gradientOne.value = Color(gradientOneValue);
        if (gradientTwoValue != null)
          _gradientTwo.value = Color(gradientTwoValue);
        if (gradientThreeValue != null)
          _gradientThree.value = Color(gradientThreeValue);
        if (gradientFourValue != null)
          _gradientFour.value = Color(gradientFourValue);

        if (textOneValue != null)
          _gradientOneTextColor.value = Color(textOneValue);
        if (textTwoValue != null)
          _gradientTwoTextColor.value = Color(textTwoValue);
        if (textThreeValue != null)
          _gradientThreeTextColor.value = Color(textThreeValue);
        if (textFourValue != null)
          _gradientFourTextColor.value = Color(textFourValue);
      } else {
        // Apply default colors
        resetToDefaultColors();
      }
    } catch (e) {
      debugPrint('Error loading saved theme: $e');
      resetToDefaultColors();
    }
  }

  /// Reset to default colors
  void resetToDefaultColors() {
    _gradientOne.value = DEFAULT_GRADIENT_ONE;
    _gradientTwo.value = DEFAULT_GRADIENT_TWO;
    _gradientThree.value = DEFAULT_GRADIENT_THREE;
    _gradientFour.value = DEFAULT_GRADIENT_FOUR;

    _gradientOneTextColor.value = DEFAULT_TEXT_COLOR;
    _gradientTwoTextColor.value = DEFAULT_TEXT_COLOR;
    _gradientThreeTextColor.value = DEFAULT_TEXT_COLOR;
    _gradientFourTextColor.value = DEFAULT_TEXT_COLOR;

    _currentSceneImage.value = "";
    _customThemeEnabled.value = false;

    // Save default settings
    saveThemeToStorage();

    // Extract colors from default image
    extractColorsFromDefaultImage();
  }

  /// Save current theme to storage
  void saveThemeToStorage() {
    try {
      _storage.write(KEY_CUSTOM_THEME_ENABLED, _customThemeEnabled.value);

      if (_customThemeEnabled.value) {
        _storage.write(KEY_CURRENT_SCENE_IMAGE, _currentSceneImage.value);

        // Save gradient colors
        _storage.write(KEY_GRADIENT_ONE, _gradientOne.value.value);
        _storage.write(KEY_GRADIENT_TWO, _gradientTwo.value.value);
        _storage.write(KEY_GRADIENT_THREE, _gradientThree.value.value);
        _storage.write(KEY_GRADIENT_FOUR, _gradientFour.value.value);

        // Save text colors
        _storage.write(KEY_TEXT_COLOR_ONE, _gradientOneTextColor.value.value);
        _storage.write(KEY_TEXT_COLOR_TWO, _gradientTwoTextColor.value.value);
        _storage.write(
            KEY_TEXT_COLOR_THREE, _gradientThreeTextColor.value.value);
        _storage.write(KEY_TEXT_COLOR_FOUR, _gradientFourTextColor.value.value);
      }
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }

  /// Update a single gradient color and its text color
  void updateGradient(int position, Color color, Color textColor) {
    switch (position) {
      case 0:
        _gradientOne.value = color;
        _gradientOneTextColor.value = textColor;
        break;
      case 1:
        _gradientTwo.value = color;
        _gradientTwoTextColor.value = textColor;
        break;
      case 2:
        _gradientThree.value = color;
        _gradientThreeTextColor.value = textColor;
        break;
      case 3:
        _gradientFour.value = color;
        _gradientFourTextColor.value = textColor;
        break;
    }

    _customThemeEnabled.value = true;
    saveThemeToStorage();
  }

  /// Generate theme colors from an image
  Future<bool> generateColorFromImage(String imagePath) async {
    if (imagePath.isEmpty) {
      return false;
    }

    _isThemeLoading.value = true;

    try {
      if (await colorExtractor.doesImageExist(imagePath)) {
        if (imagePath.startsWith('http')) {
          await colorExtractor.extractColorsFromNetworkImage(imagePath);
        } else if (await File(imagePath).exists()) {
          await colorExtractor.extractColorsFromFileImage(imagePath);
        } else {
          _isThemeLoading.value = false;
          return false;
        }

        if (colorExtractor.paletteColors.isNotEmpty) {
          // Select diverse colors for better gradient
          List<PaletteColor> selectedColors =
              colorExtractor.selectDiverseColors(colorExtractor.paletteColors);

          // Make sure we have 4 colors for gradient
          while (selectedColors.length < 4 &&
              colorExtractor.paletteColors.isNotEmpty) {
            selectedColors.add(colorExtractor.paletteColors[
                selectedColors.length % colorExtractor.paletteColors.length]);
          }

          if (selectedColors.length >= 4) {
            // Update gradient colors
            _gradientOne.value = selectedColors[0].color;
            _gradientTwo.value = selectedColors[1].color;
            _gradientThree.value = selectedColors[2].color;
            _gradientFour.value = selectedColors[3].color;

            // Set appropriate text colors based on background brightness
            _gradientOneTextColor.value =
                colorExtractor.getTextColorForBackground(_gradientOne.value);
            _gradientTwoTextColor.value =
                colorExtractor.getTextColorForBackground(_gradientTwo.value);
            _gradientThreeTextColor.value =
                colorExtractor.getTextColorForBackground(_gradientThree.value);
            _gradientFourTextColor.value =
                colorExtractor.getTextColorForBackground(_gradientFour.value);

            // Update state
            _currentSceneImage.value = imagePath;
            _customThemeEnabled.value = true;

            // Save to storage
            saveThemeToStorage();

            _isThemeLoading.value = false;
            return true;
          }
        }
      }

      _isThemeLoading.value = false;
      return false;
    } catch (e) {
      debugPrint('Error generating colors from image: $e');
      _isThemeLoading.value = false;
      return false;
    }
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    _isDark.toggle();
    LocalStorage.kStorage.write(LocalStorage.themeMode, _isDark.value);
    applyDarkMode();
  }

  /// Apply dark mode setting
  void applyDarkMode() {
    Get.changeThemeMode(_isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  /// Toggle custom theme
  void toggleCustomTheme(bool enable) {
    _customThemeEnabled.value = enable;
    if (!enable) {
      resetToDefaultColors();
    }
    saveThemeToStorage();
  }

  @override
  void onClose() {
    saveThemeToStorage();
    super.onClose();
  }
}

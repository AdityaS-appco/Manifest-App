import 'dart:io';
import 'package:manifest/helper/import.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:http/http.dart' as http;

/// Controller for extracting and managing colors from images
class ColorExtractorController extends GetxController {
  /// * Current extraction status
  final RxBool isExtracting = false.obs;

  /// * Last extracted colors
  final Rx<Color?> dominantColor = Rx<Color?>(null);
  final Rx<Color?> lightestColor = Rx<Color?>(null);
  final Rx<Color?> darkestColor = Rx<Color?>(null);
  final Rx<Color?> textColor = Rx<Color?>(null);

  /// * Gradient properties
  final Rx<List<Color>?> twoColorGradient = Rx<List<Color>?>(null);
  final Rx<List<Color>?> threeColorGradient = Rx<List<Color>?>(null);
  final Rx<List<Color>?> fourColorGradient = Rx<List<Color>?>(null);
  final Rx<List<Color>?> lightToDarkTwoColorGradient = Rx<List<Color>?>(null);
  final Rx<List<Color>?> lightToDarkThreeColorGradient = Rx<List<Color>?>(null);
  final Rx<List<Color>?> lightToDarkFourColorGradient = Rx<List<Color>?>(null);
  final Rx<List<Color>?> darkToLightTwoColorGradient = Rx<List<Color>?>(null);
  final Rx<List<Color>?> darkToLightThreeColorGradient = Rx<List<Color>?>(null);
  final Rx<List<Color>?> darkToLightFourColorGradient = Rx<List<Color>?>(null);

  /// * Line gradients
  final Rx<LinearGradient?> verticalGradient = Rx<LinearGradient?>(null);
  final Rx<LinearGradient?> horizontalGradient = Rx<LinearGradient?>(null);
  final Rx<LinearGradient?> diagonalGradient = Rx<LinearGradient?>(null);

  /// * Last error message if any
  final RxString lastError = ''.obs;

  /// * Palette data
  final RxList<PaletteColor> paletteColors = RxList<PaletteColor>();

  /// * Calculate luminance to determine if text should be dark or light
  double calculateLuminance(Color color) {
    return (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
  }

  /// * Determine appropriate text color based on background color
  Color getTextColorForBackground(Color backgroundColor) {
    final luminance = calculateLuminance(backgroundColor);
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// * Select diverse colors from palette to create visually appealing gradient
  List<PaletteColor> selectDiverseColors(List<PaletteColor> colors) {
    if (colors.isEmpty) return [];

    // Sort by population (frequency in image)
    final sortedByPopulation = List<PaletteColor>.from(colors)
      ..sort((a, b) => b.population.compareTo(a.population));

    // Take top 10 colors by population
    final topColors = sortedByPopulation.take(10).toList();

    // Try to get vibrant colors first
    final vibrantColors = topColors
        .where((c) =>
            c.population > 10 &&
            (c.color.computeLuminance() > 0.2 &&
                c.color.computeLuminance() < 0.8))
        .toList();

    // If we have enough vibrant colors, select colors with different hues
    if (vibrantColors.length >= 4) {
      // Sort by hue to easily select diverse colors
      vibrantColors.sort((a, b) {
        final aHsl = HSLColor.fromColor(a.color);
        final bHsl = HSLColor.fromColor(b.color);
        return aHsl.hue.compareTo(bHsl.hue);
      });

      // Take colors with different hues
      final result = <PaletteColor>[];
      final step = vibrantColors.length ~/ 4;
      for (int i = 0; i < 4; i++) {
        result.add(vibrantColors[(i * step) % vibrantColors.length]);
      }
      return result;
    }

    // Fallback to taking top 4 by population
    return topColors.take(4).toList();
  }

  /// * Check if image exists
  Future<bool> doesImageExist(String path) async {
    if (path.isEmpty) return false;

    try {
      if (path.startsWith('http')) {
        // For network images, we'll have to assume it exists
        return true;
      } else {
        // For local files, check if file exists
        return await File(path).exists();
      }
    } catch (e) {
      return false;
    }
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  /// * Clear all stored data
  void clear() {
    isExtracting.value = false;
    dominantColor.value = null;
    lightestColor.value = null;
    darkestColor.value = null;
    textColor.value = null;

    // Clear gradient properties
    twoColorGradient.value = null;
    threeColorGradient.value = null;
    fourColorGradient.value = null;
    lightToDarkTwoColorGradient.value = null;
    lightToDarkThreeColorGradient.value = null;
    lightToDarkFourColorGradient.value = null;
    darkToLightTwoColorGradient.value = null;
    darkToLightThreeColorGradient.value = null;
    darkToLightFourColorGradient.value = null;

    // Clear line gradients
    verticalGradient.value = null;
    horizontalGradient.value = null;
    diagonalGradient.value = null;

    // Clear palette colors
    paletteColors.clear();

    lastError.value = '';
  }

  /// * Check if color extraction is in progress
  bool get isExtractionInProgress => isExtracting.value;

  /// * Get the last error message
  String get error => lastError.value;

  /// * Check if image URL is valid
  Future<bool> isValidImageUrl(String path) async {
    try {
      // For network URLs, try to fetch headers
      final response = await http.head(Uri.parse(path));
      return response.statusCode == 200 &&
          response.headers['content-type']?.startsWith('image/') == true;
    } catch (e) {
      return false;
    }
  }

  /// * Extract colors from network image
  Future<void> extractColorsFromNetworkImage(String? imageUrl) async {
    try {
      isExtracting.value = true;
      if (imageUrl == null ||
          imageUrl.isEmpty ||
          !await isValidImageUrl(imageUrl)) return;
      lastError.value = '';

      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        NetworkImage(imageUrl),
        maximumColorCount: 20,
        targets: [
          PaletteTarget.darkMuted,
          PaletteTarget.darkVibrant,
          PaletteTarget.lightMuted,
          PaletteTarget.lightVibrant,
          PaletteTarget.vibrant,
          PaletteTarget.muted,
        ],
      );

      _updateColorsFromPalette(paletteGenerator);
    } catch (e) {
      lastError.value = 'Error extracting colors from network image: $e';
      LogUtil.e(lastError.value);
    } finally {
      isExtracting.value = false;
      LogUtil.i("Color extraction from network image: ${isExtracting.value}");
    }
  }

  /// * Extract colors from asset image
  Future<void> extractColorsFromAssetImage(String assetPath) async {
    try {
      isExtracting.value = true;
      lastError.value = '';

      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        AssetImage(assetPath),
        maximumColorCount: 20,
        targets: [
          PaletteTarget.darkMuted,
          PaletteTarget.darkVibrant,
          PaletteTarget.lightMuted,
          PaletteTarget.lightVibrant,
          PaletteTarget.vibrant,
          PaletteTarget.muted,
        ],
      );

      _updateColorsFromPalette(paletteGenerator);
    } catch (e) {
      lastError.value = 'Error extracting colors from asset image: $e';
      LogUtil.e(lastError.value);
    } finally {
      isExtracting.value = false;
    }
  }

  /// * Extract colors from file image
  Future<void> extractColorsFromFileImage(String filePath) async {
    try {
      isExtracting.value = true;
      lastError.value = '';

      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        FileImage(File(filePath)),
        maximumColorCount: 20,
        targets: [
          PaletteTarget.darkMuted,
          PaletteTarget.darkVibrant,
          PaletteTarget.lightMuted,
          PaletteTarget.lightVibrant,
          PaletteTarget.vibrant,
          PaletteTarget.muted,
        ],
      );

      _updateColorsFromPalette(paletteGenerator);
    } catch (e) {
      lastError.value = 'Error extracting colors from file image: $e';
      LogUtil.e(lastError.value);
    } finally {
      isExtracting.value = false;
    }
  }

  /// * Update colors from palette generator
  void _updateColorsFromPalette(PaletteGenerator paletteGenerator) {
    // Store the palette colors
    paletteColors.value = paletteGenerator.paletteColors;

    // Get dominant color
    dominantColor.value = paletteGenerator.dominantColor?.color;

    // Get all available colors
    final colors = [
      paletteGenerator.darkMutedColor?.color,
      paletteGenerator.darkVibrantColor?.color,
      paletteGenerator.lightMutedColor?.color,
      paletteGenerator.lightVibrantColor?.color,
      paletteGenerator.vibrantColor?.color,
      paletteGenerator.mutedColor?.color,
    ].whereType<Color>().toList();

    if (colors.isNotEmpty) {
      // Sort colors by lightness
      colors.sort((a, b) => HSLColor.fromColor(a)
          .lightness
          .compareTo(HSLColor.fromColor(b).lightness));

      lightestColor.value = colors.last;
      darkestColor.value = colors.first;

      // Calculate text color based on background brightness
      if (dominantColor.value != null) {
        textColor.value = getTextColorForBackground(dominantColor.value!);
      }

      // Create gradient variations
      _createGradientVariations(colors);
    }
  }

  /// * Create various gradient variations
  void _createGradientVariations(List<Color> colors) {
    // Basic gradients
    twoColorGradient.value = [colors.first, colors.last];
    threeColorGradient.value = [
      colors.first,
      colors[colors.length ~/ 2],
      colors.last
    ];
    fourColorGradient.value = colors;

    // Light to dark gradients
    lightToDarkTwoColorGradient.value = [colors.last, colors.first];
    lightToDarkThreeColorGradient.value = [
      colors.last,
      colors[colors.length ~/ 2],
      colors.first
    ];
    lightToDarkFourColorGradient.value = colors.reversed.toList();

    // Dark to light gradients
    darkToLightTwoColorGradient.value = [colors.first, colors.last];
    darkToLightThreeColorGradient.value = [
      colors.first,
      colors[colors.length ~/ 2],
      colors.last
    ];
    darkToLightFourColorGradient.value = colors;

    // Create line gradients
    _createLineGradients();
  }

  /// * Create line gradients
  void _createLineGradients() {
    if (twoColorGradient.value != null) {
      verticalGradient.value = createVerticalGradient(twoColorGradient.value!);
      horizontalGradient.value =
          createHorizontalGradient(twoColorGradient.value!);
      diagonalGradient.value = createDiagonalGradient(twoColorGradient.value!);
    }
  }

  /// * Create vertical gradient
  LinearGradient createVerticalGradient(List<Color> colors) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colors,
    );
  }

  /// * Create horizontal gradient
  LinearGradient createHorizontalGradient(List<Color> colors) {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: colors,
    );
  }

  /// * Create diagonal gradient
  LinearGradient createDiagonalGradient(List<Color> colors) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
    );
  }

  /// * Create custom gradient with stops
  LinearGradient createCustomGradient(
    List<Color> colors, {
    List<double>? stops,
    Alignment begin = Alignment.centerLeft,
    Alignment end = Alignment.centerRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: colors,
      stops: stops,
    );
  }
}

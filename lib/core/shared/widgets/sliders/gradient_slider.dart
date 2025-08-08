import 'package:flutter/material.dart';
import 'package:manifest/core/shared/widgets/sliders/custom_shapes/gradient_circular_divider_shape.dart';
import 'package:manifest/core/shared/widgets/sliders/custom_shapes/gradient_rectangular_track_shape.dart';
import 'package:manifest/core/shared/widgets/sliders/custom_shapes/gradient_thumb_shape.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

/// A customized slider with gradient track and thumb
class GradientSlider extends StatelessWidget {
  /// The current value of the slider
  final double value;

  /// Callback when value changes
  final ValueChanged<double> onChanged;

  /// Minimum value
  final double min;

  /// Maximum value
  final double max;

  /// Gradient for the active track portion
  final LinearGradient? trackGradient;

  /// Gradient for the thumb
  final LinearGradient? thumbGradient;

  /// Background color for the inactive track
  final Color? backgroundColor;

  /// Height of the track
  final double trackHeight;

  /// Radius of the thumb
  final double thumbRadius;

  /// Elevation for the thumb shadow
  final double? thumbElevation;

  /// The interval for dividing the slider
  final double? interval;

  /// Show dividers along the track
  final bool showDividers;

  /// Show labels for the dividers
  final bool showLabels;

  const GradientSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.trackGradient,
    this.thumbGradient,
    this.backgroundColor,
    this.trackHeight = 6.0,
    this.thumbRadius = 10.0,
    this.thumbElevation,
    this.interval,
    this.showDividers = false,
    this.showLabels = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default track gradient if none provided
    final LinearGradient defaultTrackGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.purple.shade300,
        Colors.purple.shade700,
      ],
    );

    // Default thumb gradient if none provided
    final LinearGradient defaultThumbGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white,
        Colors.grey.shade300,
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // Apply horizontal padding to account for thumb overflow
        // This ensures the slider stays within the parent bounds
        final double horizontalPadding = thumbRadius;

        return Container(
          width: constraints.maxWidth,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: SfSliderTheme(
            data: SfSliderThemeData(
              activeTrackHeight: trackHeight,
              inactiveTrackHeight: trackHeight,
              thumbRadius: thumbRadius,
              inactiveTrackColor:
                  backgroundColor ?? Colors.grey.withOpacity(0.2),
              overlayRadius: 0, // Hide the overlay effect
              activeDividerRadius: showDividers ? 4.0 : 0.0,
              inactiveDividerRadius: showDividers ? 3.0 : 0.0,
              activeTickColor: showDividers
                  ? Colors.white.withOpacity(0.6)
                  : Colors.transparent,
              inactiveTickColor: showDividers
                  ? Colors.white.withOpacity(0.3)
                  : Colors.transparent,
              activeLabelStyle:
                  const TextStyle(color: Colors.white, fontSize: 12),
              inactiveLabelStyle:
                  TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
              // Add trackCornerRadius to make the track match the rounded corners
              trackCornerRadius: trackHeight / 2,
            ),
            child: SfSlider(
              min: min,
              max: max,
              value: value,
              onChanged: (d) => onChanged(d),
              interval: interval,
              showLabels: showLabels,
              showDividers: showDividers,
              dividerShape: GradientCircularDividerShape(
                gradient: trackGradient ?? defaultTrackGradient,
                dividerRadius: 4.0,
                useGradientOnlyForActive: true,
                inactiveDividerColor: Colors.transparent,
              ),
              trackShape: GradientRectangularTrackShape(
                gradient: trackGradient ?? defaultTrackGradient,
                trackHeight: trackHeight,
              ),
              thumbShape: GradientThumbShape(
                radius: thumbRadius,
                gradient: thumbGradient ?? defaultThumbGradient,
                elevation: thumbElevation,
              ),
            ),
          ),
        );
      },
    );
  }
}

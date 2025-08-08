import 'package:manifest/core/shared/widgets/sliders/custom_shapes/gradient_rectangular_track_shape.dart';
import 'package:manifest/helper/import.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// A customized range slider with gradient track
class GradientRangeSlider extends StatelessWidget {
  /// The current values of the range slider
  final SfRangeValues values;

  /// Callback when values change
  final ValueChanged<SfRangeValues> onChanged;

  /// Minimum value
  final double min;

  /// Maximum value
  final double max;

  /// Gradient for the active track portion
  final LinearGradient? trackGradient;

  /// Gradient for the thumbs
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

  const GradientRangeSlider({
    Key? key,
    required this.values,
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
        final double horizontalPadding = thumbRadius + 2.0;

        return Container(
          width: constraints.maxWidth,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: SfRangeSliderTheme(
            data: SfRangeSliderThemeData(
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
              activeLabelStyle: TextStyle(color: Colors.white, fontSize: 12),
              inactiveLabelStyle:
                  TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
              // Add trackCornerRadius to make the track match the rounded corners
              trackCornerRadius: trackHeight / 2,
            ),
            child: SfRangeSlider(
              min: min,
              max: max,
              values: values,
              onChanged: onChanged,
              interval: interval,
              showLabels: showLabels,
              showDividers: showDividers,
              trackShape: GradientRectangularTrackShape(
                gradient: trackGradient ?? defaultTrackGradient,
                trackHeight: trackHeight,
              ),
              startThumbIcon:
                  _buildThumbWidget(thumbGradient ?? defaultThumbGradient),
              endThumbIcon:
                  _buildThumbWidget(thumbGradient ?? defaultThumbGradient),
            ),
          ),
        );
      },
    );
  }

  Widget _buildThumbWidget(LinearGradient gradient) {
    return Container(
      width: thumbRadius * 2,
      height: thumbRadius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
        boxShadow: thumbElevation != null && thumbElevation! > 0
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: thumbElevation! * 2,
                  spreadRadius: 1,
                )
              ]
            : null,
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1.0,
        ),
      ),
    );
  }
}

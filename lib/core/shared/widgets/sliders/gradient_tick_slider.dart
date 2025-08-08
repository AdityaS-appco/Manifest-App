import 'package:manifest/core/shared/widgets/sliders/custom_shapes/gradient_tick_track_shape.dart';
import 'package:manifest/core/shared/widgets/sliders/custom_shapes/simple_circle_thumb_shape.dart';
import 'package:manifest/helper/import.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// Custom rounded gradient slider with tick marks that matches the design
class GradientTickSlider extends StatelessWidget {
  /// The current value of the slider
  final double value;

  /// Callback when value changes
  final ValueChanged<double> onChanged;

  /// Minimum value
  final double min;

  /// Maximum value
  final double max;

  /// The interval for dividing the slider
  final double? interval;

  /// Height of the track
  final double trackHeight;

  /// Radius of the thumb
  final double thumbRadius;

  /// Whether to show tick marks
  final bool showTicks;

  /// Custom track gradient
  final LinearGradient? trackGradient;

  const GradientTickSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.interval = 20.0,
    this.trackHeight = 20.0,
    this.thumbRadius = 8.0,
    this.showTicks = true,
    this.trackGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default purple gradient that matches the image
    LinearGradient defaultTrackGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: AppColors.topLightToBottomDarkPurpleGradient,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final double horizontalPadding = thumbRadius;

        return Container(
          width: constraints.maxWidth,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: SfSliderTheme(
            data: SfSliderThemeData(
              // Track appearance
              activeTrackHeight: trackHeight,
              inactiveTrackHeight: trackHeight,
              trackCornerRadius: trackHeight / 2,
              inactiveTrackColor: Colors.grey.withOpacity(0.15),

              // Thumb appearance
              thumbRadius: thumbRadius,
              thumbColor: Colors.white,
              overlayRadius: 0, // No overlay effect

              // Tick marks appearance
              activeTickColor: Colors.transparent,
              inactiveTickColor: showTicks
                  ? Colors.white.withOpacity(0.1)
                  : Colors.transparent,
              tickSize: const Size(1.0, 9.17), // Thinner tick marks
              tickOffset: const Offset(0, -15), // Move ticks down

              // Disable dividers and labels
              activeDividerRadius: 0.0,
              inactiveDividerRadius: 0.0,
            ),
            child: SfSlider(
              min: min,
              max: max,
              value: value,
              onChanged: (value) => onChanged(value),
              interval: interval,
              showTicks: showTicks,
              showLabels: false,
              showDividers: false,
              minorTicksPerInterval: 0,

              // Custom track shape with gradient
              trackShape: GradientTickTrackShape(
                gradient: trackGradient ?? defaultTrackGradient,
                trackHeight: trackHeight,
                thumbRadius: thumbRadius,
              ),

              // Simple white circle thumb
              thumbShape: SimpleCircleThumbShape(
                radius: thumbRadius,
                elevation: 2,
              ),
            ),
          ),
        );
      },
    );
  }
}

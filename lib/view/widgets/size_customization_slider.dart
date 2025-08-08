import 'package:manifest/helper/constant.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter/cupertino.dart';

class SizeCustomizationSlider extends StatefulWidget {
  const SizeCustomizationSlider({super.key});

  @override
  _SizeCustomizationSliderState createState() => _SizeCustomizationSliderState();
}

class _SizeCustomizationSliderState extends State<SizeCustomizationSlider> {
  double _sliderValue = 4;

  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
          activeTrackHeight: 8.0,
          inactiveTrackHeight: 6.0,
          activeDividerRadius: 8.0,
          inactiveDividerRadius: 0.0,
          thumbRadius: 10.0,
          inactiveDividerColor: primaryColor,
          activeDividerColor: primaryColor,
          activeTrackColor: primaryColor,
          thumbColor: primaryColor,
          tooltipBackgroundColor: primaryColor.withOpacity(0.4),
          inactiveTrackColor: inActiveSliderBgColor,
          overlayRadius: 13.0,
      ),
      child: SfSlider(
        value: _sliderValue,
        onChanged: (value) {
          setState(() {
            _sliderValue = value;
          });
        },
        stepDuration: const SliderStepDuration(seconds: 1),
        stepSize: 2,
        interval: 2,
        showDividers: true, // <-- Show dividers between segments
        min: 0,
        max: 10, // <-- Display the current value as a label
      ),
    );
  }
}
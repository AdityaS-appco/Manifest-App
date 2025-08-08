import 'package:flutter/cupertino.dart';
import 'package:manifest/helper/import.dart';

enum TimePeriod {
  day,
  week,
  month,
  year,
}

class TimePeriodSelectionIOSTabbar extends StatelessWidget {
  const TimePeriodSelectionIOSTabbar({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
  });

  final Rx<TimePeriod> currentTab;
  final Future Function(TimePeriod) onTabChanged;

  @override
  Widget build(BuildContext context) {
    Padding _buildCupertinoSlidingSegmentedControlItem(TimePeriod type) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10).r,
        child: Text(
          type.name.capitalize!,
          style: Get.appTextTheme.chipTextlargeCompressed.copyWith(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl<TimePeriod>(
          children: {
            TimePeriod.day:
                _buildCupertinoSlidingSegmentedControlItem(TimePeriod.day),
            TimePeriod.week:
                _buildCupertinoSlidingSegmentedControlItem(TimePeriod.week),
            TimePeriod.month:
                _buildCupertinoSlidingSegmentedControlItem(TimePeriod.month),
            TimePeriod.year:
                _buildCupertinoSlidingSegmentedControlItem(TimePeriod.year),
          },
          thumbColor: Colors.white.withOpacity(0.05),
          backgroundColor: Colors.white.withOpacity(0.05),
          groupValue: currentTab.value,
          padding: const EdgeInsets.all(3).r,
          onValueChanged: (TimePeriod? timePeriod) async {
            await onTabChanged(timePeriod ?? TimePeriod.day);
            currentTab.value = timePeriod ?? TimePeriod.day;
          }),
    );
  }
}

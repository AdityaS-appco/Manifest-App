import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:manifest/core/theme/app_colors.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';

class CountdownPickerBottomsheet extends StatelessWidget {
  final Function(int) onTimerSelected;
  final int? initialMinutes;

  const CountdownPickerBottomsheet({
    Key? key,
    required this.onTimerSelected,
    this.initialMinutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controller for the bottom sheet
    final controller = Get.put(TimerSelectionController(initialMinutes));

    return CustomBottomSheet(
      title: "How long do you want to play\nsounds outside the app?",
      titleAlignment: Alignment.center,
      hasBackButton: false,
      showDragHandle: true,
      primaryButtonText: "Save",
      backgroundColor: const Color(0xFF252525).withOpacity(0.7),
      blurAmount: 64,
      onPrimaryButtonPressed: () {
        onTimerSelected(controller.selectedDuration.value);
        Get.back();
      },
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title text

          SizedBox(height: 24.h),

          // Time picker container with blur effect
          BlurContainer(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              width: double.maxFinite,
              height: 220.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.5, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: _buildTimePicker(controller),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker(TimerSelectionController controller) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Value wheel
          SizedBox(
            width: 100.w,
            child: ListWheelScrollView.useDelegate(
              controller: controller.valueScrollController,
              itemExtent: 50.h,
              perspective: 0.005,
              diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                controller.selectedValue.value = controller.timeValues[index];
                controller.updateSelectedDuration();
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: controller.timeValues.length,
                builder: (context, index) {
                  final value = controller.timeValues[index];
                  final isSelected =
                      index == controller.valueScrollController.selectedItem;

                  return _buildWheelItem(
                    text: value.toString(),
                    isSelected: isSelected,
                  );
                },
              ),
            ),
          ),

          // Unit wheel
          SizedBox(
            width: 100.w,
            child: ListWheelScrollView.useDelegate(
              controller: controller.unitScrollController,
              itemExtent: 50.h,
              perspective: 0.005,
              diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                controller.selectedUnit.value = controller.timeUnits[index];
                controller.updateSelectedDuration();
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: controller.timeUnits.length,
                builder: (context, index) {
                  final unit = controller.timeUnits[index];
                  final isSelected =
                      index == controller.unitScrollController.selectedItem;

                  return _buildWheelItem(
                    text: unit,
                    isSelected: isSelected,
                  );
                },
              ),
            ),
          ),

          // Lock icon
          if (controller.showLockIcon)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Icon(
                Icons.lock_outline,
                color: Colors.white.withOpacity(0.5),
                size: 18.r,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWheelItem({required String text, required bool isSelected}) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
          fontSize: isSelected ? 22.sp : 16.sp,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}

class TimerSelectionController extends GetxController {
  final int? initialMinutes;
  final bool showLockIcon = true;

  TimerSelectionController([this.initialMinutes]);

  // Available time values
  final List<dynamic> timeValues = [5, 10, 15, 20, 30, 1, 2, "Continuous"];

  // Available time units
  final List<String> timeUnits = [
    "min",
    "min",
    "min",
    "min",
    "min",
    "hr",
    "hr",
    ""
  ];

  // Selected values
  final RxInt selectedValue = 20.obs;
  final RxString selectedUnit = "min".obs;

  // Final selected duration in minutes
  final RxInt selectedDuration = 20.obs;

  // Scroll controllers for wheel pickers
  late FixedExtentScrollController valueScrollController;
  late FixedExtentScrollController unitScrollController;

  @override
  void onInit() {
    super.onInit();

    // Set initial selection based on provided minutes
    if (initialMinutes != null) {
      setPreselectedTime(initialMinutes!);
    }

    // Initialize scroll controllers with default values if no initial minutes
    int initialValueIndex = timeValues.indexOf(selectedValue.value);
    if (initialValueIndex < 0) initialValueIndex = 3; // Default to 20 min

    int initialUnitIndex = timeUnits.indexOf(selectedUnit.value);
    if (initialUnitIndex < 0) initialUnitIndex = 0; // Default to "min"

    valueScrollController =
        FixedExtentScrollController(initialItem: initialValueIndex);
    unitScrollController =
        FixedExtentScrollController(initialItem: initialUnitIndex);
  }

  void updateSelectedDuration() {
    if (selectedValue.value == "Continuous") {
      // Special case for continuous playback
      selectedDuration.value = -1; // Use -1 to indicate continuous playback
      return;
    }

    if (selectedUnit.value == "hr") {
      // Convert hours to minutes
      selectedDuration.value = selectedValue.value * 60;
    } else {
      selectedDuration.value = selectedValue.value;
    }
  }

  void setPreselectedTime(int minutes) {
    if (minutes == -1) {
      // Handle continuous
      selectedValue.value = 0;
      selectedUnit.value = "";

      // Find the right indices
      int valueIndex = timeValues.indexOf("Continuous");
      int unitIndex = timeUnits.indexOf("");

      if (valueIndex >= 0 && unitIndex >= 0) {
        valueScrollController =
            FixedExtentScrollController(initialItem: valueIndex);
        unitScrollController =
            FixedExtentScrollController(initialItem: unitIndex);
      }
      return;
    }

    if (minutes >= 60 && minutes % 60 == 0) {
      // Handle hours
      int hours = minutes ~/ 60;
      if (timeValues.contains(hours)) {
        selectedValue.value = hours;
        selectedUnit.value = "hr";

        // Find the right indices
        int valueIndex = timeValues.indexOf(hours);
        int unitIndex = timeUnits.indexOf("hr");

        if (valueIndex >= 0 && unitIndex >= 0) {
          valueScrollController =
              FixedExtentScrollController(initialItem: valueIndex);
          unitScrollController =
              FixedExtentScrollController(initialItem: unitIndex);
        }
      }
    } else if (timeValues.contains(minutes)) {
      // Handle minutes
      selectedValue.value = minutes;
      selectedUnit.value = "min";

      // Find the right indices
      int valueIndex = timeValues.indexOf(minutes);
      int unitIndex = timeUnits.indexOf("min");

      if (valueIndex >= 0 && unitIndex >= 0) {
        valueScrollController =
            FixedExtentScrollController(initialItem: valueIndex);
        unitScrollController =
            FixedExtentScrollController(initialItem: unitIndex);
      }
    }

    updateSelectedDuration();
  }

  @override
  void onClose() {
    valueScrollController.dispose();
    unitScrollController.dispose();
    super.onClose();
  }
}

/// Show the timer selection bottomsheet
void showTimerSelectionBottomsheet({
  required Function(int) onTimerSelected,
  int? initialMinutes,
}) {
  Get.bottomSheet(
    CountdownPickerBottomsheet(
      onTimerSelected: onTimerSelected,
      initialMinutes: initialMinutes,
    ),
    isScrollControlled: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
  );
}

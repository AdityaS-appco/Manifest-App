import 'package:flutter/cupertino.dart';
import 'package:flutter_picker_plus/flutter_picker_plus.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/helper/import.dart';

import 'custom_bottomsheet.dart';

class TimePickerBottomsheet extends StatelessWidget {
  const TimePickerBottomsheet({
    super.key,
    this.title,
    this.selectedTimeInMinutes,
    required this.onTimePick,
  });
  
  final String? title;
  final Function(int) onTimePick;
  final int? selectedTimeInMinutes;
  
  @override
  Widget build(BuildContext context) {
    // Default to 0 minutes (12:00 AM) if no initial time is provided
    final int initialTotalMinutes = selectedTimeInMinutes ?? 0;
    
    // Create an RxInt to track selected minutes
    final RxInt selectedMinutes = initialTotalMinutes.obs;
    
    // Convert minutes to hours and minutes for the picker
    final int initialHours = initialTotalMinutes ~/ 60;
    final int initialMinutes = initialTotalMinutes % 60;
    
    // Create an initial DateTime to use with the picker
    // We only care about hours and minutes, not the actual date
    final DateTime initialTime = DateTime(
      2022, 1, 1, 
      initialHours < 12 ? initialHours : initialHours - 12,
      initialMinutes,
      0, // seconds
      0, // milliseconds
      initialHours >= 12 ? 1 : 0 // 0 for AM, 1 for PM
    );
    
    return CustomBottomSheet(
      title: title ?? "Select time",
      titleAlignment: Alignment.center,
      hasBackButton: false,
      showDragHandle: true,
      primaryButtonText: "Save",
      onPrimaryButtonPressed: () {
        // Just pass the selected minutes value directly
        onTimePick(selectedMinutes.value);
        Get.back();
      },
      body: Column(
        children: [
          BlurContainer(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              width: double.maxFinite,
              height: 230.h,
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
                child: Center(
                  child: Picker(
                    height: 220.h,
                    adapter: DateTimePickerAdapter(
                      type: PickerDateTimeType.kHM_AP, // Hour, Minute, AM/PM picker
                      value: initialTime,
                      strAMPM: const ['AM', 'PM'],
                    ),
                    squeeze: 1.2,
                    hideHeader: true,
                    looping: false,
                    selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                      background: Color.fromARGB(30, 255, 255, 255),
                    ),
                    selectedTextStyle: customTextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    textStyle: customTextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    backgroundColor: Colors.transparent,
                    containerColor: Colors.transparent,
                    itemExtent: 40,
                    
                    // Handle time selection
                    onSelect: (Picker picker, int index, List<int> selected) {
                      final DateTime? pickedTime = (picker.adapter as DateTimePickerAdapter).value;
                      if (pickedTime != null) {
                        // Convert the picked time to total minutes
                        int hours = pickedTime.hour;
                        int minutes = pickedTime.minute;
                        int totalMinutes = (hours * 60) + minutes;
                        
                        // Update the reactive state
                        selectedMinutes.value = totalMinutes;
                      }
                    },
                  ).makePicker(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
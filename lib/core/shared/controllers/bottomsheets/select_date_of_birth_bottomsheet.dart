
import 'package:flutter_picker_plus/flutter_picker_plus.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/import.dart';

class SelectDateOfBirthBottomsheet extends StatelessWidget {
  const SelectDateOfBirthBottomsheet({
    super.key,
    required this.selectedDate,
    required this.onSavePressed,
  });

  final Function(DateTime?) onSavePressed;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    Rx<DateTime?> _selectedDate = Rx<DateTime?>(selectedDate);

    return CustomBottomSheet(
      title: "Date of Birth",
      titleAlignment: Alignment.center,
      hasBackButton: false,
      showDragHandle: true,
      primaryButtonText: "Save",
      onPrimaryButtonPressed: () {
        /// * Only save if date is selected
        if (_selectedDate.value != null) {
          onSavePressed(_selectedDate.value);
          Get.back();
        }
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
                      type: PickerDateTimeType.kMDY, // Year, Month, Day picker
                      months: const [
                        'January',
                        'February',
                        'March',
                        'April',
                        'May',
                        'June',
                        'July',
                        'August',
                        'September',
                        'October',
                        'November',
                        'December'
                      ],
                      yearBegin: 1900,
                      yearEnd: DateTime.now().year,
                      value: selectedDate ??
                          DateTime.now(), // Default selected date
                    ),
                    squeeze: 1,
                    hideHeader: true,
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: Colors.transparent,
                    containerColor: Colors.transparent,
                    itemExtent: 40,

                    /// * Add onChange handler
                    onSelect: (Picker picker, int index, List<int> selected) {
                      final DateTime? pickedDate =
                          (picker.adapter as DateTimePickerAdapter).value;
                      if (pickedDate != null) {
                        _selectedDate.value = pickedDate;
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

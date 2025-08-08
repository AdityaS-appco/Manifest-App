import 'package:flutter_picker_plus/flutter_picker_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/faded_at_vertical_edges_mask.dart';
import 'package:manifest/helper/import.dart';

class SceneSetTimerForOutsideAppPlaybackBottomsheet extends StatelessWidget {
  const SceneSetTimerForOutsideAppPlaybackBottomsheet({
    super.key,
    required this.selectedDurationInMinutes,
    required this.onSavePressed,
  });

  final Function(int?) onSavePressed;
  final int? selectedDurationInMinutes;

  /// * Available durations
  static const _availableDurationsInMinutes = [5, 10, 15, 20, 30, 60];

  @override
  Widget build(BuildContext context) {
    /// * Create an observable for selected duration
    final Rx<int?> _selectedDurationInMinutes =
        Rx<int?>(selectedDurationInMinutes);

    /// * Get initial selected index
    final initialIndex = selectedDurationInMinutes != null
        ? _availableDurationsInMinutes.indexOf(selectedDurationInMinutes!)
        : 3; // Default to 20 min (index 3)

    /// * Create an observable for the unit (min/hr)
    final Rx<String> _unit =
        Rx<String>(selectedDurationInMinutes == 1 ? 'hr' : 'min');

    return CustomBottomSheet(
      title: "How long do you want to play \nsounds outside the app?",
      titleAlignment: Alignment.center,
      titleStyle: Get.appTextTheme.titleLargeRounded.copyWith(
        height: 1.44,
      ),
      hasBackButton: false,
      showDragHandle: true,
      primaryButtonText: "Save",
      onPrimaryButtonPressed: () {
        /// * Only save if duration is selected
        if (_selectedDurationInMinutes.value != null) {
          Get.back();
          Future.delayed(const Duration(milliseconds: 300), () {
            onSavePressed(_selectedDurationInMinutes.value);
          });
        }
      },
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 260.w,
            height: 226.h,
            child: FadedAtVerticalEdgesMask(
              child: Stack(
                children: [
                  /// * Number Picker
                  Picker(
                    height: 226.h,
                    selecteds: [initialIndex],
                    diameterRatio: 1.1,
                    itemExtent: 50,
                    adapter: PickerDataAdapter<int>(
                      data: _availableDurationsInMinutes.map((duration) {
                        return PickerItem<int>(
                          value: duration,
                          text: Text(
                            duration % 60 == 0
                                ? '${duration ~/ 60}'
                                : '$duration',
                          ),
                        );
                      }).toList(),
                    ),
                    textStyle: helveticaPageTitleTextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      letterSpacing: -0.4,
                    ),
                    selectedTextStyle: helveticaPageTitleTextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1,
                      letterSpacing: 0.2,
                    ),
                    squeeze: 1,
                    hideHeader: true,
                    backgroundColor: Colors.transparent,
                    containerColor: Colors.transparent,

                    /// * Add onChange handler
                    onSelect: (Picker picker, int index, List<int> selected) {
                      final int? pickedDuration =
                          _availableDurationsInMinutes[selected[0]];
                      if (pickedDuration != null) {
                        _selectedDurationInMinutes.value = pickedDuration;
                        _unit.value = pickedDuration % 60 == 0 ? 'hr' : 'min';
                      }
                    },
                    selectionOverlay: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                    ),
                  ).makePicker(),

                  /// * Fixed Unit Display
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 157.w,
                    child: Center(
                      child: Obx(
                        () => Text(
                          _unit.value,
                          style: helveticaPageTitleTextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                            height: 1.48,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// * Lock
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 224.w,
                    child: Center(
                      child: SvgPicture.asset(
                        IconAllConstants.newLock01,
                        color: Colors.white.withOpacity(0.5),
                        height: 16.r,
                        width: 16.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_picker_plus/flutter_picker_plus.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/faded_at_vertical_edges_mask.dart';
import 'package:manifest/helper/import.dart';

class PlayerSetLoopCountBottomsheet extends StatelessWidget {
  const PlayerSetLoopCountBottomsheet({
    super.key,
    required this.selectedCount,
    required this.onSavePressed,
  });

  final Function(int) onSavePressed;
  final int? selectedCount;

  /// * Available loop counts
  static const _availableCounts = [1, 2, 3, 4, 5, -1];

  @override
  Widget build(BuildContext context) {
    /// * Create an observable for selected count
    final Rx<int?> _selectedLoopCount = Rx<int?>(selectedCount);

    /// * Get initial selected index
    final initialIndex = selectedCount != null
        ? _availableCounts.indexOf(selectedCount!)
        : 3; // Default to 4 (index 3)

    return CustomBottomSheet(
      title: "How many times should \nthis affirmation loop?",
      titleAlignment: Alignment.center,
      hasBackButton: false,
      showDragHandle: true,
      primaryButtonText: "Save",
      onPrimaryButtonPressed: () {
        /// * Only save if count is selected
        Get.back();
        Future.delayed(const Duration(milliseconds: 300), () {
          onSavePressed(_selectedLoopCount.value!);
        });
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
                    adapter: PickerDataAdapter<int?>(
                      data: _availableCounts.map((count) {
                        return PickerItem<int>(
                          value: count,
                          text: Text(
                            count == -1 
                                ? 'Infinite' 
                                : '$count',
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
                      _selectedLoopCount.value = _availableCounts[selected[0]];
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

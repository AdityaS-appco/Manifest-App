import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:manifest/core/theme/app_text_styles.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/constants/assets/icons_constants.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/features/media_player/models/voice_option.dart';
import 'package:manifest/core/shared/widgets/app_cached_image.dart';
import 'package:manifest/features/paywall/secondary_paywall_screen.dart';

/// * Controller for managing voice selection state
class SelectVoiceController extends GetxController {
  final RxList<VoiceOption> _voiceOptions = <VoiceOption>[].obs;
  final RxInt _selectedIndex = (-1).obs;

  List<VoiceOption> get voiceOptions => _voiceOptions;
  int get selectedIndex => _selectedIndex.value;

  void initializeOptions(List<VoiceOption> options) {
    _voiceOptions.value = options;
    // Find the initially selected option
    _selectedIndex.value = options.indexWhere((option) => option.isSelected);
  }

  void selectVoice(int index) {
    if (index < 0 || index >= _voiceOptions.length) return;
    if (_voiceOptions[index].isLocked) {
      NavigationUtil.toWithDelay(navigateTo: () => const SecondaryPaywall());
      return;
    }

    // Update the selected index
    _selectedIndex.value = index;

    // Update the options list to reflect the new selection
    _voiceOptions.value = _voiceOptions.map((option) {
      return option.copyWith(
          isSelected: _voiceOptions.indexOf(option) == index);
    }).toList();
  }

  VoiceOption? getSelectedVoice() {
    if (_selectedIndex.value < 0 ||
        _selectedIndex.value >= _voiceOptions.length) {
      return null;
    }
    return _voiceOptions[_selectedIndex.value];
  }
}

class SelectVoiceBottomSheet extends StatelessWidget {
  final List<VoiceOption> voiceOptions;
  final Function(VoiceOption) onSave;
  final VoiceOption currentVoiceOption;

  const SelectVoiceBottomSheet({
    Key? key,
    required this.voiceOptions,
    required this.onSave,
    required this.currentVoiceOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(SelectVoiceController());
    controller.initializeOptions(voiceOptions);

    return CustomBottomSheet(
      title: 'Select Voice',
      primaryButtonText: 'Save',
      onPrimaryButtonPressed: () {
        final selectedVoice = controller.getSelectedVoice();
        if (selectedVoice != null) {
          onSave(selectedVoice);
        }
      },
      hasBackButton: false,
      titleAlignment: Alignment.center,
      buttonsTopPadding: 36.r,
      body: Obx(() => GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.77,
              mainAxisSpacing: 20,
              crossAxisSpacing: 15.15,
            ),
            shrinkWrap: true,
            itemCount: controller.voiceOptions.length,
            itemBuilder: (context, index) {
              final option = controller.voiceOptions[index];
              return VoiceCard(
                voiceOption: option,
                onPressed: () => controller.selectVoice(index),
              );
            },
          )),
    );
  }
}

class VoiceCard extends StatelessWidget {
  final VoiceOption voiceOption;
  final VoidCallback onPressed;

  const VoiceCard({
    Key? key,
    required this.voiceOption,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voiceOption.isLocked ? null : onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AppCachedImage(
                borderRadius: BorderRadius.circular(50),
                imageUrl: voiceOption.imageUrl ?? '',
                width: 74.5,
                height: 74.5,
                border: voiceOption.isSelected
                    ? Border.all(
                        color: Colors.white,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignInside,
                      )
                    : null,
              ),
              if (voiceOption.isLocked)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        IconAllConstants.lock01,
                        width: 18.r,
                        height: 18.r,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          12.height,
          Text(voiceOption.name,
              style: helveticaPageTitleTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: voiceOption.isSelected
                    ? Colors.white
                    : Colors.white.withOpacity(0.6),
              )),
        ],
      ),
    );
  }
}

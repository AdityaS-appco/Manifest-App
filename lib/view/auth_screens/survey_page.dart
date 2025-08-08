import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/survey_others_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/flexible_wrap_grid.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/core/shared/widgets/chips/selectable_chip.dart';
import 'package:manifest/core/utils/extensions/get_context.extension.dart';
import 'package:manifest/features/navbar/navbar_screen.dart';
import 'package:manifest/view/auth_screens/survey_controller.dart';
import 'package:manifest/view/auth_screens/survey_response_model.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';

class SurveyPage extends StatelessWidget {
  const SurveyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Get.put to ensure controller is initialized
    final SurveyController controller = Get.put(SurveyController());
    
    return CommonAuthFormScaffold(
      title: 'How did you hear about Manifest?',
      subtitle: 'Please let us know how you found us',
      onBackPress: () => Get.offAll(() => NavbarScreen()),
      bottomsheet: Obx(
        () => PrimaryPageButton.text(
          text: AppStrings.continueText,
          isEnabled: controller.selectedSurvey != null,
          onPressed: () async {
            if (controller.selectedSurvey != null) {
              /// * If "Other" is selected, show bottomsheet for additional text
              if (controller.selectedSurvey!.name?.toLowerCase() == 'other') {
                AppBottomSheet.showWithDragHandler(
                  SurveyOthersBottomsheet(
                    onSavePressed: (string) async {
                      if (string.isNotEmpty) {
                        /// * save survey
                        controller.setSurveyComment(string);
                        if (await controller.saveSurvey()) {
                          /// * Navigate to main screen on success
                          Get.offAll(() => NavbarScreen());
                        }
                      }
                    },
                  ),
                );
              } else {
                /// * Otherwise just save the survey and continue
                if (await controller.saveSurvey()) {
                  /// * Navigate to main screen on success
                  Get.offAll(() => NavbarScreen());
                }
              }
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: kSize.height * 0.1),
        child: _buildBody(controller),
      ),
    );
  }

  Widget _buildBody(SurveyController controller) {
    return Obx(() {
      print('Building body - Loading: ${controller.isProfileLoading.value}, Error: ${controller.hasError.value}, List length: ${controller.surveyList.length}');
      
      if (controller.isProfileLoading.value) {
        /// * Show loading indicator while fetching data
        return SizedBox(
          height: Get.height * 0.5,
          child: Center(
            child: dotsWaveLoading(),
          ),
        );
      } else if (controller.hasError.value) {
        /// * Show error message if an error occurred
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.errorMessage.value,
                style: Get.appTextTheme.emptyStateText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => controller.fetchSurveyList(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      } else if (controller.surveyList.isEmpty) {
        /// * Show empty state
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No survey options available',
                style: Get.appTextTheme.emptyStateText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => controller.fetchSurveyList(),
                child: const Text('Refresh'),
              ),
            ],
          ),
        );
      } else {
        /// * Display the survey options
        return _buildSurveyGrid(controller);
      }
    });
  }

  Widget _buildSurveyGrid(SurveyController controller) {
    return FlexibleWrapGrid<SurveyItem>(
      items: controller.surveyList,
      itemBuilder: (context, item, index) => _buildSurveyChip(controller, item, index),
    );
  }

  Widget _buildSurveyChip(SurveyController controller, SurveyItem item, int index) {
    return Obx(
      () => SelectableChip(
        label: item.name ?? "",
        isSelected: controller.selectedSurveyIndex.value == index,
        onTap: () {
          controller.setSelectedSurveyIndex(index);
        },
        networkImageUrl: item.image,
      ),
    );
  }
}
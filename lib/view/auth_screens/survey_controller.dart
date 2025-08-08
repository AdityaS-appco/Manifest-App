import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:manifest/core/shared/controllers/profile_controller.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/survey_others_bottomsheet.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/features/navbar/navbar_screen.dart';
import 'package:manifest/core/utils/loading_util.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/view/auth_screens/survey_response_model.dart';

import '../../helper/import.dart';

class SurveyController extends BaseController with ProfileControllerMixin {
  final ApiService _apiService = Get.find<ApiService>();

  /// Observable survey list
  final RxList<SurveyItem> surveyList = <SurveyItem>[].obs;

  /// Selected survey index and item
  final RxInt selectedSurveyIndex = RxInt(-1);
  
  /// Loading and error states (using reactive variables)


  SurveyItem? get selectedSurvey => selectedSurveyIndex.value >= 0 &&
          selectedSurveyIndex.value < surveyList.length
      ? surveyList[selectedSurveyIndex.value]
      : null;

  /// Comment for "Other" option
  final RxString surveyComment = ''.obs;

  @override
  void onInit() {
    super.onInit();
    LogUtil.log('SurveyController onInit called');
    
    /// * Fetch survey list when controller initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchSurveyList();
    });
  }

  @override
  void onReady() {
    super.onReady();
    LogUtil.log('SurveyController onReady called');
    
    /// * Backup call in case onInit doesn't work
    if (surveyList.isEmpty && !isProfileLoading.value) {
      fetchSurveyList();
    }
  }

  /// * Set selected survey index
  void setSelectedSurveyIndex(int index) {
    selectedSurveyIndex.value = index;
    LogUtil.log('Selected survey index: $index');
  }

  /// * Set comment text
  void setSurveyComment(String text) {
    surveyComment.value = text;
  }

  /// * Check if "Other" option is selected
  bool get isOtherSelected {
    return selectedSurvey?.name?.toLowerCase() == 'other';
  }

  /// * Handle the selection and process flow
  void handleSurveySelection() {
    if (selectedSurvey == null) return;

    /// * If "Other" is selected, show bottomsheet for additional input
    if (isOtherSelected) {
      AppBottomSheet.showWithDragHandler(
        SurveyOthersBottomsheet(
          onSavePressed: (text) {
            if (text.isNotEmpty) {
              setSurveyComment(text);
              saveSurvey();
            }
          },
        ),
      );
    } else {
      /// * Otherwise, just save the survey
      saveSurvey();
    }
  }

  /// * Custom loading management for reactive UI
  void startReactiveLoading() {
    isProfileLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    LogUtil.log('Started loading: ${isProfileLoading.value}');
  }

  void stopReactiveLoading() {
    isProfileLoading.value = false;
    LogUtil.log('Stopped loading: ${isProfileLoading.value}');
  }

  void handleReactiveFailure(String message) {
    hasError.value = true;
    errorMessage.value = message;
    isProfileLoading.value = false;
    LogUtil.log('Error occurred: $message');
  }

  /// * Fetch survey list from API
  Future<void> fetchSurveyList() async {
    LogUtil.log('fetchSurveyList called');
    
    try {
      startReactiveLoading();

      final response = await _apiService.request(
        apiEndPoint: ApiService.getSurvey,
        isGet: true,
        withToken: true,
      );

      LogUtil.log('API Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        LogUtil.log('Response data: $responseData');

        if (responseData['status'] == true) {
          final surveyResponse = SurveyResponseModel.fromJson(responseData);

          if (surveyResponse.data != null && surveyResponse.data!.isNotEmpty) {
            /// * Clear existing data and assign new data
            surveyList.clear();
            surveyList.addAll(surveyResponse.data!);

            /// * Log the received options for debugging
            LogUtil.log('Received ${surveyList.length} survey options');
            for (var item in surveyList) {
              LogUtil.log('Survey option: ${item.id} - ${item.name}');
            }
            
            /// * Force UI update
            surveyList.refresh();
          } else {
            handleReactiveFailure('No survey options available');
          }
        } else {
          handleReactiveFailure(
              responseData['message'] ?? 'Failed to load survey data');
        }
      } else {
        handleReactiveFailure('Server error: ${response.statusCode}');
      }
    } catch (e) {
      LogUtil.log("Error fetching survey list: $e");
      handleReactiveFailure('Failed to load survey data. Please try again.');
    } finally {
      stopReactiveLoading();
    }
  }

  /// * Save selected survey to API
  Future<bool> saveSurvey() async {
    try {
      if (selectedSurvey == null) {
        handleReactiveFailure('Please select a survey option');
        return false;
      }

      LoadingUtil.show();

      /// * Create form data for the request
      final Map<String, dynamic> data = {
        'user_id': profile.id?.toString() ?? 0,
        'survey_id': selectedSurvey!.id.toString(),
      };

      /// * If "Other" is selected, include the comment parameter
      if (isOtherSelected && surveyComment.value.isNotEmpty) {
        /// * Use "comment" parameter as per backend requirement
        data['comment'] = surveyComment.value;
      }

      final response = await _apiService.request(
        apiEndPoint: ApiService.saveSurvey,
        data: data,
        isPost: true,
        withToken: true,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        handleReactiveFailure('Server error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      handleReactiveFailure('Error saving survey: $e');
      return false;
    } finally {
      LoadingUtil.dismiss();
    }
  }
}
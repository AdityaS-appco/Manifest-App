import 'dart:convert';

import 'package:get/get.dart';
import 'package:manifest/core/constants/argument_constants.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/models/explore_tab_model/featured_tab_model/get_tracks_by_id_model.dart';
import 'package:manifest/services/api_service.dart';

class TracksByIdController extends BaseController {
  final ApiService _apiService;

  TracksByIdController(this._apiService);

  /// * data variables
  Rx<TracksListResponseModel?> trackResponse =
      Rx<TracksListResponseModel?>(null);
  Rx<Track?> get track => Rx(trackResponse.value?.data);

  /// * getters
  int get trackID => Get.arguments?[ArgumentConstants.trackID] as int;

  @override
  void onInit() {
    getTrackByID(trackID);
    super.onInit();
  }

  /// * get track by id
  Future<void> getTrackByID(int trackID) async {
    startLoading();
    try {
      LogUtil.v('cccc $trackID');
      var response = await _apiService.request(
          apiEndPoint:
              "${ApiService.trackById}$trackID?device_id=${LocalStorage.deviceID.toString()}&language=${LocalStorage.appLanguage.toString()}",
          isGet: true,
          withToken: LocalStorage.userAccessToken == '' ? false : true);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        trackResponse.value = TracksListResponseModel.fromJson(data);
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
      } else {
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      handleFailure(e.toString());
      LogUtil.v('error while getting track by id: $e');
    } finally {
      stopLoading();
    }
  }
}

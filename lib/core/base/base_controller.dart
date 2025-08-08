import 'package:get/get.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/core/utils/loading_util.dart';
import 'package:manifest/core/utils/toast_util.dart';

/// * @author: Alok Singh
/// * @description: controller to be inherited by other controllers for handling loading and error states
class BaseController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool showingLoading = false.obs;

  /// Error state
  final RxBool hasError = false.obs;

  /// Error message
  final RxString errorMessage = ''.obs;

  startLoading({bool showLoading = false}) {
    isLoading.value = true;
    if (showLoading) {
      showingLoading.value = true;
      LoadingUtil.show();
    }
  }

  stopLoading() {
    isLoading.value = false;
    if (showingLoading.value) {
      showingLoading.value = false;
      LoadingUtil.dismiss();
    }
  }

  handleFailure(String message, {bool showToast = true}) {
    hasError.value = true;
    errorMessage.value = message;
    stopLoading();
    LogUtil.log(message);
    if (showToast) {
      ToastUtil.error(message);
    }
  }
}

import 'package:get/get.dart';

mixin ProfileLoadingStateMixin {
  final RxBool isInitialLoading = false.obs;
  final RxBool isUpdatingName = false.obs;
  final RxBool isUpdatingEmail = false.obs;
  final RxBool isUpdatingPassword = false.obs;
  final RxBool isUpdatingGender = false.obs;
  final RxBool isUpdatingDOB = false.obs;
  final RxBool isUpdatingProfileImage = false.obs;
  final RxBool isUpdatingProfile = false.obs;
  final RxBool isVerifyingPasswordForEmailUpdate = false.obs;
  final RxBool isUpdatingEmailWithOtp = false.obs;
  final RxBool isDeletingAccount = false.obs;
  final RxBool isAccountSettingScreenLoading = false.obs;

  void startInitialLoading() => isInitialLoading.value = true;
  void stopInitialLoading() => isInitialLoading.value = false;

  void startUpdatingName() => isUpdatingName.value = true;
  void stopUpdatingName() => isUpdatingName.value = false;

  void startUpdatingEmail() => isUpdatingEmail.value = true;
  void stopUpdatingEmail() => isUpdatingEmail.value = false;

  void startUpdatingPassword() => isUpdatingPassword.value = true;
  void stopUpdatingPassword() => isUpdatingPassword.value = false;

  void startUpdatingGender() => isUpdatingGender.value = true;
  void stopUpdatingGender() => isUpdatingGender.value = false;

  void startUpdatingDOB() => isUpdatingDOB.value = true;
  void stopUpdatingDOB() => isUpdatingDOB.value = false;

  void startUpdatingProfileImage() => isUpdatingProfileImage.value = true;
  void stopUpdatingProfileImage() => isUpdatingProfileImage.value = false;

  void startUpdatingProfile() => isUpdatingProfile.value = true;
  void stopUpdatingProfile() => isUpdatingProfile.value = false;

  void startVerifyingPasswordForEmailUpdate() => isVerifyingPasswordForEmailUpdate.value = true;
  void stopVerifyingPasswordForEmailUpdate() => isVerifyingPasswordForEmailUpdate.value = false;

  void startUpdatingEmailWithOtp() => isUpdatingEmailWithOtp.value = true;
  void stopUpdatingEmailWithOtp() => isUpdatingEmailWithOtp.value = false;

  void startDeletingAccount() => isDeletingAccount.value = true;
  void stopDeletingAccount() => isDeletingAccount.value = false;

  void startAccountSettingScreenLoading() => isAccountSettingScreenLoading.value = true;
  void stopAccountSettingScreenLoading() => isAccountSettingScreenLoading.value = false;
}

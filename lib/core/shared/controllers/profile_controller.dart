import 'package:image_picker/image_picker.dart';
import 'package:manifest/core/base/base_controller.dart';
import 'package:manifest/core/services/profile_service.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/select_date_of_birth_bottomsheet.dart';
import 'package:manifest/core/utils/media_util.dart';
import 'package:manifest/core/utils/mixins/profile_loading_state_mixin.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/models/profile_model.dart';
import 'package:manifest/features/settings/views/edit_gender_screen.dart';
import 'package:manifest/features/settings/views/edit_name_screen.dart';
import 'package:manifest/core/utils/mixins/profile_form_validation_mixin.dart';

class ProfileController extends BaseController
    with ProfileLoadingStateMixin, ProfileFormValidationMixin {
  final ProfileService _profileService;

  ProfileController(this._profileService);

  Rx<Profile> _profile = Profile().obs;
  Profile get profile => _profile.value;

  final RxString selectedGender = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeControllers(
      initialName: profile.name,
    );
    fetchProfile();
    _initializeName();
    _initializeGender();
  }

  @override
  void onClose() {
    selectedGender.value = '';
    nameController.dispose();
    disposeControllers();
    super.onClose();
  }

  /// * fetch profile
  Future<void> fetchProfile() async {
    startInitialLoading();
    final result = await _profileService.getProfile();
    result.fold(
      onFailure: (failure) {
        stopInitialLoading();
        handleFailure(failure.message, showToast: true);
      },
      onSuccess: (data) {
        _profile.value = data;
        stopInitialLoading();
      },
    );
  }

  /// * navigate to edit name
  void navigateToEditName() {
    Get.to(() => const EditNameScreen());
  }

  /// * navigate to edit gender
  void navigateToEditGender() {
    Get.to(() => const EditGenderScreen());
  }

  /// * date of birth
  void pickAndUpdateDOB() {
    AppBottomSheet.show(
      SelectDateOfBirthBottomsheet(
        selectedDate: profile.dateOfBirth != null
            ? DateTime.parse(profile.dateOfBirth!)
            : DateTime.now(),
        onSavePressed: (date) async {
          if (date != null) {
            startLoading();
            startUpdatingDOB();
            startUpdatingProfile();
            final result = await _profileService.updateDateOfBirth(date);
            result.fold(
              onFailure: (failure) {
                stopLoading();
                stopUpdatingDOB();
                stopUpdatingProfile();
                ToastUtil.error(failure.message);
              },
              onSuccess: (data) {
                _profile.value = data;
                stopLoading();
                stopUpdatingDOB();
                stopUpdatingProfile();
                // Get.back();
                ToastUtil.success(
                  'Date of birth updated successfully',
                );
              },
            );
          }
        },
      ),
    );
  }

  /// * update profile image
  void pickAndUpdateProfileImage() async {
    try {
      final file = await MediaUtil.pickAndCropImage(
        imageSource: ImageSource.gallery,
      );
      startLoading();
      startUpdatingProfileImage();
      startUpdatingProfile();
      if (file != null) {
        final result = await _profileService.updateProfileImage(file);
        result.fold(
          onFailure: (failure) {
            stopLoading();
            stopUpdatingProfileImage();
            stopUpdatingProfile();
            ToastUtil.error(failure.message);
          },
          onSuccess: (data) {
            _profile.value = data;
            stopLoading();
            stopUpdatingProfileImage();
            stopUpdatingProfile();
            ToastUtil.success(
              'Profile image updated successfully',
            );
          },
        );
      } else {
        stopLoading();
        stopUpdatingProfileImage();
        stopUpdatingProfile();
      }
    } catch (e) {
      stopLoading();
      stopUpdatingProfileImage();
      stopUpdatingProfile();
      ToastUtil.error('Failed to update profile image. Please try again.');
    }
  }

  /// * NAME
  /// * initialize name
  void _initializeName() {
    if (profile.name != null) {
      nameController.text = profile.name!;
    }
  }

  /// * update name
  Future<void> updateName() async {
    try {
      startLoading();
      startUpdatingName();
      final result = await _profileService.updateName(nameController.text);
      result.fold(
        onFailure: (failure) {
          stopLoading();
          stopUpdatingName();
          ToastUtil.error(failure.message);
        },
        onSuccess: (data) {
          _profile.value = data;
          _initializeName();
          stopLoading();
          stopUpdatingName();
          NavigationUtil.backWithDelay(
            postNavigationCallback: () => ToastUtil.success(
              'Name updated successfully',
            ),
          );
        },
      );
    } catch (e) {
      stopLoading();
      stopUpdatingName();
      ToastUtil.error(e.toString());
    }
  }

  /// * GENDER
  /// * initialize gender
  void _initializeGender() {
    if (profile.gender != null) {
      selectedGender.value = profile.gender!;
    }
  }

  /// * select gender
  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  /// * update gender
  Future<void> updateGender() async {
    if (selectedGender.value.isEmpty) {
      ToastUtil.error('Please select a gender');
      return;
    }

    startLoading();
    startUpdatingGender();
    try {
      final result = await _profileService.updateGender(selectedGender.value);
      result.fold(
        onFailure: (failure) {
          stopLoading();
          stopUpdatingGender();
          ToastUtil.error(failure.message);
        },
        onSuccess: (data) {
          _profile.value = data;
          _initializeGender();
          stopLoading();
          stopUpdatingGender();
          NavigationUtil.backWithDelay(
            postNavigationCallback: () =>
                ToastUtil.success('Gender updated successfully'),
          );
        },
      );
    } catch (e) {
      stopLoading();
      stopUpdatingGender();
      ToastUtil.error(e.toString());
    }
  }

  /// * Verify password to update email
  Future<bool> verifyPasswordToUpdateEmail({
    required String email,
    required String password,
  }) async {
    try {
      startLoading();
      startUpdatingEmail();

      final result = await _profileService.verifyPasswordToUpdateEmail(
        email: email,
        password: password,
      );

      result.fold(
        onFailure: (failure) {
          stopLoading();
          stopUpdatingEmail();
          ToastUtil.error(failure.message);
          return false;
        },
        onSuccess: (_) {
          stopLoading();
          stopUpdatingEmail();
          ToastUtil.success("Otp is sent to your email");
          return true;
        },
      );

      return result.isSuccess;
    } catch (e) {
      stopLoading();
      stopUpdatingEmail();
      LogUtil.e('Error verifying password: ${e.toString()}');
      ToastUtil.error('Failed to verify password. Please try again.');
      return false;
    }
  }

  /// * Update email with OTP verification
  Future<bool> updateEmailWithOtp({
    required String email,
    required String otp,
  }) async {
    try {
      startLoading();
      startUpdatingEmail();

      final result = await _profileService.verifyEmailOtp(
        email: email,
        otp: otp,
      );

      result.fold(
        onFailure: (failure) {
          stopLoading();
          stopUpdatingEmail();
          ToastUtil.error(failure.message);
        },
        onSuccess: (_) {
          stopLoading();
          stopUpdatingEmail();
          ToastUtil.success('Email verified successfully');
          // Get.to(() => const ResetPassword());
        },
      );
      return result.isSuccess;
    } catch (e) {
      stopLoading();
      stopUpdatingEmail();
      LogUtil.e('Error verifying email OTP: ${e.toString()}');
      ToastUtil.error('Failed to verify email. Please try again.');
      return false;
    }
  }

  /// * Send OTP to email
  // Future<bool> sendOtpToEmail(String email) async {
  //   try {
  //     startLoading();
  //     startUpdatingEmail();

  //     final response = await _profileService.sendOtpToEmail(email);

  //     response.fold(
  //       onFailure: (failure) {
  //         stopLoading();
  //         stopUpdatingEmail();
  //         ToastUtil.error(failure.message);
  //       },
  //       onSuccess: (_) {
  //         stopLoading();
  //         stopUpdatingEmail();
  //         ToastUtil.success('Verification code sent to your email');
  //       },
  //     );
  //     return response.isSuccess;
  //   } catch (e) {
  //     stopLoading();
  //     stopUpdatingEmail();
  //     LogUtil.e('Error sending OTP: ${e.toString()}');
  //     ToastUtil.error('Failed to send verification code. Please try again.');
  //     return false;
  //   }
  // }
}

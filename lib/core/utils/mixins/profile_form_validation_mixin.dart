import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/core/utils/form_validator_util.dart';

mixin ProfileFormValidationMixin {
  /// Text Editing Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  /// Initialize controllers
  void initializeControllers({
    String? initialName,
    String? initialEmail,
    String? initialPassword,
    String? initialCurrentPassword,
    String? initialNewPassword,
    String? initialConfirmPassword,
    String? initialDateOfBirth,
  }) {
    nameController.text = initialName ?? '';
    newEmailController.text = initialEmail ?? '';
    passwordController.text = initialPassword ?? '';
    currentPasswordController.text = initialCurrentPassword ?? '';
    newPasswordController.text = initialNewPassword ?? '';
    confirmPasswordController.text = initialConfirmPassword ?? '';
    dateOfBirthController.text = initialDateOfBirth ?? '';
  }

  /// Dispose all controllers
  void disposeControllers() {
    nameController.dispose();
    newEmailController.dispose();
    passwordController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    dateOfBirthController.dispose();
  }

  /// ! form related properties
  /// form global keys for each form
  final updateEmailFormKey = GlobalKey<FormState>();
  final editNameFormKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();
  final setNewPasswordFormKey = GlobalKey<FormState>();
  final editProfileFormKey = GlobalKey<FormState>();

  /// isFormValid form validation state flags for each form
  RxBool isUpdateEmailFormValid = false.obs;
  RxBool isEditNameFormValid = false.obs;
  RxBool isChangePasswordFormValid = false.obs;
  RxBool isSetNewPasswordFormValid = false.obs;
  RxBool isEditProfileFormValid = false.obs;

  /// form validation utility methods to trigger validation (like in onChanged)
  void validateUpdateEmailForm() {
    isUpdateEmailFormValid.value =
        updateEmailFormKey.currentState?.validate() ?? false;
  }

  void validateEditNameForm() {
    isEditNameFormValid.value = 
        editNameFormKey.currentState?.validate() ?? false;
  }

  void validateChangePasswordForm() {
    isChangePasswordFormValid.value = 
        changePasswordFormKey.currentState?.validate() ?? false;
  }

  void validateSetNewPasswordForm() {
    isSetNewPasswordFormValid.value = 
        setNewPasswordFormKey.currentState?.validate() ?? false;
  }

  void validateEditProfileForm() {
    isEditProfileFormValid.value = 
        editProfileFormKey.currentState?.validate() ?? false;
  }
  /// reset form utility methods
  void resetUpdateEmailForm() {
    updateEmailFormKey.currentState?.reset();
    isUpdateEmailFormValid.value = false;
  }

  void resetEditNameForm() {
    editNameFormKey.currentState?.reset();
    isEditNameFormValid.value = false;
  }

  void resetChangePasswordForm() {
    changePasswordFormKey.currentState?.reset();
    isChangePasswordFormValid.value = false;
  }

  void resetSetNewPasswordForm() {
    setNewPasswordFormKey.currentState?.reset();
    isSetNewPasswordFormValid.value = false;
  }

  void resetEditProfileForm() {
    editProfileFormKey.currentState?.reset();
    isEditProfileFormValid.value = false;
  }
}

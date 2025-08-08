import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin ReachUsFormValidationMixin {
  /// Text Editing Controllers
  final TextEditingController messageController = TextEditingController();
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
    String? initialMessage,
    String? initialEmail,
    String? initialPassword,
    String? initialCurrentPassword,
    String? initialNewPassword,
    String? initialConfirmPassword,
    String? initialDateOfBirth,
  }) {
    messageController.text = initialMessage ?? '';
    newEmailController.text = initialEmail ?? '';
    passwordController.text = initialPassword ?? '';
    currentPasswordController.text = initialCurrentPassword ?? '';
    newPasswordController.text = initialNewPassword ?? '';
    confirmPasswordController.text = initialConfirmPassword ?? '';
    dateOfBirthController.text = initialDateOfBirth ?? '';
  }

  /// Dispose all controllers
  void disposeControllers() {
    messageController.dispose();
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
  final messageFormKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();
  final setNewPasswordFormKey = GlobalKey<FormState>();
  final editProfileFormKey = GlobalKey<FormState>();

  /// isFormValid form validation state flags for each form
  RxBool isUpdateEmailFormValid = false.obs;
  RxBool isMessageFormValid = false.obs;
  RxBool isChangePasswordFormValid = false.obs;
  RxBool isSetNewPasswordFormValid = false.obs;
  RxBool isEditProfileFormValid = false.obs;

  /// form validation utility methods to trigger validation (like in onChanged)
  void validateUpdateEmailForm() {
    isUpdateEmailFormValid.value =
        updateEmailFormKey.currentState?.validate() ?? false;
  }

  void validateMessageForm() {
    isMessageFormValid.value = 
        messageFormKey.currentState?.validate() ?? false;
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
    messageFormKey.currentState?.reset();
    isMessageFormValid.value = false;
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

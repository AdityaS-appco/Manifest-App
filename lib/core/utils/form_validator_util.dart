/// ! author: @alok_singh
/// ! updated: 16-04-2025

import 'package:get/get.dart';
import 'package:manifest/core/l10n/app_strings.dart';

/// * A centralized class for form validation rules
class FormValidatorUtil {
  /// * Regular expressions for validation patterns
  static const String passwordPattern =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$';
  static const String namePattern = r'^[a-zA-Z\s]+$';
  static const String otpPattern = r'^\d+$';
  static const String contentNamePattern = r'^[a-zA-Z0-9\s]+$';
  static const String datePattern = r'^\d{2}/\d{2}/\d{4}$';
  static const String playlistNamePattern = r'^[a-zA-Z0-9\s]+$';
  static const String textParagraphPattern = r'^[a-zA-Z\s\-\.\,\!\&\"\?]+$';
  static const String messagePattern = r'^[a-zA-Z0-9\s@=+\-_&%$#@!?/\",.]+$';

  /// * Validates required fields
  static String? required(String? value,
      {String? fieldName, String? customErrorMessage}) {
    if (value == null || value.isEmpty) {
      return customErrorMessage ??
          (fieldName != null
              ? 'Please enter your $fieldName'
              : 'This field is required');
    }
    return null;
  }

  /// * Validates email format
  static String? email(String? value) {
    final requiredCheck = required(value, fieldName: 'email');
    if (requiredCheck != null) return requiredCheck;

    if (!GetUtils.isEmail(value!)) {
      return AppStrings.pleaseEnterYourValidEmail;
    }
    return null;
  }

  /// * Validates password with minimum length and specific requirements
  static String? password(String? value,
      {int minLength = 6,
      bool requireUppercase = false,
      bool requireLowercase = false,
      bool requireSpecialCharacter = false,
      bool requireDigit = false}) {
    final requiredCheck = required(value, fieldName: 'password');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length < minLength) {
      return AppStrings.passwordMustBeAtLeastSixChar;
    }

    // Check for spaces
    if (value.contains(' ')) {
      return 'Password cannot contain spaces';
    }

    /// * Constructs a regex pattern for password validation based on specified requirements.
    /// * If `requireDigit` is true, it requires at least one digit.
    /// * If `requireUppercase` is true, it requires at least one uppercase letter.
    /// * If `requireLowercase` is true, it requires at least one lowercase letter.
    /// * If `requireSpecialCharacter` is true, it requires at least one special character from the set @$!%*?&.
    /// * The final regex pattern is used to validate the password against these criteria.
    String regex = r'^';
    if (requireDigit) regex += r'(?=.*\d)';
    if (requireUppercase) regex += r'(?=.*[A-Z])';
    if (requireLowercase) regex += r'(?=.*[a-z])';
    if (requireSpecialCharacter) regex += r'(?=.*[@$!%*?&])';
    regex += r'[A-Za-z\d@$!%*?&]+$';

    // * Pattern validation for password
    if (!RegExp(regex).hasMatch(value)) {
      List<String> missingRequirements = [];
      if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
        missingRequirements.add('uppercase letter');
      }
      if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
        missingRequirements.add('lowercase letter');
      }
      if (requireDigit && !value.contains(RegExp(r'\d'))) {
        missingRequirements.add('number');
      }
      if (requireSpecialCharacter && !value.contains(RegExp(r'[@$!%*?&]'))) {
        missingRequirements.add('special character');
      }

      return 'Please include at least one ${missingRequirements.join(', ')} in your password.';
    }
    return null;
  }

  /// * Validates if passwords match
  static String? confirmPassword(String? value, String password) {
    final requiredCheck = required(value,
        fieldName: 'confirm password',
        customErrorMessage: 'Please confirm your password');
    if (requiredCheck != null) return requiredCheck;

    if (value != password) {
      return AppStrings.passwordDoesNotMatch;
    }
    return null;
  }

  /// * Validates name/title with max length
  static String? name(String? value, {int maxLength = 100}) {
    final requiredCheck = required(value, fieldName: 'name');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length > maxLength) {
      return 'Name must be less than $maxLength characters';
    }

    // * Pattern validation for name
    if (!RegExp(namePattern).hasMatch(value)) {
      return 'Name can only contain letters and spaces.';
    }
    return null;
  }

  /// * Validates OTP code
  static String? otp(String? value, {int length = 4}) {
    final requiredCheck = required(value, fieldName: 'OTP');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length != length) {
      return 'Please enter a valid $length-digit OTP';
    }

    // * Pattern validation for OTP
    if (!RegExp(otpPattern).hasMatch(value)) {
      return 'OTP must contain only digits.';
    }
    return null;
  }

  /// * Validates playlist name
  static String? playlistName(String? value) {
    final requiredCheck = required(value, fieldName: 'playlist name');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length > 100) {
      return 'Playlist name must be less than 100 characters';
    }

    // * Pattern validation for playlist name
    if (!RegExp(playlistNamePattern).hasMatch(value)) {
      return 'Playlist name can only contain letters, numbers, and spaces.';
    }
    return null;
  }

  /// * Validates collection name
  static String? collectionName(String? value) {
    final requiredCheck = required(value, fieldName: 'collection name');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length > 100) {
      return 'Collection name must be less than 100 characters';
    }

    // * Pattern validation for collection name
    if (!RegExp(playlistNamePattern).hasMatch(value)) {
      return 'Collection name can only contain letters, numbers, and spaces.';
    }
    return null;
  }

  /// * Validates track name
  static String? trackName(String? value) {
    final requiredCheck = required(value, fieldName: 'track name');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length > 100) {
      return 'Track name must be less than 100 characters';
    }

    // * Pattern validation for track name
    if (!RegExp(contentNamePattern).hasMatch(value)) {
      return 'Track name can only contain letters, numbers, and spaces.';
    }
    return null;
  }

  /// * Validates affirmation name
  static String? affirmationName(String? value) {
    final requiredCheck = required(value, fieldName: 'affirmation name');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length > 100) {
      return 'Affirmation name must be less than 100 characters';
    }

    // * Pattern validation for affirmation name
    if (!RegExp(contentNamePattern).hasMatch(value)) {
      return 'Affirmation name can only contain letters, numbers, and spaces.';
    }
    return null;
  }

  /// * Validates recording name
  static String? recordingName(String? value) {
    final requiredCheck = required(value, fieldName: 'recording name');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length > 100) {
      return 'Recording name must be less than 100 characters';
    }

    // * Pattern validation for recording name
    if (!RegExp(contentNamePattern).hasMatch(value)) {
      return 'Recording name can only contain letters, numbers, and spaces.';
    }
    return null;
  }

  /// * Validates reminder name
  static String? reminderName(String? value) {
    final requiredCheck = required(value, fieldName: 'reminder name');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length > 100) {
      return 'Reminder name must be less than 100 characters';
    }

    // * Pattern validation for reminder name - allows letters, numbers and spaces
    if (!RegExp(contentNamePattern).hasMatch(value)) {
      return 'Reminder name can only contain letters, numbers, and spaces.';
    }
    return null;
  }

  /// * Validates reminder affirmation text
  ///   - Only allows letters, spaces, and - . , ! & \" ?
  ///   - No numbers or other special characters
  ///   - Accepts minChar and maxChar
  static String? reminderAffirmationText(
    String? value, {
    int minChar = 2,
    int maxChar = 200,
  }) {
    final requiredCheck = required(value, fieldName: 'reminder affirmation');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length < minChar) {
      return 'Affirmation must be at least $minChar characters';
    }
    if (value.length > maxChar) {
      return 'Affirmation must be less than $maxChar characters';
    }

    // Regex: only letters, spaces, and - . , ! & \" ?
    if (!RegExp(textParagraphPattern).hasMatch(value)) {
      return "Affirmation can only contain letters, spaces, and - . , ! & \" ?";
    }
    return null;
  }

  /// * Validates date of birth
  static String? dateOfBirth(String? value) {
    final requiredCheck = required(value, fieldName: 'date of birth');
    if (requiredCheck != null) return requiredCheck;

    // * Pattern validation for date format (MM/DD/YYYY)
    if (!RegExp(datePattern).hasMatch(value!)) {
      return 'Please enter a valid date (MM/DD/YYYY)';
    }
    return null;
  }

  /// * Validates affirmation text
  static String? affirmation(String? value, {int maxLength = 200}) {
    final requiredCheck = required(value, fieldName: 'affirmation');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length > maxLength) {
      return 'Affirmation must be less than $maxLength characters';
    }
    return null;
  }
  /// * Validates message text
  ///   - Only allows letters, numbers, spaces, and common special characters
  ///   - Minimum length of 2 characters
  ///   - Required field
  static String? message(String? value) {
    final requiredCheck = required(value, fieldName: 'message');
    if (requiredCheck != null) return requiredCheck;

    if (value!.length < 2) {
      return 'Message must be at least 2 characters';
    }

    if (!RegExp(messagePattern).hasMatch(value)) {
      return 'Message can only contain letters, numbers, spaces, and common special characters';
    }
    return null;
  }
}
